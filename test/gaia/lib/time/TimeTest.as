package gaia.lib.time
{
	import asunit.asserts.assertTrue;
	import asunit.asserts.fail;
	import asunit.framework.Async;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	
	public class TimeTest
	{
		[Inject]
		public var async:Async;
		
		protected var time:Time;
		protected var value:uint;
		
		[Before]
		final public function before():void
		{
			time = generateTime();
		}

		[After]
		public function after():void
		{
			time = null;
		}
		
		protected function generateTime():Time
		{
			return null;
		}
		
		[Test]
		public function can_reference_time_directly():void
		{
			assertTrue(time.now >= 0);
		}
		
		[Test]
		public function has_tick_signal():void
		{
			time.tick.addOnce(async.add(on_tick, 100));
		}
		private function on_tick(t:uint):void
		{
			// do nothing
		}
				
		[Test]
		public function tick_value_increments_per_frame():void
		{
			time.tick.addOnce(async.add(on_tick_increment_1, 100));
		}
		private function on_tick_increment_1(t:uint):void
		{
			value = t;
			time.tick.addOnce(async.add(on_tick_increment_2, 100));
		}
		private function on_tick_increment_2(t:uint):void
		{
			assertTrue(t > value);
		}
		
		[Test]
		public function when_paused_tick_stops():void
		{
			var timer:Timer = new Timer(200, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			timer.start();
			
			time.pause();
			time.tick.addOnce(on_tick_while_paused);
		}
		private function on_tick_while_paused(t:uint):void
		{
			fail("shouldn't be a tick while paused");
		}
		private function onTimerComplete(event:TimerEvent):void
		{
			// do nothing
		}
		
	}
}
