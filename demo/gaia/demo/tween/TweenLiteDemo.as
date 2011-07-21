package gaia.demo.tween
{
	import gaia.lib.util.Random;

	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;

	import flash.display.Sprite;

	public class TweenLiteDemo implements TweenDemo
	{
		
		private static const X:String = "x";
		private static const Y:String = "y";
		private static const ON_COMPLETE:String = "onComplete";
		
		private var sprites:Vector.<Sprite>;
		private var count:uint;
		private var props:Vector.<Object>;
		private var random:Random;
		
		private var prop:Object;
		
		private var isStarted:Boolean;
		
		public function init(sprites:Vector.<Sprite>):void
		{
			this.sprites = sprites;
			count = sprites.length;
			props = new Vector.<Object>(count, true);
			random = new Random();
			
			var i:int = count;
			while (i--)
				props[i] = {x:0, y:0, ease:Quad.easeInOut};
		}

		public function start():void
		{
			if (isStarted)
				return;
			
			isStarted = true;
			restart();
		}

		private function restart(t:TweenLite = null):void
		{
			var i:int = count;
			while (i--)
			{
				prop = props[i];
				prop[X] = random.nextInt(700) + 50;
				prop[Y] = random.nextInt(500) + 50;
				if (i == 0)
					prop[ON_COMPLETE] = restart;
				
				TweenLite.to(sprites[i], 1, prop);
			}
		}

		public function stop():void
		{
			if (!isStarted)
				return;
			
			isStarted = false;
			
			var i:int = count;
			while (i--)
				TweenLite.killTweensOf(sprites[i]);
		}
		
	}
}
