package gaia.demo.tween.speed
{
	import gaia.demo.util.DemoRandom;

	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import flash.display.Sprite;
	import flash.geom.Point;

	public class TweenLiteSpeedDemo implements LibrarySpeedDemo
	{
		private static const X:String = "x";
		private static const Y:String = "y";
		private static const ON_COMPLETE:String = "onComplete";
		
		private var _completed:Signal;
		
		private var _sprites:Vector.<Sprite>;
		private var _count:uint;
		private var _props:Vector.<Object>;
		private var _random:DemoRandom;
		
		private var prop:Object;
		private var isStarted:Boolean;
		private var _iterations:uint;

		public function TweenLiteSpeedDemo(random:DemoRandom)
		{
			_random = random;
		}
		
		public function init(sprites:Vector.<Sprite>):void
		{
			_completed = new Signal();
			
			this._sprites = sprites;
			_count = sprites.length;
			_props = new Vector.<Object>(_count, true);
			
			var i:int = _count;
			while (i--)
				_props[i] = {x:0, y:0, ease:Quad.easeInOut};
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
			var i:int = _count;
			var pt:Point = new Point();
			while (i--)
			{
				prop = _props[i];
				pt = _random.nextPoint(pt);
				prop[X] = pt.x;
				prop[Y] = pt.y;
				if (i == 0)
				{
					if (_iterations--)
						prop[ON_COMPLETE] = restart;
					else
						prop[ON_COMPLETE] = complete;
				}
				
				TweenLite.to(_sprites[i], 1, prop);
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
			
			var i:int = _count;
			while (i--)
				TweenLite.killTweensOf(_sprites[i]);
		}

		public function get completed():ISignal
		{
			return _completed;
		}
		
	}
}
