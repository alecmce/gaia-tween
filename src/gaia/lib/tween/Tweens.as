package gaia.lib.tween
{
	import gaia.lib.time.Time;
	import gaia.lib.tween.form.TweenForm;
	
	final public class Tweens
	{
		private var _time:Time;
		
		private var _dimension:uint;
		private var _length:uint;
		private var _list:Vector.<Tween>;
		private var _count:uint;
		
		private var i:uint, n:uint;
		private var tween:Tween;
		
		public function Tweens(time:Time, initialCount:uint)
		{
			_time = time;
			
			_dimension = Math.ceil(Math.log(initialCount) * Math.LOG2E);
			_length = 1 << _dimension;
			_list = new Vector.<Tween>(_length, true);
			_count = 0;
			
			var i:uint = initialCount;
			while (i--)
				_list[i] = new Tween(this);
		}
		
		public function add(form:TweenForm, duration:uint, delay:uint = 0, ease:Function = null):Tween
		{
			var start:uint = _time.now + delay;
			var end:uint = start + duration;

			if (_count == _length)
			{
				_length = 1 << ++_dimension;
				_list.fixed = false;
				_list.length = _length;
				_list.fixed = true;
			}

			var tween:Tween = _list[_count] ||= new Tween(this);
			tween.init(form, start, end, ease, _count);
			
			if (++_count == 1)
				_time.tick.add(iterate);
			
			return tween;
		}
		
		public function iterate(time:uint):void
		{
			n = i = _count;
			while (i--)
			{
				tween = _list[i];
				if (tween.update(time))
				{
					_list[i] = _list[--n];
					_list[n] = tween;
					tween.complete();
				}
			}
			
			i = _count;
			_count = n;
			
			while (i-- > n)
			{
				tween = _list[i];
				tween.dispatch();
			}
			
			if (_count == 0)
				_time.tick.remove(iterate);
		}
		
		internal function onCancelled(tween:Tween, index:uint):void
		{
			_list[index] = _list[--_count];
			_list[_count] = tween;
		}
		
	}
}
