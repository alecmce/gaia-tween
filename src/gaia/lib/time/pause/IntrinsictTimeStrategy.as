package gaia.lib.time.pause
{
	
	final public class IntrinsictTimeStrategy implements PauseStrategy
	{

		public function getTimeAtResume(timeAtPause:uint, pauseDuration:int):uint
		{
			return timeAtPause + pauseDuration;
		}
		
	}
}
