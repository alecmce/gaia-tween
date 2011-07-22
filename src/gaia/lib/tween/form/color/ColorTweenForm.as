package gaia.lib.tween.form.color
{
	import gaia.lib.tween.form.TweenForm;
	
	public interface ColorTweenForm extends TweenForm
	{
		function get color():uint;
		
		function set color(value:uint):void;
		
		function disable():void;
	}
}
