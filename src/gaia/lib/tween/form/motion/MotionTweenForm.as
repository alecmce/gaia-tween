package gaia.lib.tween.form.motion
{
	import gaia.lib.tween.Tween;
	import gaia.lib.tween.form.manager.ManagedTweenForm;
	import gaia.lib.tween.form.manager.TweenOverlapManager;

	import flash.display.DisplayObject;


	public class MotionTweenForm implements ManagedTweenForm
	{
		private static const KEYS:Vector.<String> = Vector.<String>(["x","y"]);
		
		private var _subject:DisplayObject;
		private var _map:TweenOverlapManager;
		
		private var _isDisabled:Boolean;
		
		private var _sx:Number;
		private var _sy:Number;
		private var _dx:Number;
		private var _dy:Number;
		private var _ex:Number;
		private var _ey:Number;
		
		public function MotionTweenForm(subject:DisplayObject, x:Number, y:Number, map:TweenOverlapManager)
		{
			_subject = subject;
			_map = map;
			
			_ex = x;
			_ey = y;
		}
		
		public function set(x:Number, y:Number):void
		{
			_ex = x;
			_ey = y;
			
			if (_isDisabled)
				return;
			
			_sx = _subject.x;
			_sy = _subject.y;
			_dx = _ex - _sx;
			_dy = _ey - _sy;
		}
		
		public function bind(tween:Tween):void
		{
			_map.bind(_subject, KEYS, this);
			_isDisabled = false;
			
			_sx = _subject.x;
			_sy = _subject.y;
			_dx = _ex - _sx;
			_dy = _ey - _sy;
		}

		public function update(proportion:Number):void
		{
			if (_isDisabled)
				return;
			
			_subject.x = _sx + proportion * _dx;
			_subject.y = _sy + proportion * _dy;
		}

		public function unbind(tween:Tween):void
		{
			_map.unbind(_subject, KEYS);
		}

		public function disable(key:String):void
		{
			_isDisabled = true;
		}
	}
}
