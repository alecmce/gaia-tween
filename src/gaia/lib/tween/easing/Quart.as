package gaia.lib.tween.easing
{
	public class Quart
	{
		public static function easeIn(p:Number):Number
		{
			return p * p * p * p;
		}

		public static function easeOut(p:Number):Number
		{
			return -((p -= 1) * p * p * p - 1);
		}

		public static function easeInOut(p:Number):Number
		{
			if ((p *= 2) < 1)
				return .5 * p * p * p * p;
			
			return -.5 * ((p -= 2) * p * p * p - 2);
		}
	}
}