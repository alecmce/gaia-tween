package gaia.lib.time
{
	import gaia.lib.time.pause.IntrinsictTimeStrategy;
	import asunit.asserts.assertTrue;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	
	public class IntrinsicTimeTest extends TimeTest
	{
		
		override protected function generateTime():PausableTime
		{
			return new PausableTime(new IntrinsictTimeStrategy());
		}
		
		[Test]
		public function time_resume_causes_no_jump():void
		{
			var timer:Timer = new Timer(200, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, async.add(onTimerComplete, 250));
			timer.start();
			
			value = time.now;
			time.pause();
		}
		private function onTimerComplete(event:TimerEvent):void
		{
			time.tick.addOnce(async.add(on_resume_tick, 100));
			time.resume();
		}
		private function on_resume_tick(t:uint):void
		{
			assertTrue(t - value < 200);
		}
		
	}
}
