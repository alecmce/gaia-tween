package gaia.lib.tween.form.color
{
	import gaia.lib.tween.form.manager.ManagedTweenForm;
	
	public interface ColorTweenForm extends ManagedTweenForm
	{
		function get color():uint;
		
		function set color(value:uint):void;
		
	}
}
