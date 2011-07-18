package gaia.lib.time.pause
{
	public interface PauseStrategy
	{
		
		function getTimeAtResume(timeAtPause:uint, pauseDuration:int):uint;
		
	}
}
