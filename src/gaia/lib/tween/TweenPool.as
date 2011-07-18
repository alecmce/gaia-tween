package gaia.lib.tween
{
	
	final internal class TweenPool
	{
		private var _dimension:uint;
		private var _length:uint;
		private var _list:Vector.<Tween>;
		private var _count:uint;
		
		private var i:uint, n:uint;
		private var tween:Tween;
		
		public function TweenPool(initialDimension:uint)
		{
			_dimension = initialDimension;
			_length = 1 << _dimension;
			_list = new Vector.<Tween>(_length, true);
			_count = 0;

			var i:uint = _length;
			while (i--)
				_list[i] = new Tween(this);
		}
		
		public function require():Tween
		{
			if (_count == _length)
			{
				_length = 1 << ++_dimension;
				_list.fixed = false;
				_list.length = _length;
				_list.fixed = true;
			}

			var tween:Tween = _list[_count] ||= new Tween(this);
			tween.onRequired(_count++);
			
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
				}
			}
			
			i = _count;
			while (i-- > n)
			{
				tween = _list[i];
				tween.finalize();
			}
		}
		
		// called by Tween
		internal function onReleased(tween:Tween, index:uint):void
		{
			_list[index] = _list[--_count];
			_list[_count] = tween;
		}
		
	}
}
