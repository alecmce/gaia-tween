package gaia.demo.tween
{
	import gaia.demo.tween.graph.DemoGraph;
	import gaia.lib.time.SimpleTime;
	import gaia.lib.tween.Tween;
	import gaia.lib.tween.Tweens;
	import gaia.lib.tween.easing.Back;
	import gaia.lib.tween.easing.Bounce;
	import gaia.lib.tween.easing.Circ;
	import gaia.lib.tween.easing.Cubic;
	import gaia.lib.tween.easing.Expo;
	import gaia.lib.tween.easing.Quad;
	import gaia.lib.tween.easing.Quart;
	import gaia.lib.tween.easing.Quint;
	import gaia.lib.tween.easing.Sine;
	import gaia.lib.tween.form.manager.TweenOverlapManager;
	import gaia.lib.tween.form.method.MethodTweenForm;
	import gaia.lib.tween.form.motion.MotionTweenForm;

	import com.bit101.components.PushButton;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	[SWF(backgroundColor="#FFFFFF", frameRate="60", width="800", height="600")]
	public class EaseDemo extends Sprite
	{
		private static const TWEEN_DURATION:uint = 3000;
		
		private const GRAPH_FIDELITY:uint = 1000;
		private const GRAPH_DX:Number = 1 / GRAPH_FIDELITY;
		
		private var _time:SimpleTime;
		private var _tweens:Tweens;
		private var _manager:TweenOverlapManager;
		
		private var _graph:DemoGraph;
		private var _ball:Sprite;
		
		private var _example:MotionTweenForm;
		private var _updateGraph:MethodTweenForm;
		
		private var _buttonMap:Dictionary;
		private var _colorMap:Dictionary;
		private var _labelMap:Dictionary;
		
		private var _ease:Function;
		private var _exampleTween:Tween;
		private var _graphTween:Tween;
		private var _color:uint;
		
		public function EaseDemo()
		{
			_time = new SimpleTime();
			_tweens = new Tweens(_time, 2);
			_manager = new TweenOverlapManager();
			
			addChild(_graph = new DemoGraph(_tweens, new Rectangle(250, 100, 500, 400)));
			addChild(_ball = generateBall());
			
			_ball.x = 750; _ball.y = 500;
			
			_example = new MotionTweenForm(_ball, 750, 100, _manager);
			_updateGraph = new MethodTweenForm(updateGraph);
			
			selectEase(Quad.easeInOut, 0x1E90FF);
			_graph.title = "Quad.easeInOut";
			
			_buttonMap = new Dictionary();
			_colorMap = new Dictionary();
			_labelMap = new Dictionary();
			
			defineButton(5, 5, "Back.easeIn", Back.easeIn, 0xFF0000);
			defineButton(5, 30, "Back.easeOut", Back.easeOut, 0xFF0000);
			defineButton(5, 55, "Back.easeInOut", Back.easeInOut, 0xFF0000);
			defineButton(5, 80, "Bounce.easeIn", Bounce.easeIn, 0xFF6600);
			defineButton(5, 105, "Bounce.easeOut", Bounce.easeOut, 0xFF6600);
			defineButton(5, 130, "Bounce.easeInOut", Bounce.easeInOut, 0xFF6600);
			defineButton(5, 155, "Circ.easeIn", Circ.easeIn, 0xDDBB00);
			defineButton(5, 180, "Circ.easeOut", Circ.easeOut, 0xDDBB00);
			defineButton(5, 205, "Circ.easeInOut", Circ.easeInOut, 0xDDBB00);
			defineButton(5, 230, "Cubic.easeIn", Cubic.easeIn, 0x99EE00);
			defineButton(5, 255, "Cubic.easeOut", Cubic.easeOut, 0x99EE00);
			defineButton(5, 280, "Cubic.easeInOut", Cubic.easeInOut, 0x99EE00);
			defineButton(5, 305, "Expo.easeIn", Expo.easeIn, 0x009900);
			defineButton(5, 330, "Expo.easeOut", Expo.easeOut, 0x009900);
			defineButton(5, 355, "Expo.easeInOut", Expo.easeInOut, 0x009900);
			defineButton(5, 380, "Quad.easeIn", Quad.easeIn, 0x1E90FF);
			defineButton(5, 405, "Quad.easeOut", Quad.easeOut, 0x1E90FF);
			defineButton(5, 430, "Quad.easeInOut", Quad.easeInOut, 0x1E90FF);
			defineButton(5, 455, "Quart.easeIn", Quart.easeIn, 0x6666FF);
			defineButton(5, 480, "Quart.easeOut", Quart.easeOut, 0x6666FF);
			defineButton(5, 505, "Quart.easeInOut", Quart.easeInOut, 0x6666FF);
			defineButton(110, 5, "Quint.easeIn", Quint.easeIn, 0x9900FF);
			defineButton(110, 30, "Quint.easeOut", Quint.easeOut, 0x9900FF);
			defineButton(110, 55, "Quint.easeInOut", Quint.easeInOut, 0x9900FF);
			defineButton(110, 80, "Sine.easeIn", Sine.easeIn, 0xFF0099);
			defineButton(110, 105, "Sine.easeOut", Sine.easeOut, 0xFF0099);
			defineButton(110, 130, "Sine.easeInOut", Sine.easeInOut, 0xFF0099);
		}

		private function defineButton(x:int, y:int, label:String, ease:Function, color:uint):void
		{
			var button:PushButton;
			var ct:ColorTransform;
			
			button = new PushButton(this, x, y, label, onButtonClick);
			
			ct = button.getChildAt(1).transform.colorTransform;
			ct.color = color;
			button.getChildAt(1).transform.colorTransform = ct;
			
			ct = new ColorTransform();
			ct.color = 0x000000;
			button.getChildAt(0).transform.colorTransform = ct;
			button.getChildAt(2).transform.colorTransform = ct;
			
			_buttonMap[button] = ease;
			_colorMap[button] = color;
			_labelMap[button] = label;
		}

		private function onButtonClick(event:MouseEvent):void
		{
			var button:PushButton = event.currentTarget as PushButton;
			_color = _colorMap[button];
			selectEase(_buttonMap[button], _color);
			_graph.title = _labelMap[button];
		}
		
		private function selectEase(ease:Function, color:uint):void
		{
			_ease = ease;
			_graph.plot(getPlot(ease), color);
			
			if (_exampleTween)
				_exampleTween.cancel();
			
			if (_graphTween)
				_graphTween.cancel();
			
			var ct:ColorTransform = _ball.transform.colorTransform;
			ct.color = color;
			_ball.transform.colorTransform = ct;
			
			restart();
		}
		
		private function restart(tween:Tween = null):void
		{
			_ball.x = 750; _ball.y = 500;
			
			_exampleTween = _tweens.add(_example, TWEEN_DURATION, 0, _ease);
			_exampleTween.completed.addOnce(restart);
			
			_graphTween = _tweens.add(_updateGraph, TWEEN_DURATION, 0);
		}
		
		private function getPlot(ease:Function):Vector.<Point>
		{
			var pts:Vector.<Point> = new Vector.<Point>(GRAPH_FIDELITY + 1, true);
			
			var x:Number = 1;
			var i:uint = GRAPH_FIDELITY + 1;
			while (i--)
			{
				x = i * GRAPH_DX;
				pts[i] = new Point(x, ease(x));
			}
			
			return pts;
		}
		
		private function updateGraph(proportion:Number):void
		{
			_graph.focus(proportion, _ease(proportion));
		}
		
		private function generateBall():Sprite
		{
			var sprite:Sprite = new Sprite();
			
			sprite.graphics.beginFill(0xFFFFFF);
			sprite.graphics.drawCircle(0, 0, 5);
			sprite.graphics.endFill();
			
			return sprite;
		}
		
	}
}
