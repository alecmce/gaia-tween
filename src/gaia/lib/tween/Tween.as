package gaia.lib.tween
{
	import gaia.lib.notice.SingularNotice;
	import gaia.lib.notice.SingularNoticeDispatcher;
	import gaia.lib.tween.form.TweenForm;
	
	final public class Tween
	{
		private var _pool:Tweens;
		private var _completed:SingularNoticeDispatcher;
		
		private var _start:int;
		private var _end:int;
		private var _duration:uint;
		private var _invDuration:Number;
		
		private var _form:TweenForm;
		private var _dummy:TweenForm;
		
		private var _ease:Function;
		
		private var _time:uint;
		private var _reversed:Boolean;
		private var _resurrected:Boolean;
		
		internal var index:uint;
		internal var update:Function;
		
		public var autoComplete:Boolean;

		public function Tween(pool:Tweens, index:uint)
		{
			_pool = pool;
			this.index = index;
			this.autoComplete = true;
		}
		
		public function reverse():Boolean
		{
			if (!_form)
			{
				if (_dummy)
				{
					_form = _dummy;
					_resurrected = true;
				}
				else
				{
					return false;
				}
			}
			
			if (_reversed = !_reversed)
				update = _ease != null ? eased_reversed : vanilla_reversed;
			else
				update = _ease != null ? eased_update : vanilla_update;
			
			_start = (_time << 1) - _end;
			_end = _start + _duration;
			
			return true;
		}

		public function cancel():void
		{
			if (!_form)
				return;
				
			_form.unbind(this);
			_form = null;
			autoComplete = true;
			
			if (_completed)
				_completed.removeAll();
			
			_pool.onCancelled(this);
		}
		
		public function get completed():SingularNotice
		{
			return _completed ||= new SingularNoticeDispatcher();
		}

		internal function init(form:TweenForm, start:int, end:int, ease:Function):void
		{
			_start = start;
			_end = end;
			_duration = end - start;
			_invDuration = 1 / _duration;
			
			_reversed = false;
			_resurrected = false;
			
			_form = form;
			_form.bind(this);
			
			_ease = ease;
			update = _ease != null ? eased_update : vanilla_update;
		}
		
		internal function complete():void
		{
			_dummy = _form;
			
			_form.unbind(this);
			_form = null;
			
			autoComplete = true;
		}
		
		internal function dispatch():Boolean
		{
			if (_completed)
				_completed.dispatch(this);
			
			_dummy = null;
			
			if (!_resurrected || !_form)
				return false;
			
			_resurrected = false;
			_form.bind(this);
			return true;
		}
		
		public function get form():TweenForm
		{
			return _form || _dummy;
		}
		
		private function vanilla_update(time:uint):Boolean
		{
			if ((_time = time) >= _end)
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
			if ((_time = time) >= _end)
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
		
		private function vanilla_reversed(time:uint):Boolean
		{
			if ((_time = time) >= _end)
			{
				_form.update(0);
				return autoComplete;
			}
			
			if (time < _start)
				_form.update(1);
			else
				_form.update((_end - time) * _invDuration);
			
			return false;
		}
		
		private function eased_reversed(time:uint):Boolean
		{
			if ((_time = time) >= _end)
			{
				_form.update(0);
				return autoComplete;
			}
			
			if (time < _start)
				_form.update(1);
			else
				_form.update(_ease((_end - time) * _invDuration));
			
			return false;
		}

	}
}
