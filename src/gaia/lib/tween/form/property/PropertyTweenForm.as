package gaia.lib.tween.form.property
{
	import gaia.lib.tween.form.TweenForm;
	
	public interface PropertyTweenForm extends TweenForm
	{
		
		function set(key:String, value:Number):void;
		
		function disable(key:String):void;
		
	}
}
