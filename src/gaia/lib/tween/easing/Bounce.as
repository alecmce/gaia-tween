package gaia.lib.tween.easing
{
	public class Bounce
	{

		public static function easeOut(p:Number):Number
		{
			if (p < .36363636)
				return 7.5625 * p * p;
			else if (p < .72727272)
				return 7.5625 * (p -= .54545454) * p + .75;
			else if (p < .90909090)
				return 7.5625 * (p -= .81818181) * p + .9375;
			else
				return 7.5625 * (p -= .95454545) * p + .984375;
		}

		/**
		 * TODO explode this function for speed
		 */
		public static function easeIn(p:Number):Number
		{
			return 1 - easeOut(1 - p);
		}

		/**
		 * TODO explode this function for speed
		 */
		public static function easeInOut(p:Number):Number
		{
			if (p < .5)
				return easeIn(p * 2) * .5;
			
			return (easeOut(p * 2 - 1) + 1) * .5;
		}
	}
}