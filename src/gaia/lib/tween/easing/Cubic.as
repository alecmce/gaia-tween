package gaia.lib.tween.easing
{
	public class Cubic
	{
		
		private static var _easeIn:Ease;
		private static var _easeOut:Ease;
		private static var _easeInOut:Ease;
		
		public static function get easeIn():Ease
		{
			return _easeIn ||= new EaseIn();
		}
		
		public static function get easeOut():Ease
		{
			return _easeOut ||= new EaseOut();
		}
		
		public static function get easeInOut():Ease
		{
			return _easeInOut ||= new EaseInOut();
		}
		
	}
}

import gaia.lib.tween.easing.Ease;

internal class EaseIn implements Ease
{
	
	public function fn(p:Number):Number
	{
		return p * p * p;
	}
	
	public function dydx(p:Number):Number
	{
		return 3 * p * p;
	}
	
}

internal class EaseOut implements Ease
{
	
	public function fn(p:Number):Number
	{
		return (p -= 1) * p * p + 1;
	}
	
	public function dydx(p:Number):Number
	{
		return 3 * (p -= 1) * p;
	}
	
}

internal class EaseInOut implements Ease
{
	
	public function fn(p:Number):Number
	{
		if ((p *= 2) < 1)
			return .5 * p * p * p;
		
		return ((p -= 2) * p * p + 2) * .5;
	}
	
	public function dydx(p:Number):Number
	{
		if (p > .5)
			p -= 1;
		
		return 12 * p * p;
	}
	
}