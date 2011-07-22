package gaia.demo.tween
{
	import gaia.lib.time.Timeline;
	import gaia.lib.tween.Tweens;
	import gaia.lib.tween.easing.Quad;
	import gaia.lib.tween.form.property.PropertyTweenForm;
	import gaia.lib.tween.form.property.PropertyTweenMap;
	import gaia.lib.tween.form.property.SimplePropertyTweenForm;
	import gaia.lib.util.Random;

	import com.bit101.components.PushButton;
	import com.bit101.components.Slider;

	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;

	[SWF(backgroundColor="#FFFFFF", frameRate="60", width="800", height="600")]
	public class TimelineDemo extends Sprite
	{
		private static const COUNT:uint = 2000;
		
		private var random:Random;
		private var map:PropertyTweenMap;
		private var sprites:Vector.<Sprite>;
		private var forms:Vector.<PropertyTweenForm>;
		
		private var time:Timeline;
		private var tweens:Tweens;
		
		private var play:PushButton;
		private var slider:Slider;
		
		public function TimelineDemo()
		{
			random = new Random();
			map = new PropertyTweenMap();
			sprites = generateSprites();
			forms = generateForms(createTemplate());
			
			time = new Timeline();
			time.tick.add(regulateTime);
			tweens = new Tweens(time, COUNT);
			
			generateTweens();
			
			slider = new Slider("horizontal", this, 400, 550, onSlider);
			slider.minimum = 0;
			slider.maximum = 3000;
			
			play = new PushButton(this, 200, 550, "play", onPlay);
		}

		private function onPlay(event:Event):void
		{
			time.play();
		}

		private function onSlider(event:Event):void
		{
			time.stop();
			time.now = slider.value;
		}

		private function regulateTime(now:uint):void
		{
			slider.value = now;
			if (now >= 3000)
			{
				time.now = 3000;
				time.stop();
			}
		}

		private function generateTweens():void
		{
			var i:int = COUNT;
			while (i--)
				tweens.add(forms[i], 3000, 0, Quad.easeOut);
		}
		
		private function generateForms(template:BitmapData):Vector.<PropertyTweenForm>
		{
			var forms:Vector.<PropertyTweenForm> = new Vector.<PropertyTweenForm>(COUNT, true);
			
			var i:int = COUNT;
			while (i--)
			{
				do
				{
					var x:int = random.nextInt(700) + 50;
					var y:int = random.nextInt(500) + 50;
				}
				while (template.getPixel32(x, y) != 0xFF000000);
				
				forms[i] = new SimplePropertyTweenForm(sprites[i], {x:x, y:y}, map);
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
			s.graphics.beginFill(0x9900FF);
			s.graphics.drawCircle(0, 0, 2);
			s.graphics.endFill();
			
			s.x = random.nextInt(700) + 50;
			s.y = random.nextInt(500) + 50;
			
			addChild(s);
			return s;
		}
		
	}
}
