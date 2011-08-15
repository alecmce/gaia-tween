package gaia.lib.tween.easing
{
	public class Back
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
		return p * p * (2.70158 * p - 1.70158);
	}
	
	public function dydx(p:Number):Number
	{
		return p * (8.10474 * p - 3.40316);
	}
	
}

internal class EaseOut implements Ease
{
	
	public function fn(p:Number):Number
	{
		return (p -= 1) * p * (2.70158 * p + 1.70158) + 1;
	}
	
	public function dydx(p:Number):Number
	{
		return (p -= 1) * (8.10474 * p + 3.40316);
	}
	
}

internal class EaseInOut implements Ease
{
	
	public function fn(p:Number):Number
	{
		if ((p *= 2) < 1)
			return .5 * p * p * (3.5949095 * p - 2.5949095);
		
		return .5 * ((p -= 2) * p * (3.5949095 * p + 2.5949095) + 2);
	}
	
	public function dydx(p:Number):Number
	{
		
		if ((p *= 2) < 1)
			return p * (10.7847285 * p - 5.189819);
		
		return (p -= 2) * (10.7847285 * p + 5.189819);
	}
	
}