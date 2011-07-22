package gaia.lib.tween.form.method
{
	import gaia.lib.tween.Tween;
	import gaia.lib.tween.form.TweenForm;

	final public class ParameterizedMethodTweenForm implements TweenForm
	{
		private var _fn:Function;
		private var _params:Array;

		public function ParameterizedMethodTweenForm(fn:Function, params:Array)
		{
			_fn = fn;
			
			_params = params.concat();
			_params.unshift(0);
		}
		
		public function bind(tween:Tween):void
		{
			// do nothing
		}

		public function update(proportion:Number):void
		{
			_params[0] = proportion;
			_fn.apply(null, _params);
		}

		public function unbind(tween:Tween):void
		{
			// do nothing
		}
	}
}
