package gaia.lib.tween.easing
{

	public class Quad
	{
		
		public static function easeIn(p:Number):Number
		{
			return p * p;
		}

		public static function easeOut(p:Number):Number
		{
			return -p * (p - 2);
		}

		public static function easeInOut(p:Number):Number
		{
			if ((p *= 2) < 1)
				return .5 * p * p;
			
			return -.5 * ((--p) * (p - 2) - 1);
		}
	}
}