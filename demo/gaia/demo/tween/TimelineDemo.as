package gaia.demo.tween
{
	import com.bit101.components.PushButton;
	import com.bit101.components.Slider;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import gaia.demo.util.DemoRandom;
	import gaia.lib.time.Timeline;
	import gaia.lib.tween.Tween;
	import gaia.lib.tween.Tweens;
	import gaia.lib.tween.easing.Quad;
	import gaia.lib.tween.form.PropertyTweenForm;
	import gaia.lib.tween.form.manager.TweenOverlapManager;





	[SWF(backgroundColor="#FFFFFF", frameRate="60", width="800", height="600")]
	public class TimelineDemo extends Sprite
	{
		private static const COUNT:uint = 3000;
		private static const TIME:uint = 1000;
		
		private var _random:DemoRandom;
		private var _manager:TweenOverlapManager;
		private var _sprites:Vector.<Sprite>;
		private var _forms:Vector.<PropertyTweenForm>;
		
		private var _time:Timeline;
		private var _tweens:Tweens;
		
		private var _play:PushButton;
		private var _slider:Slider;
		
		public function TimelineDemo()
		{
			_random = new DemoRandom(new Rectangle(20, 20, stage.stageWidth - 40, stage.stageHeight - 40));
			_manager = new TweenOverlapManager();
			_sprites = generateSprites();
			_forms = generateForms(createTemplate());
			
			_time = new Timeline();
			_time.tick.add(regulateTime);
			_tweens = new Tweens(_time, COUNT);
			
			generateTweens();
			
			_slider = new Slider("horizontal", this, 405, 565, onSlider);
			_slider.minimum = 0;
			_slider.maximum = TIME;
			
			_play = new PushButton(this, 300, 560, "play", onPlay);
		}

		private function onPlay(event:Event):void
		{
			if (_time.speed)
			{
				_play.label = "play";
				_time.stop();
			}
			else
			{
				_play.label = "stop";
				_time.play();
				
				if (_time.now >= TIME)
					_time.now = 0;
			}
		}

		private function onSlider(event:Event):void
		{
			_time.stop();
			_time.now = _slider.value;
		}

		private function regulateTime(now:uint):void
		{
			_slider.value = now;
			if (now >= TIME)
			{
				_time.now = TIME;
				_time.stop();
				_play.label = "restart";
			}
		}

		private function generateTweens():void
		{
			var i:int = COUNT;
			while (i--)
			{
				var tween:Tween = _tweens.add(_forms[i], TIME, 0, Quad.easeOut);
				tween.autoComplete = false;
			}
		}
		
		private function generateForms(template:BitmapData):Vector.<PropertyTweenForm>
		{
			var forms:Vector.<PropertyTweenForm> = new Vector.<PropertyTweenForm>(COUNT, true);
			var pt:Point = new Point();
			
			var i:int = COUNT;
			while (i--)
			{
				do
				{
					pt = _random.nextPoint(pt);
				}
				while (template.getPixel32(pt.x | 0, pt.y | 0) != 0xFF000000);
				
				forms[i] = new PropertyTweenForm(_sprites[i], {x:pt.x, y:pt.y}, _manager);
			}
			
			return forms;
		}
		
		private function createTemplate():BitmapData
		{
			var bd:BitmapData = new BitmapData(800, 600, true, 0x00000000);
			
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat("_sans", 500, 0xFF000000, true);
			tf.width = 800;
			tf.height = 140;
			tf.text = "hello!";
			
			bd.draw(tf, new Matrix(2, 0, 0, 2, 50, 115));
			
			return bd;
		}
		
		private function generateSprites():Vector.<Sprite>
		{
			var sprites:Vector.<Sprite> = new Vector.<Sprite>(COUNT, true);
			
			var i:int = COUNT;
			while (i--)
				sprites[i] = generateSprite();
				
			return sprites;
		}
		
		private function generateSprite():Sprite
		{
			var s:Sprite = new Sprite();
			s.graphics.beginFill(_random.nextColor());
			s.graphics.drawCircle(0, 0, 2);
			s.graphics.endFill();

			var pt:Point = _random.nextPoint();
			s.x = pt.x;
			s.y = pt.y;
			
			addChild(s);
			return s;
		}
		
	}
}
