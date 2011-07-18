package gaia.lib.tween.easing
{

	public class Cubic
	{
		public static function easeIn(p:Number):Number
		{
			return p * p * p;
		}
		
		public static function easeOut(p:Number):Number
		{
			return (p -= 1) * p * p + 1;
		}

		public static function easeInOut(p:Number):Number
		{
			if ((p *= 2) < 1)
				return .5 * p * p * p;
			
			return ((p -= 2) * p * p + 2) * .5;
		}
		
	}
}