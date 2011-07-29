package gaia.lib.tween.form
{
	import gaia.lib.tween.Tween;

	final public class MethodTweenForm implements TweenForm
	{
		private var _fn:Function;
		
		public function MethodTweenForm(fn:Function)
		{
			_fn = fn;
		}
		
		public function bind(tween:Tween):void
		{
			// do nothing
		}

		public function update(proportion:Number):void
		{
			_fn(proportion);
		}
		
		public function unbind(tween:Tween):void
		{
			// do nothing
		}
		
	}
}
