package gaia.demo.tween
{
	import gaia.lib.util.Random;

	import com.bit101.components.PushButton;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="800", height="600")]
	public class TweenDemoMain extends Sprite
	{
		private static const COUNT:int = 1000;
		
		private var random:Random;
		private var sprites:Vector.<Sprite>;
		
		private var _gaia:TweenDemo;
		private var _tweenlite:TweenDemo;
		
		public function TweenDemoMain()
		{
			random = new Random();
			sprites = new Vector.<Sprite>(COUNT, true);
			
			var i:int = COUNT;
			while (i--)
			{
				var sprite:Sprite = generateSprite();
				sprites[i] = sprite;
				addChild(sprite);
			}
			
			_gaia = new GaiaTweenDemo();
			_gaia.init(sprites);
			
			_tweenlite = new TweenLiteDemo();
			_tweenlite.init(sprites);
			
			new PushButton(this, 5, 5, "gaia-tween", onGaiaTween);
			new PushButton(this, 5, 30, "TweenLite", onTweenLite);
		}
		
		private function onGaiaTween(event:MouseEvent):void
		{
			_tweenlite.stop();
			_gaia.start();
		}
		
		private function onTweenLite(event:MouseEvent):void
		{
			_gaia.stop();
			_tweenlite.start();
		}

		private function generateSprite():Sprite
		{
			var s:Sprite = new Sprite();
			s.graphics.beginFill(0x9900FF);
			s.graphics.drawCircle(0, 0, 2);
			s.graphics.endFill();
			
			s.x = random.nextInt(700) + 50;
			s.y = random.nextInt(500) + 50;
			
			return s;
		}
	}
}
