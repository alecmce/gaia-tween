package gaia.lib.tween.easing
{
	public class Sine
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
	private static const HALF_PI:Number = Math.PI * 0.5;
	
	public function fn(p:Number):Number
	{
		return 1 - Math.cos(-p * HALF_PI);
	}
	
	public function dydx(p:Number):Number
	{
		return -HALF_PI * Math.sin(-p * HALF_PI);
	}
	
}

internal class EaseOut implements Ease
{
	private static const HALF_PI:Number = Math.PI * 0.5;
	
	public function fn(p:Number):Number
	{
		return Math.sin(p * HALF_PI);
	}
	
	public function dydx(p:Number):Number
	{
		return HALF_PI * Math.cos(p * HALF_PI);
	}
	
}

internal class EaseInOut implements Ease
{
	private static const HALF_PI:Number = Math.PI * 0.5;
	
	public function fn(p:Number):Number
	{
		return -.5 * (Math.cos(Math.PI * p) - 1);
	}
	
	public function dydx(p:Number):Number
	{
		return HALF_PI * Math.sin(Math.PI * p);
	}
	
}