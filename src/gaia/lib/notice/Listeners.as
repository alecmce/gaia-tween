package gaia.lib.notice
{
	final internal class Listeners extends ListenersBase
	{
		
		override protected function onDispatch(params:Array):void
		{
			var listeners:Vector.<Function> = _listeners.slice();
			
			j = _count;
			while (j--)
				listeners[j].apply(null, params);
		}
		
	}
}
