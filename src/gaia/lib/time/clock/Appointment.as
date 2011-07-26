package gaia.lib.time.clock
{
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class Appointment
	{
		
		internal var prev:Appointment;
		internal var next:Appointment;
		internal var clock:Clock;
		internal var time:uint;
		
		private var _seconds:uint;
		private var _repeat:uint;
		private var _data:*;
		
		private var _alarm:Signal;

		public function Appointment(seconds:uint, repeat:uint = 0, data:* = null)
		{
			_seconds = seconds;
			_repeat = repeat;
			_data = data;
			
			_alarm = new Signal(Appointment);
		}
		
		public function get alarm():ISignal
		{
			return _alarm;
		}

		public function get seconds():uint
		{
			return _seconds;
		}
		
		public function get repeat():uint
		{
			return _repeat;
		}

		internal function trigger():Boolean
		{
			if (_data)
				_alarm.dispatch(this, _data);
			else
				_alarm.dispatch(this);
			
			if (_repeat == 0)
				return false;
			
			if (_repeat == -1)
				return true;
			
			return _repeat-- > 0;
		}
		
	}
	
}
