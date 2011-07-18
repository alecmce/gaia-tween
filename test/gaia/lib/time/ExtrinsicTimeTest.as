package gaia.lib.time
{
	import asunit.asserts.assertTrue;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class ExtrinsicTimeTest extends TimeTest
	{
		
		override protected function generateTime():Time
		{
			return new ExtrinsicTime();
		}
		
		[Test]
		public function time_resume_causes_a_jump():void
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
			assertTrue(t - value > 200);
		}
		
		
	}
}
