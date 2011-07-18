package gaia.lib.tween
{
	import gaia.lib.time.Time;
	
	final public class Tweens
	{
		private var _time:Time;
		private var _pool:TweenPool;
		private var _count:uint;
		
		public function Tweens(time:Time, initialDimension:uint = 5)
		{
			_time = time;
			_pool = new TweenPool(initialDimension);
		}
		
		public function add(form:TweenForm, duration:uint, delay:uint = 0, ease:Function = null):Tween
		{
			var start:uint = _time.now + delay;
			var end:uint = start + duration;

			var tween:Tween = _pool.require();
			tween.init(form, start, end, ease);
			
			if (++_count == 1)
				_time.tick.add(_pool.iterate);
			
			return tween;
		}
		
		public function remove(tween:Tween):Boolean
		{	
			if (--_count == 0)
				_time.tick.remove(_pool.iterate);
			
			return true;
		}
		
	}
}
