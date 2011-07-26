package gaia.lib.tween
{
	import gaia.lib.notice.SingularNotice;
	import gaia.lib.notice.SingularNoticeDispatcher;
	import gaia.lib.tween.form.TweenForm;
	
	final public class Tween
	{
		private var _pool:Tweens;
		private var _completed:SingularNoticeDispatcher;
		
		private var _start:uint;
		private var _end:uint;
		private var _invDuration:Number;
		
		private var _form:TweenForm;
		private var _dummy:TweenForm;
		private var _ease:Function;
		
		internal var index:uint;
		internal var update:Function;
		
		public var autoComplete:Boolean;

		private static var INDEX:uint = 0;
		private var __index:uint;
		public function toString():String { return "[Tween " + __index + "]"; }

		public function Tween(pool:Tweens, index:uint)
		{
			__index = ++INDEX;
			
			_pool = pool;
			this.index = index;
			this.autoComplete = true;
		}

		public function cancel():void
		{
			_form.unbind(this);
			_form = null;
			autoComplete = true;
			
			_pool.onCancelled(this);
		}
		
		public function get completed():SingularNotice
		{
			return _completed ||= new SingularNoticeDispatcher();
		}

		private var inited:uint = 0;
		internal function init(form:TweenForm, start:uint, end:uint, ease:Function):void
		{
			_start = start;
			_end = end;
			_invDuration = 1 / (end - start);
			
			++inited;
			_form = form;
			_form.bind(this);
			
			_ease = ease;
			update = _ease != null ? eased_update : vanilla_update;
		}
		
		internal function dispatch():void
		{
			_dummy = _form;
			_form.unbind(this);
			_form = null;
			autoComplete = true;
			
			if (_completed)
				_completed.dispatch(this);
			
			_dummy = null;
		}
		
		public function get form():TweenForm
		{
			return _form || _dummy;
		}
		
		private function vanilla_update(time:uint):Boolean
		{
			if (time >= _end)
			{
				_form.update(1);
				return autoComplete;
			}
			
			if (time < _start)
				_form.update(0);
			else
				_form.update((time - _start) * _invDuration);
			
			return false;
		}
		
		private function eased_update(time:uint):Boolean
		{
			if (time >= _end)
			{
				_form.update(1);
				return autoComplete;
			}
			
			if (time < _start)
				_form.update(0);
			else
				_form.update(_ease((time - _start) * _invDuration));
			
			return false;
		}
		
	}
}
