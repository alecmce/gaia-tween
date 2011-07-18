package gaia.lib.time
{
	
	final public class IntrinsicTime extends TimeBase implements Time
	{

		override protected function onResume(offset:uint, pauseTime:int):uint
		{
			return offset + pauseTime;
		}
		
	}
}
