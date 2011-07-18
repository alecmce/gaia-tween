package gaia.lib.tween.form
{
	import gaia.lib.tween.Tween;
	
	public interface TweenForm
	{
		function bind(tween:Tween):void;
		
		function update(proportion:Number):void;
		
		function unbind(tween:Tween):void;
		
	}
}
