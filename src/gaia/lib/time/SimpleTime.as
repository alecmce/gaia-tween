package gaia.lib.time
{
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.getTimer;

	final public class SimpleTime implements Time
	{
		private var _shape:Shape;
		private var _tick:Signal;
		
		private var _now:uint;
		private var _offset:uint;
		
		public function SimpleTime()
		{
			_shape = new Shape();
			_shape.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			_tick = new Signal(uint);
			
			_now = 0;
			_offset = getTimer();
		}

		public function get now():uint
		{
			return _now;
		}

		private function onEnterFrame(event:Event):void
		{
			_now = getTimer() - _offset;
			_tick.dispatch(_now);
		}

		final public function get tick():ISignal
		{
			return _tick;
		}
		
	}
}
