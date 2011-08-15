package gaia.lib.tween.easing
{
	public class Quad
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
		return p * p;
	}
	
	public function dydx(p:Number):Number
	{
		return p < 1 ? 2 * p : 0;
	}
	
}

internal class EaseOut implements Ease
{
	
	public function fn(p:Number):Number
	{
		return -p * (p - 2);
	}
	
	public function dydx(p:Number):Number
	{
		return p > 0 ? 2 * (1 - p) : 0;
	}
	
}

internal class EaseInOut implements Ease
{
	
	public function fn(p:Number):Number
	{
		if ((p *= 2) < 1)
			return .5 * p * p;
		else
			return -.5 * ((--p) * (p - 2) - 1);
	}
	
	public function dydx(p:Number):Number
	{
		if (p == 0 || p == 1)
			return 0;
		else if (p < .5)
			return 4 * p;
		else
			return 4 * (1 - p);
	}
	
}