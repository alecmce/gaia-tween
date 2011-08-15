package gaia.lib.tween
{
	import gaia.lib.time.SimpleTime;
	import gaia.lib.time.Time;
	import gaia.lib.tween.easing.Ease;
	import gaia.lib.tween.form.ColorTweenForm;
	import gaia.lib.tween.form.MethodTweenForm;
	import gaia.lib.tween.form.MotionTweenForm;
	import gaia.lib.tween.form.ParameterizedMethodTweenForm;
	import gaia.lib.tween.form.PropertyTweenForm;
	import gaia.lib.tween.form.TweenForm;
	import gaia.lib.tween.form.manager.TweenOverlapManager;

	import flash.display.DisplayObject;


	
	public class GaiaTweens
	{
		private var _count:uint;
		private var _time:SimpleTime;
		
		private var _tweens:Tweens;
		
		private var _manager:TweenOverlapManager;
		
		public function GaiaTweens(count:uint, time:Time = null)
		{
			_count = count;
			_time ||= new SimpleTime();
			
			_tweens = new Tweens(_time, count);
			_manager = new TweenOverlapManager();
		}

		public function tween(subject:*, properties:Object, duration:uint, delay:uint = 0, ease:Ease = null):Tween
		{
			var form:PropertyTweenForm = new PropertyTweenForm(subject, properties, _manager);
			return _tweens.add(form, duration, delay, ease);
		}
		
		public function method(fn:Function, duration:uint, params:Array = null, delay:uint = 0, ease:Ease = null):Tween
		{
			var form:TweenForm = params ? new ParameterizedMethodTweenForm(fn, params) : new MethodTweenForm(fn);
			return _tweens.add(form, duration, delay, ease);
		}
		
		public function color(subject:DisplayObject, color:uint, duration:uint, delay:uint = 0, ease:Ease = null):Tween
		{
			var form:ColorTweenForm = new ColorTweenForm(subject, color, _manager);
			return _tweens.add(form, duration, delay, ease);
		}
		
		public function goto(subject:DisplayObject, x:Number, y:Number, duration:uint, delay:uint = 0, ease:Ease = null):Tween
		{
			var form:MotionTweenForm = new MotionTweenForm(subject, x, y, _manager);
			return _tweens.add(form, duration, delay, ease);
		}
	}
	
}
