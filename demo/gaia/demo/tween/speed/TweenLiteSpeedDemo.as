package gaia.demo.tween.speed
{
	import gaia.lib.util.Random;

	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import flash.display.Sprite;

	public class TweenLiteSpeedDemo implements LibrarySpeedDemo
	{
		private static const X:String = "x";
		private static const Y:String = "y";
		private static const ON_COMPLETE:String = "onComplete";
		
		private var _completed:Signal;
		
		private var sprites:Vector.<Sprite>;
		private var count:uint;
		private var props:Vector.<Object>;
		private var random:Random;
		
		private var prop:Object;
		private var isStarted:Boolean;
		private var _iterations : uint;

		public function TweenLiteSpeedDemo(random:Random)
		{
			this.random = random;
		}

		
		public function init(sprites:Vector.<Sprite>):void
		{
			_completed = new Signal();
			
			this.sprites = sprites;
			count = sprites.length;
			props = new Vector.<Object>(count, true);
			
			var i:int = count;
			while (i--)
				props[i] = {x:0, y:0, ease:Quad.easeInOut};
		}

		public function start(iterations:uint):void
		{
			if (isStarted)
				return;
			
			isStarted = true;
			_iterations = iterations;
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
				{
					if (_iterations--)
						prop[ON_COMPLETE] = restart;
					else
						prop[ON_COMPLETE] = complete;
				}
				
				TweenLite.to(sprites[i], 1, prop);
			}
		}

		private function complete():void
		{
			isStarted = false;
			_completed.dispatch();
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

		public function get completed():ISignal
		{
			return _completed;
		}
		
	}
}
