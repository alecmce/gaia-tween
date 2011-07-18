package gaia.lib.time
{
	import gaia.lib.notice.Notice;
	
	public interface Time
	{
		
		function get now():uint;
		
		function get tick():Notice;
		
	}
}
