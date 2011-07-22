package gaia.lib.time
{
	import org.osflash.signals.ISignal;
	
	public interface Time
	{
		
		function get now():uint;
		
		function get tick():ISignal;
		
	}
}
