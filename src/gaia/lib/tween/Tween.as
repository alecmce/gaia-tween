package gaia.lib.tween
{
	import gaia.lib.notice.SingularNotice;
	import gaia.lib.notice.SingularNoticeDispatcher;
	import gaia.lib.tween.form.TweenForm;
	
	final public class Tween
	{
		// TweenPool properties
		private var _pool:Tweens;
		private var _index:uint;
		
		private var _completed:SingularNoticeDispatcher;
		
		private var _start:uint;
		private var _end:uint;
		private var _invDuration:Number;
		
		private var _form:TweenForm;
		private var _ease:Function;
		
		internal var update:Function;

		public function Tween(pool:Tweens)
		{
			_pool = pool;
		}

		public function cancel():void
		{
			_form.unbind(this);
			_pool.onCancelled(this, _index);
		}
		
		public function get completed():SingularNotice
		{
			return _completed ||= new SingularNoticeDispatcher();
		}

		internal function init(form:TweenForm, start:uint, end:uint, ease:Function, index:uint):void
		{
			_start = start;
			_end = end;
			_invDuration = 1 / (end - start);
			
			_form = form;
			_ease = ease;
			update = _ease != null ? eased_update : vanilla_update;
			
			_index = index;
			form.bind(this);
		}
		
		internal function complete():void
		{
			_form.unbind(this);
			_form = null;
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
				return true;
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
				return true;
			}
			
			if (time < _start)
				_form.update(0);
			else
				_form.update(_ease((time - _start) * _invDuration));
			
			return false;
		}
		
	}
}
