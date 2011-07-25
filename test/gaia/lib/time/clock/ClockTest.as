package gaia.lib.time.clock
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertTrue;
	import asunit.framework.Async;

	import gaia.lib.time.SimpleTime;

	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class ClockTest
	{
		
		[Inject]
		public var async:Async;
		
		private var time:SimpleTime;
		private var clock:Clock;
		private var log:String;
		
		private var avo:Appointment;
		private var bvo:Appointment;
		
		[Before]
		public function before():void
		{
			time = new SimpleTime();
			clock = new Clock(time);
			log = "";
		}
		
		[After]
		public function after():void
		{
			clock = null;
			time = null;
			
			avo = null;
			bvo = null;
		}
		
		[Test]
		public function can_add_appointment():void
		{
			var vo:Appointment = new Appointment(1);
			assertTrue(clock.add(vo));
		}
		
		[Test]
		public function an_added_appointment_alarms():void
		{
			var timer:Timer = new Timer(1200, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, async.add(check_appointment_alarms, 1400));
			timer.start();
			
			avo = new Appointment(1);
			avo.alarm.add(log_a);
			clock.add(avo);
		}
		private function check_appointment_alarms(event:TimerEvent):void
		{
			avo.alarm.remove(log_a);
			
			assertEquals("a", log);
		}
		
		[Test]
		public function appointments_alarm_in_order():void
		{
			var timer:Timer = new Timer(2200, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, async.add(check_ordered_appointments, 2400));
			timer.start();
			
			avo = new Appointment(2);
		 	bvo = new Appointment(1);
			
			avo.alarm.add(log_a);
			bvo.alarm.add(log_b);

			clock.add(avo);
			clock.add(bvo);
		}
		private function check_ordered_appointments(event:TimerEvent):void
		{
			avo.alarm.remove(log_a);
			bvo.alarm.remove(log_b);
			
			assertEquals("ba", log);
		}
		
		[Test]
		public function repeated_appointments_repeat_appropriately():void
		{
			var timer:Timer = new Timer(4600, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, async.add(check_repeated_appointments, 4800));
			timer.start();
			
			avo = new Appointment(2, 1);
			bvo = new Appointment(3);

			avo.alarm.add(log_a);
			bvo.alarm.add(log_b);

			clock.add(avo);
			clock.add(bvo);
		}
		private function check_repeated_appointments(event:TimerEvent):void
		{
			avo.alarm.remove(log_a);
			bvo.alarm.remove(log_b);
			
			assertEquals("aba", log);
		}
		
		[Test]
		public function can_add_appointment_inside_appointment_alarm():void
		{
			var timer:Timer = new Timer(4600, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, async.add(check_inside_appointment_ok, 4800));
			timer.start();
			
			avo = new Appointment(2, 1);
			
			avo.alarm.addOnce(add_b_inside);
			
			clock.add(avo);
		}
		private function add_b_inside(vo:Appointment):void
		{
			log += "x";
			
			bvo = new Appointment(1);
			bvo.alarm.add(log_b);
			
			vo.alarm.addOnce(log_a);
			
			clock.add(bvo);
		}
		private function check_inside_appointment_ok(event:TimerEvent):void
		{
			assertEquals("xba", log);
		}
		
		
		[Test]
		public function can_add_self_as_appointment_inside_appointment():void
		{
			var timer:Timer = new Timer(1200, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, async.add(add_self_as_appointment_inside_appointment_timeout, 1400));
			timer.start();
			
			avo = new Appointment(1);
			avo.alarm.addOnce(add_a_inside);
			clock.add(avo);
		}
		private function add_a_inside(vo:Appointment):void
		{
			assertTrue(clock.add(vo));
		}
		private function add_self_as_appointment_inside_appointment_timeout(event:TimerEvent):void
		{
			// do nothing
		}
		
		private function log_a(vo:Appointment):void
		{
			log += "a";
		}
		
		private function log_b(vo:Appointment):void
		{
			log += "b";
		}
		
		
	}
}
