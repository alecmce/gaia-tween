package gaia.lib.tween.easing
{
	public class Circ
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
		return -Math.sqrt(1 - p * p) + 1;
	}
	
	public function dydx(p:Number):Number
	{
		return 2 * p / (2 * Math.sqrt(1 - p * p));
	}
	
}

internal class EaseOut implements Ease
{
	
	public function fn(p:Number):Number
	{
		return Math.sqrt(1 - (p -= 1) * p);
	}
	
	public function dydx(p:Number):Number
	{
		return -2 * (p -= 1) / (2 * Math.sqrt(1 - p * p));
	}
	
}

internal class EaseInOut implements Ease
{
	
	public function fn(p:Number):Number
	{
		if ((p *= 2) < 1)
			return -.5 * (Math.sqrt(1 - p * p) - 1);
		
		return .5 * (Math.sqrt(1 - (p -= 2) * p) + 1);
	}
	
	public function dydx(p:Number):Number
	{
		if ((p *= 2) < 1)
			return 2 * p / (2 * Math.sqrt(1 - p * p));
		
		return 2 * p / (2 * Math.sqrt(2 - (p -= 2) * p));
	}
	
}