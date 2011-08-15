package gaia.lib.tween
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertTrue;
	import asunit.framework.Async;

	import gaia.lib.time.SimpleTime;
	import gaia.lib.time.Time;

	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class ReversibleTweensTest
	{
		private var time:Time;
		private var tweens:Tweens;
		private var mock:MockTweenForm;
		private var tween:Tween;
		private var count:uint;
		
		[Inject]
		public var async:Async;
		
		[Before]
		public function before():void
		{
			time = new SimpleTime();
			tweens = new Tweens(time, 2);
			count = 0;
		}
		
		[After]
		public function after():void
		{
			time = null;
			tweens = null;
		}
		
		[Test]
		public function a_tween_can_be_reversed():void
		{
			mock = new MockTweenForm("a");
			tween = tweens.add(mock, 200);
			assertTrue(tween.reverse());
		}
		
		[Test]
		public function a_reversed_tween_will_complete_where_it_started():void
		{
			var timer:Timer = new Timer(100, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, async.add(trigger_reverse_mid_tween, 600));
			timer.start();
			
			mock = new MockTweenForm("a");
			tween = tweens.add(mock, 400);
			tween.completed.addOnce(async.add(reversed_tween_completes, 600));
		}
		private function trigger_reverse_mid_tween(event:TimerEvent):void
		{
			tween.reverse();
		}
		private function reversed_tween_completes(tween:Tween):void
		{
			assertEquals(0, (tween.form as MockTweenForm).proportion);
		}
		
		[Test]
		public function a_tween_can_be_reversed_in_its_complete_listener():void
		{
			mock = new MockTweenForm("a");
			tween = tweens.add(mock, 100);
			tween.completed.addOnce(async.add(reverse_tween_during_complete, 250));
		}
		private function reverse_tween_during_complete(tween:Tween):void
		{
			assertTrue(tween.reverse());
		}
		
		[Test]
		public function a_tween_reversed_in_its_complete_listener_complets_at_0():void
		{
			var timer:Timer = new Timer(1000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, async.add(wait_for_tween_to_complete_twice, 2000));
			timer.start();
			
			mock = new MockTweenForm("a");
			tween = tweens.add(mock, 250);
			tween.completed.addOnce(reverse_tween_during_complete_without_asserting);
		}
		private function reverse_tween_during_complete_without_asserting(tween:Tween):void
		{
			tween.reverse();
			tween.completed.addOnce(completed_the_second_time);
		}
		private function completed_the_second_time(tween:Tween):void
		{
			if (mock.proportion == 0)
				++count;
		}
		private function wait_for_tween_to_complete_twice(event:TimerEvent):void
		{
			assertEquals(1, count);
		}
		
		[Test]
		public function after_a_tween_has_completed_reverse_will_fail():void
		{
			mock = new MockTweenForm("a");
			tween = tweens.add(mock, 10);
			tween.completed.addOnce(async.add(completed_tween, 100));
		}
		private function completed_tween(tween:Tween):void
		{
			var timer:Timer = new Timer(50, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, async.add(after_complete_reverse_fails, 200));
			timer.start();
		}
		private function after_complete_reverse_fails(event:TimerEvent):void
		{
			assertFalse(tween.reverse());
		}
		
		
	}
}
