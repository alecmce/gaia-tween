package gaia.lib.time
{
	import gaia.lib.notice.Notice;
	import gaia.lib.notice.NoticeDispatcher;

	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.getTimer;

	internal class TimeBase implements Time
	{
		private var _shape:Shape;
		private var _tick:NoticeDispatcher;
		
		private var _now:uint;
		private var _offset:uint;
		
		private var _isPaused:Boolean;
		private var _pause:uint;

		public function TimeBase()
		{
			_shape = new Shape();
			_shape.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			_tick = new NoticeDispatcher();
			
			_now = 0;
			_offset = getTimer();
			
			_isPaused = false;
		}
		
		final public function get now():uint
		{
			return _now;
		}
		
		final public function pause():void
		{
			if (_isPaused)
				return;
			
			_isPaused = true;
			_pause = getTimer();
			_shape.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		final public function resume():void
		{
			if (!_isPaused)
				return;
			
			_isPaused = false;
			_offset = onResume(_offset, getTimer() - _pause);
			_shape.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		protected function onResume(offset:uint, pauseTime:int):uint
		{
			return 0;
		}
		
		private function onEnterFrame(event:Event):void
		{
			_now = getTimer() - _offset;
			_tick.dispatch(_now);
		}

		final public function get tick():Notice
		{
			return _tick;
		}
		
	}
}
