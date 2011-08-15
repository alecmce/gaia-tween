package gaia.lib.tween.form
{
	import gaia.lib.tween.Tween;
	import gaia.lib.tween.easing.Ease;

	final public class ParameterizedMethodTweenForm implements TweenForm
	{
		private var _fn:Function;
		private var _params:Array;
		
		private var _ease:Ease;
		private var _isEase:Boolean;
		private var _ease_fn:Function;
		
		public function ParameterizedMethodTweenForm(fn:Function, params:Array, ease:Ease = null)
		{
			_fn = fn;
			
			_params = params.concat();
			_params.unshift(0);
			
			_isEase = ease != null;
			if (_isEase)
			{
				_ease = ease;
				_ease_fn = _ease.fn;
			}
		}
		
		public function bind(tween:Tween):void
		{
			// do nothing
		}

		public function update(proportion:Number):void
		{
			if (_isEase)
				proportion = _ease_fn(proportion);
			
			_params[0] = proportion;
			_fn.apply(null, _params);
		}

		public function unbind(tween:Tween):void
		{
			// do nothing
		}
	}
}
