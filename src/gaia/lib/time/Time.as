package gaia.lib.time
{
	import gaia.lib.notice.Notice;
	
	public interface Time
	{
		
		function get now():uint;
		
		function pause():void;
		
		function resume():void;

		function get tick():Notice;
		
	}
}
