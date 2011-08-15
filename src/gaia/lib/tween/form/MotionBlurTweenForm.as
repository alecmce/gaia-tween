package gaia.lib.tween.form
{
	import gaia.lib.tween.Tween;
	import gaia.lib.tween.easing.Ease;
	import gaia.lib.tween.form.manager.ManagedTweenForm;
	import gaia.lib.tween.form.manager.TweenOverlapManager;

	import flash.display.DisplayObject;
	import flash.filters.BlurFilter;

	final public class MotionBlurTweenForm implements ManagedTweenForm
	{
		private static const BLUR_SCALAR:Number = 0.002;
		private static const KEYS:Vector.<String> = Vector.<String>(["x","y"]);
		
		private var _subject:DisplayObject;
		private var _manager:TweenOverlapManager;
		
		private var _isDisabled:Boolean;
		
		private var _sx:Number, _sy:Number;
		private var _dx:Number, _dy:Number;
		private var _ex:Number, _ey:Number;
		private var _bx:Number, _by:Number;
		private var _blur:Number;
		
		private var _isEase:Boolean;
		private var _ease:Ease;
		private var _ease_fn:Function;
		private var _ease_dydx:Function;
		
		private var _filter:BlurFilter;
		private var _filters:Array;
		private var _gradient:Number;

		public function MotionBlurTweenForm(subject:DisplayObject, x:Number, y:Number, blur:Number, manager:TweenOverlapManager, ease:Ease = null)
		{
			_subject = subject;
			_manager = manager;
			
			_ex = x;
			_ey = y;
			_blur = blur * BLUR_SCALAR;
			
			_isEase = ease != null;
			if (_isEase)
			{
				_ease = ease;
				_ease_fn = _ease.fn;
				_ease_dydx = _ease.dydx;
			}
		}
		
		public function set(x:Number, y:Number):void
		{
			_ex = x;
			_ey = y;
			
			if (_isDisabled)
				return;
			
			redefine();
		}
		
		public function bind(tween:Tween):void
		{
			_manager.bind(_subject, KEYS, this);
			_isDisabled = false;
			_filter = new BlurFilter(0, 0, 2);
			_filters = _subject.filters.concat(_filter);
			redefine();
		}
		
		private function redefine():void
		{
			_sx = _subject.x;
			_sy = _subject.y;
			_dx = _ex - _sx;
			_dy = _ey - _sy;

			if (!_isEase)
				return;

			_bx = _dx * _blur;
			if (_bx < 0)
				_bx = -_bx;
			
			_by = _dy * _blur;
			if (_by < 0)
				_by = -_by;
		}

		public function update(proportion:Number):void
		{
			if (_isDisabled)
				return;
			
			if (_isEase)
			{
				_gradient = _ease_dydx(proportion);
				_filter.blurX = _gradient * _bx;
				_filter.blurY = _gradient * _by;
				_subject.filters = _filters;
				
				proportion = _ease_fn(proportion);
			}
			
			_subject.x = _sx + proportion * _dx;
			_subject.y = _sy + proportion * _dy;
		}

		public function unbind(tween:Tween):void
		{
			_manager.unbind(_subject, KEYS);
		}

		public function disable(key:String):void
		{
			_isDisabled = true;
		}
	}
}
