package gaia.lib.tween.easing
{
	public class Bounce
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
		if (p > .63636363)
			return 1 - 7.5625 * (p -= 1) * p;
		else if (p > .27272727)
			return .25 - 7.5625 * (p -= .45454545) * p;
		else if (p > .09090909)
			return .0625 - 7.5625 * (p -= .18181818) * p;
		else
			return .015625 - 7.5625 * (p -= .045454545) * p;
	}
	
	public function dydx(p:Number):Number
	{
		if (p > .63636363)
			return -15.125 * (p - 1);
		else if (p > .27272727)
			return -15.125 * (p - .45454545);
		else if (p > .09090909)
			return -15.125 * (p - .18181818);
		else
			return -15.125 * (p - .045454545);
	}
	
}

internal class EaseOut implements Ease
{
	
	public function fn(p:Number):Number
	{
		if (p < .36363636)
			return 7.5625 * p * p;
		else if (p < .72727272)
			return .75 + 7.5625 * (p -= .54545454) * p;
		else if (p < .90909090)
			return .9375 + 7.5625 * (p -= .81818181) * p;
		else
			return .984375 + 7.5625 * (p -= .95454545) * p;
	}
	
	public function dydx(p:Number):Number
	{
		if (p < .36363636)
			return 15.125 * p;
		else if (p < .72727272)
			return 15.125 * (p - .54545454);
		else if (p < .90909090)
			return 15.125 * (p - .81818181);
		else
			return 15.125 * (p - .95454545);
	}
	
}

internal class EaseInOut implements Ease
{
	
	public function fn(p:Number):Number
	{
		if (p < .0455)
			return .0078125 - 15.125 * (p -= .02272727) * p;
		else if (p < .1364)
			return .03125 - 15.125 * (p -= .09090909) * p;
		else if (p < .3182)
			return .125 - 15.125 * (p -= .2272727) * p;
		else if (p < .5)
			return .5 - 15.125 * (p -= .5) * p;
		else if (p < .6818)
			return .5 + 15.125 * (p -= .5) * p;
		else if (p < .8636)
			return .875 + 15.125 * (p -= .77272727) * p;
		else if (p < .9545)
			return .96875 + 15.125 * (p -= .90909090) * p;
		else
			return .9921875 + 15.125 * (p -= .977272725) * p;
	}
	
	public function dydx(p:Number):Number
	{
		if (p < .0455)
			return -30.25 * (p - .02272727);
		else if (p < .1364)
			return -30.25 * (p - .09090909);
		else if (p < .3182)
			return -30.25 * (p - .2272727);
		else if (p < .5)
			return -30.25 * (p - .5);
		else if (p < .6818)
			return 30.25 * (p - .5);
		else if (p < .8636)
			return 30.25 * (p - .77272727);
		else if (p < .9545)
			return 30.25 * (p - .90909090);
		else
			return 30.25 * (p - .977272725);
	}
	
}