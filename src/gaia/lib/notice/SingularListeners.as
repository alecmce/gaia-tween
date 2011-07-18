package gaia.lib.notice
{
	final internal class SingularListeners extends ListenersBase
	{
		
		override protected function onDispatch(params:Array):void
		{
			var listeners:Vector.<Function> = _listeners.slice();
			j = _count;
			
			_listeners.length = 0;
			_count = 0;
			
			while (j--)
				listeners[j].apply(null, params);
		}
		
	}
}
