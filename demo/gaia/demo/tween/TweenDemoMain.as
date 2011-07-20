package gaia.demo.tween
{
	import gaia.lib.util.Random;

	import flash.display.Sprite;

	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="800", height="600")]
	public class TweenDemoMain extends Sprite
	{
		private static const COUNT:int = 1000;
		
		private var random:Random;
		private var sprites:Vector.<Sprite>;
		
		private var _demo:TweenDemo;
		
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
			
			init();
		}

		private function init():void
		{
			_demo = new GaiaTweenDemo();
			_demo.init(sprites);
			_demo.start();
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
