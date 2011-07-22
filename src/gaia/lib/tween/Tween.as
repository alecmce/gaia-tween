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
		private var _ease:Function;
		
		internal var index:uint;
		internal var update:Function;
		
		public var autoComplete:Boolean;

		public function Tween(pool:Tweens, index:uint)
		{
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

		internal function init(form:TweenForm, start:uint, end:uint, ease:Function):void
		{
			_start = start;
			_end = end;
			_invDuration = 1 / (end - start);
			
			_form = form;
			_form.bind(this);
			
			_ease = ease;
			update = _ease != null ? eased_update : vanilla_update;
		}
		
		internal function complete():void
		{
			_form.unbind(this);
			_form = null;
			autoComplete = true;
		}
		
		internal function dispatch():void
		{
			if (_completed)
				_completed.dispatch(this);
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
