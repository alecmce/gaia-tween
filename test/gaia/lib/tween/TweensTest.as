package gaia.lib.tween
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertNotNull;
	import asunit.framework.Async;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import gaia.lib.time.PausableTime;
	import gaia.lib.time.Time;
	import gaia.lib.time.pause.IntrinsictTimeStrategy;
	import gaia.lib.tween.form.TweenForm;



	public class TweensTest
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
			time = new PausableTime(new IntrinsictTimeStrategy());
			tweens = new Tweens(time);
			count = 0;
		}
		
		[After]
		public function after():void
		{
			time = null;
			tweens = null;
		}
		
		[Test]
		public function can_add_a_tween():void
		{
			mock = new MockTweenForm("a");
			tween = tweens.add(mock, 100);
			assertNotNull(tween);
		}
		
		[Test]
		public function on_adding_a_tween_progresses():void
		{
			var timer:Timer = new Timer(200, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, async.add(onTimerComplete, 220));
			timer.start();
			
			mock = new MockTweenForm("a");
			tween = tweens.add(mock, 100);
		}
		private function onTimerComplete(event:TimerEvent):void
		{
			assertEquals(1, mock.proportion);
		}
		
		[Test]
		public function when_a_tween_completes_it_notifies_listeners():void
		{
			var timer:Timer = new Timer(200, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, async.add(onTimerComplete2, 220));
			timer.start();
			
			mock = new MockTweenForm("a");
			tweens.add(mock, 100).completed.addOnce(onSignalCompleted);
		}
		private function onSignalCompleted(tween:Tween, form:TweenForm):void
		{
			++count;
		}
		private function onTimerComplete2(event:TimerEvent):void
		{
			assertEquals(1, count);
		}
		
	}
	
}
