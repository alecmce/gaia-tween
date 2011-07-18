package gaia.lib.tween.easing
{
	public class Back
	{
		
		public static function easeIn(p:Number):Number
		{
			return p * p * (2.70158 * p - 1.70158);
		}
		
		public static function easeOut(p:Number):Number
		{
			return (p -= 1) * p * (2.70158 * p + 1.70158) + 1;
		}
		
		public static function easeInOut(p:Number):Number
		{
			if ((p *= 2) < 1)
				return .5 * p * p * (3.5949095 * p - 2.5949095);
			
			return .5 * ((p -= 2) * p * (3.5949095 * p + 2.5949095) + 2);
		}
		
	}
}
