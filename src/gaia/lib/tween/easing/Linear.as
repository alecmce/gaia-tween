package gaia.lib.tween.easing
{
	public class Linear
	{
		
		public static function easeIn(p:Number, initial:Number, range:Number):Number
		{
			return initial + range * p;
		}
		
		public static function easeOut(p:Number, initial:Number, range:Number):Number
		{
			return initial + range * p;
		}
		
		public static function easeInOut(p:Number, initial:Number, range:Number):Number
		{
			return initial + range * p;
		}

	}
}