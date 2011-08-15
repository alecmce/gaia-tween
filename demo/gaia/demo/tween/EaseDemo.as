package gaia.demo.tween
{
	import gaia.demo.tween.graph.DemoGraph;
	import gaia.demo.tween.graph.GraphVO;
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
	import gaia.lib.tween.form.MethodTweenForm;

	import com.bit101.components.PushButton;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	[SWF(backgroundColor="#FFFFFF", frameRate="60", width="800", height="600")]
	public class EaseDemo extends Sprite
	{
		private static const TWEEN_DURATION:uint = 3000;
		
		private var _time:SimpleTime;
		private var _tweens:Tweens;
		
		private var _graph:DemoGraph;
		
		private var _buttonMap:Dictionary;
		
		private var _updateGraph:MethodTweenForm;
		private var _graphTween:Tween;
		
		public function EaseDemo()
		{
			_time = new SimpleTime();
			_tweens = new Tweens(_time, 2);
			
			addChild(_graph = new DemoGraph(_tweens, new Rectangle(250, 100, 500, 400)));
			
			_updateGraph = new MethodTweenForm(updateGraph);
			
			createButtons();
		}
		
		private function createButtons():void
		{
			var defaultVO:GraphVO;
			var vos:Vector.<GraphVO> = new Vector.<GraphVO>();
			vos.push(new GraphVO(Back.easeIn, "Back.easeIn", 0xFF0000));
			vos.push(new GraphVO(Back.easeOut, "Back.easeOut", 0xFF0000));
			vos.push(new GraphVO(Back.easeInOut, "Back.easeInOut", 0xFF0000));
			vos.push(new GraphVO(Bounce.easeIn, "Bounce.easeIn", 0xFF6600));
			vos.push(new GraphVO(Bounce.easeOut, "Bounce.easeOut", 0xFF6600));
			vos.push(new GraphVO(Bounce.easeInOut, "Bounce.easeInOut", 0xFF6600));
			vos.push(new GraphVO(Circ.easeIn, "Circ.easeIn", 0xDDBB00));
			vos.push(new GraphVO(Circ.easeOut, "Circ.easeOut", 0xDDBB00));
			vos.push(new GraphVO(Circ.easeInOut, "Circ.easeInOut", 0xDDBB00));
			vos.push(new GraphVO(Cubic.easeIn, "Cubic.easeIn", 0x33CC33));
			vos.push(new GraphVO(Cubic.easeOut, "Cubic.easeOut", 0x33CC33));
			vos.push(new GraphVO(Cubic.easeInOut, "Cubic.easeInOut", 0x33CC33));
			vos.push(new GraphVO(Expo.easeIn, "Expo.easeIn", 0x009900));
			vos.push(new GraphVO(Expo.easeOut, "Expo.easeOut", 0x009900));
			vos.push(new GraphVO(Expo.easeInOut, "Expo.easeInOut", 0x009900));
			vos.push(new GraphVO(Quad.easeIn, "Quad.easeIn", 0x1E90FF));
			vos.push(new GraphVO(Quad.easeOut, "Quad.easeOut", 0x1E90FF));
			vos.push(defaultVO = new GraphVO(Quad.easeInOut, "Quad.easeInOut", 0x1E90FF));
			vos.push(new GraphVO(Quart.easeIn, "Quart.easeIn", 0x6666FF));
			vos.push(new GraphVO(Quart.easeOut, "Quart.easeOut", 0x6666FF));
			vos.push(new GraphVO(Quart.easeInOut, "Quart.easeInOut", 0x6666FF));
			vos.push(new GraphVO(Quint.easeIn, "Quint.easeIn", 0x9900FF));
			vos.push(new GraphVO(Quint.easeOut, "Quint.easeOut", 0x9900FF));
			vos.push(new GraphVO(Quint.easeInOut, "Quint.easeInOut", 0x9900FF));
			vos.push(new GraphVO(Sine.easeIn, "Sine.easeIn", 0xFF0099));
			vos.push(new GraphVO(Sine.easeOut, "Sine.easeOut", 0xFF0099));
			vos.push(new GraphVO(Sine.easeInOut, "Sine.easeInOut", 0xFF0099));
			
			_buttonMap = new Dictionary();
			var i:uint = vos.length;
			while (i--)
				defineButton(i, vos[i]);
			
			select(defaultVO);
		}

		private function defineButton(i:uint, vo:GraphVO):void
		{
			var y:int = 5 + i * 25;
			var x:int = 5;
			
			while (y > 505)
			{
				x += 110;
				y -= 525;
			}
			
			var button:PushButton;
			var ct:ColorTransform;
			
			button = new PushButton(this, x, y, vo.label, onButtonClick);
			
			ct = button.getChildAt(1).transform.colorTransform;
			ct.color = vo.color;
			button.getChildAt(1).transform.colorTransform = ct;
			
			ct = new ColorTransform();
			ct.color = 0x000000;
			button.getChildAt(0).transform.colorTransform = ct;
			button.getChildAt(2).transform.colorTransform = ct;
			
			_buttonMap[button] = vo;
		}

		private function onButtonClick(event:MouseEvent):void
		{
			var vo:GraphVO = _buttonMap[event.currentTarget];
			select(vo);
		}
		
		private function select(vo:GraphVO):void
		{
			if (_graph.current == vo)
				return;
			
			_graph.current = vo;
			
			if (_graphTween)
				_graphTween.cancel();
			
			restart();
		}
		
		private function restart(tween:Tween = null):void
		{
			_graphTween = _tweens.add(_updateGraph, TWEEN_DURATION, 0);
			_graphTween.completed.addOnce(restart);
		}
		
		private function updateGraph(proportion:Number):void
		{
			_graph.focus(proportion);
		}
		
	}
}