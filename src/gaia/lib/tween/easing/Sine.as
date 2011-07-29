package gaia.lib.tween.easing
{
	public class Sine
	{
		private static const HALF_PI:Number = Math.PI * 0.5;

		public static function easeIn(p:Number):Number
		{
			return 1 - Math.cos(-p * HALF_PI);
		}

		public static function easeOut(p:Number):Number
		{
			return Math.sin(p * HALF_PI);
		}

		public static function easeInOut(p:Number):Number
		{
			return -0.5 * (Math.cos(Math.PI * p) - 1);
		}
	}
}