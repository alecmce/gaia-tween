package gaia.lib.tween.easing
{
	public class Expo
	{
		public static function easeIn(p:Number):Number
		{
			return p == 0 ? 0 : Math.pow(2, 10 * (p - 1)) - 0.001;
		}

		public static function easeOut(p:Number):Number
		{
			return p == 1 ? 1 : -Math.pow(2, -10 * p) + 1;
		}

		public static function easeInOut(p:Number):Number
		{
			if (p == 0 || p == 1)
				return p;
			
			if ((p *= 2) < 1)
				return .5 * Math.pow(2, 10 * (p - 1));
			
			return .5 * (-Math.pow(2, -10 * (p - 1)) + 2);
		}
	}
}