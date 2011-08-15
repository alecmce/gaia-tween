package gaia.lib.tween.easing
{
	import asunit.asserts.assertEqualsFloat;
	
	/**
	 * values were found by running inputs through Penner's original easing equations
	 */
	public class BounceTest
	{
		private const EASE_IN_20:Number = 6;
		private const EASE_IN_50:Number = 23.4375;
		private const EASE_IN_80:Number = 69.75;
		
		private const EASE_OUT_20:Number = 30.25;
		private const EASE_OUT_50:Number = 76.5625;
		private const EASE_OUT_80:Number = 94;
		
		private const EASE_INOUT_20:Number = 11.375;
		private const EASE_INOUT_50:Number = 50;
		private const EASE_INOUT_80:Number = 88.625;
		
//		[Test]
//		public function test_easeIn():void
//		{
//			assertEqualsFloat(EASE_IN_20, Bounce.easeIn(20, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_IN_50, Bounce.easeIn(50, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_IN_80, Bounce.easeIn(80, 0, 100, 100), 0.0001);
//		}
//		
//		[Test]
//		public function test_easeOut():void
//		{
//			assertEqualsFloat(EASE_OUT_20, Bounce.easeOut(20, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_OUT_50, Bounce.easeOut(50, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_OUT_80, Bounce.easeOut(80, 0, 100, 100), 0.0001);
//		}
//		
//		[Test]
//		public function test_easeInOut():void
//		{
//			assertEqualsFloat(EASE_INOUT_20, Bounce.easeInOut(20, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_INOUT_50, Bounce.easeInOut(50, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_INOUT_80, Bounce.easeInOut(80, 0, 100, 100), 0.0001);
//		}
		
		[Test]
		public function test_easeIn():void
		{
			assertEqualsFloat(EASE_IN_20, Bounce.easeIn.fn(.2) * 100, 0.0001);
			assertEqualsFloat(EASE_IN_50, Bounce.easeIn.fn(.5) * 100, 0.0001);
			assertEqualsFloat(EASE_IN_80, Bounce.easeIn.fn(.8) * 100, 0.0001);
		}
		
		[Test]
		public function test_easeOut():void
		{
			assertEqualsFloat(EASE_OUT_20, Bounce.easeOut.fn(.2) * 100, 0.0001);
			assertEqualsFloat(EASE_OUT_50, Bounce.easeOut.fn(.5) * 100, 0.0001);
			assertEqualsFloat(EASE_OUT_80, Bounce.easeOut.fn(.8) * 100, 0.0001);
		}
		
		[Test]
		public function test_easeInOut():void
		{
			assertEqualsFloat(EASE_INOUT_20, Bounce.easeInOut.fn(.2) * 100, 0.0001);
			assertEqualsFloat(EASE_INOUT_50, Bounce.easeInOut.fn(.5) * 100, 0.0001);
			assertEqualsFloat(EASE_INOUT_80, Bounce.easeInOut.fn(.8) * 100, 0.0001);
		}
		
	}
	
}
