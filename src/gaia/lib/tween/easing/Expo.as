package gaia.lib.tween.easing
{
	public class Expo
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
	private static const TEN_LN2:Number = Math.LN2 * 10;
	
	public function fn(p:Number):Number
	{
		return p == 0 ? 0 : Math.pow(2, 10 * (p - 1)) - 0.001;
	}
	
	public function dydx(p:Number):Number
	{
		return p == 0 ? 0 : Math.pow(2, 10 * (p - 1)) * TEN_LN2;
	}
	
}

internal class EaseOut implements Ease
{
	private static const TEN_LN2:Number = Math.LN2 * 10;
	
	public function fn(p:Number):Number
	{
		return p == 1 ? 1 : -Math.pow(2, -10 * p) + 1;
	}
	
	public function dydx(p:Number):Number
	{
		return p == 1 ? 0 : Math.pow(2, -10 * p) * TEN_LN2;
	}
	
}

internal class EaseInOut implements Ease
{
	private static const TEN_LN2:Number = Math.LN2 * 10;
	
	public function fn(p:Number):Number
	{
		if (p == 0 || p == 1)
			return p;
		
		if ((p *= 2) < 1)
			return .5 * Math.pow(2, 10 * (p - 1));
		
		return .5 * (-Math.pow(2, -10 * (p - 1)) + 2);
	}
	
	public function dydx(p:Number):Number
	{
		if (p == 0 || p == 1)
			return p;
		
		if ((p *= 2) < 1)
			return Math.pow(2, 10 * (p - 1)) * TEN_LN2;
		
		return Math.pow(2, -10 * (p - 1)) * TEN_LN2;
	}
	
}