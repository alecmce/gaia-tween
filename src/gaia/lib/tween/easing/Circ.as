package gaia.lib.tween.easing
{
	public class Circ
	{

		public static function easeIn(p:Number):Number
		{
			return -Math.sqrt(1 - p * p) + 1;
		}
		
		public static function easeOut(p:Number):Number
		{
			return Math.sqrt(1 - (p -= 1) * p);
		}

		public static function easeInOut(p:Number):Number
		{
			if ((p *= 2) < 1)
				return -.5 * (Math.sqrt(1 - p * p) - 1);
			
			return .5 * (Math.sqrt(1 - (p -= 2) * p) + 1);
		}

	}
}