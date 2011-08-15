package gaia.lib.tween.easing
{
	public class Quint
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
		return p * p * p * p * p;
	}
	
	public function dydx(p:Number):Number
	{
		return 5 * p * p * p * p;
	}
	
}

internal class EaseOut implements Ease
{
	
	public function fn(p:Number):Number
	{
		return (p -= 1) * p * p * p * p + 1;
	}
	
	public function dydx(p:Number):Number
	{
		return 5 * (p -= 1) * p * p * p;
	}
	
}

internal class EaseInOut implements Ease
{
	
	public function fn(p:Number):Number
	{
		if ((p *= 2) < 1)
			return .5 * p * p * p * p * p;
		
		return .5 * ((p -= 2) * p * p * p * p + 2);
	}
	
	public function dydx(p:Number):Number
	{
		if (p > .5)
			p -= 1;
		
		return 80 * p * p * p * p;
	}
	
}
