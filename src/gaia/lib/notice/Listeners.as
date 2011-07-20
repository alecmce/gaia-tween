package gaia.lib.notice
{
	final internal class Listeners
	{
		
		private var _dimension:uint;
		
		private var _size:uint;
		private var _listeners:Vector.<Function>;
		private var _count:uint;
		
		private var _lock:Boolean;
		private var _removals:Vector.<uint>;

		private var i:int, j:int;

		public function Listeners()
		{
			_dimension = 1;
			_size = 1 << _dimension;
			_listeners = new Vector.<Function>(_size, true);
			_count = 0;
			
			_removals = new Vector.<uint>();
		}

		public function add(listener:Function):Boolean
		{
			var i:int = _listeners.indexOf(listener);
			if (i != -1)
				return false;
			
			if (_count == _size)
			{
				_size = 1 << ++_dimension;
				
				_listeners.fixed = false;
				_listeners.length = _size;
				_listeners.fixed = true;
			}
			
			_listeners[_count++] = listener;
			return true;
		}
		
		public function contains(listener:Function):Boolean
		{
			return _listeners.indexOf(listener) != -1;
		}
		
		public function remove(listener:Function):Boolean
		{
			var i:int = _listeners.indexOf(listener);
			if (i == -1)
				return false;
			
			if (_lock)
			{
				_removals.push(i);
				return true;
			}
			
			_listeners[i] = _listeners[--_count];
			_listeners[_count] = null;
			return true;
		}
		
		public function dispatch(params:Array):void
		{
			_lock = true;
			
			i = _count;
			while (i--)
				_listeners[i].apply(null, params);
			
			_lock = false;
			
			i = _removals.length;
			if (i == 0)
				return;
			
			while (i--)
			{
				j = _removals[i];
				_listeners[j] = _listeners[--_count];
				_listeners[_count] = null;
			}
			
			_removals.length = 0;
		}
		
	}
}
