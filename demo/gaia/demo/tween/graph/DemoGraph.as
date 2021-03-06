package gaia.demo.tween.graph
{
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import gaia.lib.tween.Tween;
	import gaia.lib.tween.Tweens;
	import gaia.lib.tween.form.PropertyTweenForm;
	import gaia.lib.tween.form.manager.TweenOverlapManager;

	
	public class DemoGraph extends Sprite
	{
		private const GRAPH_FIDELITY:uint = 1000;
		private const GRAPH_DX:Number = 1 / GRAPH_FIDELITY;
		
		[Embed(source="../../../../../bin/assets/helvetica.swf", symbol="helvetica")]
		private var helveticaFont:Class;
		
		private var _tweens:Tweens;
		private var _manager:TweenOverlapManager;
		private var _fade:Tween;
		
		private var _color:uint;
		
		private var _left:Number;
		private var _bottom:Number;
		private var _width:Number;
		private var _height:Number;
		
		private var _title:TextField;
		private var _line:Sprite;
		private var _linealt:Sprite;
		private var _focus:Sprite;
		private var _axes:Sprite;
		private var _ball:Sprite;
		
		private var _current:GraphVO;
		
		public function DemoGraph(tweens:Tweens, rect:Rectangle)
		{
			_tweens = tweens;
			_manager = new TweenOverlapManager();
			
			_left = rect.left;
			_bottom = rect.bottom;
			_width = rect.width;
			_height = rect.height;
			
			addChild(_title = titleText());
			addChild(_line = new Sprite());
			addChild(_linealt = new Sprite());
			addChild(_focus = new Sprite());
			addChild(_axes = drawAxes());
			addChild(_ball = generateBall());
			
			_ball.x = rect.right;
		}
		
		public function get current():GraphVO
		{
			return _current;
		}
		
		public function set current(vo:GraphVO):void
		{
			if (_current == vo)
				return;
			
			_current = vo;
			
			_title.text = vo.label;

			var graph:Vector.<Point> = calculateGraph(vo.fn);
			drawGraph(graph, vo.color);
			
			var ct:ColorTransform = _ball.transform.colorTransform;
			ct.color = vo.color;
			_ball.transform.colorTransform = ct;
			
			focus(0);
		}
		
		public function focus(x:Number):void
		{
			var y:Number = _current.fn(x);
			
			_focus.graphics.clear();
			_focus.graphics.lineStyle(1, _color);
			
			x = _left + x * _width;
			y = _bottom - y * _height;
			
			_focus.graphics.moveTo(x, _bottom);
			_focus.graphics.lineTo(x, y);
			
			_focus.graphics.moveTo(_left, y);
			_focus.graphics.lineTo(_left + _width, y);
			
			_focus.graphics.drawCircle(x, y, 5);
			
			_ball.y = y;
		}
		
		private function calculateGraph(ease:Function):Vector.<Point>
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
		
		private function drawGraph(points:Vector.<Point>, color:uint):void
		{
			if (_fade)
				_fade.cancel();

			_color = color;
			
			var tmp:Sprite = _linealt;
			_linealt = _line;
			_line = tmp;

			_fade = _tweens.add(new PropertyTweenForm(_linealt, {alpha:0}, _manager), 500);
			
			_line.graphics.clear();
			_line.alpha = 1;
			_line.graphics.lineStyle(2, color);
			
			var pt:Point = points[0];
			_line.graphics.moveTo(_left + pt.x * _width, _bottom - pt.y * _height);
			
			var len:uint = points.length;
			for (var i:int = 1; i < len; i++)
			{
				pt = points[i];
				_line.graphics.lineTo(_left + pt.x * _width, _bottom - pt.y * _height);
			}
			
			var ct:ColorTransform = _title.transform.colorTransform;
			ct.color = color;
			_title.transform.colorTransform = ct;
		}
		
		private function titleText():TextField
		{
			var tf:TextField;
			var ff:TextFormat;
			
			ff = new TextFormat();
			ff.font = "helvetica";
			ff.color = 0x000000;
			ff.size = 30;
			ff.align = TextFormatAlign.CENTER;
			
			tf = new TextField();
			tf.alpha = 0.5;
			tf.embedFonts = true;
			tf.selectable = false;
			tf.defaultTextFormat = ff;
			tf.x = _left;
			tf.y = _bottom - _height - 75;
			tf.width = _width - 200;
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			
			return tf;
		}
		
		private function drawAxes():Sprite
		{
			var sprite:Sprite = new Sprite();
			
			var tf:TextField;
			var ff:TextFormat;
			
			sprite.graphics.lineStyle(2, 0);
			sprite.graphics.moveTo(_left, _bottom - _height - 50);
			sprite.graphics.lineTo(_left, _bottom + 50);
			sprite.graphics.moveTo(_left, _bottom);
			sprite.graphics.lineTo(_left + _width, _bottom);

			ff = new TextFormat();
			ff.font = "helvetica";
			ff.color = 0x000000;
			ff.size = 15;
			ff.align = TextFormatAlign.CENTER;
			
			tf = new TextField();
			tf.embedFonts = true;
			tf.selectable = false;
			tf.defaultTextFormat = ff;
			tf.x = _left;
			tf.y = _bottom;
			tf.width = _width;
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			tf.text = "time";
			sprite.addChild(tf);
			
			tf = new TextField();
			tf.embedFonts = true;
			tf.selectable = false;
			tf.defaultTextFormat = ff;
			tf.x = _left;
			tf.y = _bottom;
			tf.width = _height;
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			tf.text = "proportion";
			tf.rotation = -90;
			tf.x -= tf.textHeight + 4;
			sprite.addChild(tf);
			
			return sprite;
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
