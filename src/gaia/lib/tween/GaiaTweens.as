package gaia.lib.tween
{
	import gaia.lib.time.SimpleTime;
	import gaia.lib.time.Time;
	import gaia.lib.tween.form.TweenForm;
	import gaia.lib.tween.form.color.ColorTweenForm;
	import gaia.lib.tween.form.color.ColorTweenMap;
	import gaia.lib.tween.form.color.SimpleColorTweenForm;
	import gaia.lib.tween.form.method.MethodTweenForm;
	import gaia.lib.tween.form.method.ParameterizedMethodTweenForm;
	import gaia.lib.tween.form.property.PropertyTweenForm;
	import gaia.lib.tween.form.property.PropertyTweenFormPool;
	import gaia.lib.tween.form.property.PropertyTweenMap;

	import flash.display.DisplayObject;
	
	public class GaiaTweens
	{
		private var _count:uint;
		private var _time:SimpleTime;
		
		private var _tweens:Tweens;
		private var _propertyForms:PropertyTweenFormPool;
		
		private var colorMap:ColorTweenMap;
		
		public function GaiaTweens(count:uint, time:Time = null)
		{
			_count = count;
			_time ||= new SimpleTime();
			
			_tweens = new Tweens(_time, count);
			_propertyForms = new PropertyTweenFormPool(new PropertyTweenMap(), _count);
		}

		public function tween(subject:*, properties:Object, duration:uint, delay:uint = 0, ease:Function = null):Tween
		{
			var form:PropertyTweenForm = _propertyForms.require(subject, properties);
			return _tweens.add(form, duration, delay, ease);
		}
		
		public function method(fn:Function, duration:uint, params:Array = null, delay:uint = 0, ease:Function = null):Tween
		{
			var form:TweenForm = params ? new ParameterizedMethodTweenForm(fn, params) : new MethodTweenForm(fn);
			return _tweens.add(form, duration, delay, ease);
		}
		
		public function color(subject:DisplayObject, color:uint, duration:uint, delay:uint = 0, ease:Function = null):Tween
		{
			var form:ColorTweenForm = new SimpleColorTweenForm(subject, color, colorMap ||= new ColorTweenMap());
			return _tweens.add(form, duration, delay, ease);
		}
		
	}
	
}
