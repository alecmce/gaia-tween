package gaia.lib.tween.easing
{
	public interface Ease
	{
		
		function fn(p:Number):Number;
		
		function dydx(p:Number):Number;
		
	}
}
