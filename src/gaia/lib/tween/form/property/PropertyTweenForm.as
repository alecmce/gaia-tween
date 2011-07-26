package gaia.lib.tween.form.property
{
	import gaia.lib.tween.form.manager.ManagedTweenForm;
	
	public interface PropertyTweenForm extends ManagedTweenForm
	{
		
		function set(key:String, value:Number):void;
		
	}
}
