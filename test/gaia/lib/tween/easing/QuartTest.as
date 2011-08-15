package gaia.lib.tween.easing
{
	import asunit.asserts.assertEqualsFloat;
	
	/**
	 * values were found by running inputs through Penner's original easing equations
	 */
	public class QuartTest
	{
		private const EASE_IN_20:Number = .16;
		private const EASE_IN_50:Number = 6.25;
		private const EASE_IN_80:Number = 40.96;
		
		private const EASE_OUT_20:Number = 59.04;
		private const EASE_OUT_50:Number = 93.75;
		private const EASE_OUT_80:Number = 99.84;
		
		private const EASE_INOUT_20:Number = 1.28;
		private const EASE_INOUT_50:Number = 50;
		private const EASE_INOUT_80:Number = 98.72;
		
//		[Test]
//		public function test_easeIn():void
//		{
//			assertEqualsFloat(EASE_IN_20, Quart.easeIn(20, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_IN_50, Quart.easeIn(50, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_IN_80, Quart.easeIn(80, 0, 100, 100), 0.0001);
//		}
//
//		[Test]
//		public function test_easeOut():void
//		{
//			assertEqualsFloat(EASE_OUT_20, Quart.easeOut(20, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_OUT_50, Quart.easeOut(50, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_OUT_80, Quart.easeOut(80, 0, 100, 100), 0.0001);
//		}
//		
//		[Test]
//		public function test_easeInOut():void
//		{
//			assertEqualsFloat(EASE_INOUT_20, Quart.easeInOut(20, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_INOUT_50, Quart.easeInOut(50, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_INOUT_80, Quart.easeInOut(80, 0, 100, 100), 0.0001);
//		}
		
		[Test]
		public function test_easeIn():void
		{
			assertEqualsFloat(EASE_IN_20, Quart.easeIn.fn(.2) * 100, 0.0001);
			assertEqualsFloat(EASE_IN_50, Quart.easeIn.fn(.5) * 100, 0.0001);
			assertEqualsFloat(EASE_IN_80, Quart.easeIn.fn(.8) * 100, 0.0001);
		}

		[Test]
		public function test_easeOut():void
		{
			assertEqualsFloat(EASE_OUT_20, Quart.easeOut.fn(.2) * 100, 0.0001);
			assertEqualsFloat(EASE_OUT_50, Quart.easeOut.fn(.5) * 100, 0.0001);
			assertEqualsFloat(EASE_OUT_80, Quart.easeOut.fn(.8) * 100, 0.0001);
		}
		
		[Test]
		public function test_easeInOut():void
		{
			assertEqualsFloat(EASE_INOUT_20, Quart.easeInOut.fn(.2) * 100, 0.0001);
			assertEqualsFloat(EASE_INOUT_50, Quart.easeInOut.fn(.5) * 100, 0.0001);
			assertEqualsFloat(EASE_INOUT_80, Quart.easeInOut.fn(.8) * 100, 0.0001);
		}
		
	}
	
}
