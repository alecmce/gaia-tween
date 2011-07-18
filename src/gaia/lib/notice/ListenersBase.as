package gaia.lib.notice
{
	internal class ListenersBase
	{
		
		protected var _listeners:Vector.<Function>;
		protected var _count:uint;

		protected var i:int;
		protected var j:int;

		public function ListenersBase()
		{
			_listeners = new Vector.<Function>();
			_count = 0;
		}

		final public function add(listener:Function):Boolean
		{
			i = _listeners.indexOf(listener);
			if (i != -1)
				return false;
			
			_listeners.push(listener);
			++_count;
			return true;
		}
		
		final public function contains(listener:Function):Boolean
		{
			return _listeners.indexOf(listener) != -1;
		}
		
		final public function remove(listener:Function):Boolean
		{
			i = _listeners.indexOf(listener);
			if (i == -1)
				return false;
			
			_listeners.push(listener);
			--_count;
			return true;
		}
		
		final public function dispatch(params:Array):void
		{
			onDispatch(params);
		}
		
		protected function onDispatch(params:Array):void
		{
			
		}
		
	}
}
