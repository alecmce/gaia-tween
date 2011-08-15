package gaia.lib.tween.easing
{
	import asunit.asserts.assertEqualsFloat;
	
	/**
	 * values were found by running inputs through Penner's original easing equations
	 */
	public class CubicTest
	{
		private const EASE_IN_20:Number = .8;
		private const EASE_IN_50:Number = 12.5;
		private const EASE_IN_80:Number = 51.2;
		
		private const EASE_OUT_20:Number = 48.8;
		private const EASE_OUT_50:Number = 87.5;
		private const EASE_OUT_80:Number = 99.2;
		
		private const EASE_INOUT_20:Number = 3.2;
		private const EASE_INOUT_50:Number = 50;
		private const EASE_INOUT_80:Number = 96.8;
		
//		[Test]
//		public function test_easeIn():void
//		{
//			assertEqualsFloat(EASE_IN_20, Cubic.easeIn(20, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_IN_50, Cubic.easeIn(50, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_IN_80, Cubic.easeIn(80, 0, 100, 100), 0.0001);
//		}
//
//		[Test]
//		public function test_easeOut():void
//		{
//			assertEqualsFloat(EASE_OUT_20, Cubic.easeOut(20, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_OUT_50, Cubic.easeOut(50, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_OUT_80, Cubic.easeOut(80, 0, 100, 100), 0.0001);
//		}
//		
//		[Test]
//		public function test_easeInOut():void
//		{
//			assertEqualsFloat(EASE_INOUT_20, Cubic.easeInOut(20, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_INOUT_50, Cubic.easeInOut(50, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_INOUT_80, Cubic.easeInOut(80, 0, 100, 100), 0.0001);
//		}
		
		[Test]
		public function test_easeIn():void
		{
			assertEqualsFloat(EASE_IN_20, Cubic.easeIn.fn(.2) * 100, 0.0001);
			assertEqualsFloat(EASE_IN_50, Cubic.easeIn.fn(.5) * 100, 0.0001);
			assertEqualsFloat(EASE_IN_80, Cubic.easeIn.fn(.8) * 100, 0.0001);
		}

		[Test]
		public function test_easeOut():void
		{
			assertEqualsFloat(EASE_OUT_20, Cubic.easeOut.fn(.2) * 100, 0.0001);
			assertEqualsFloat(EASE_OUT_50, Cubic.easeOut.fn(.5) * 100, 0.0001);
			assertEqualsFloat(EASE_OUT_80, Cubic.easeOut.fn(.8) * 100, 0.0001);
		}
		
		[Test]
		public function test_easeInOut():void
		{
			assertEqualsFloat(EASE_INOUT_20, Cubic.easeInOut.fn(.2) * 100, 0.0001);
			assertEqualsFloat(EASE_INOUT_50, Cubic.easeInOut.fn(.5) * 100, 0.0001);
			assertEqualsFloat(EASE_INOUT_80, Cubic.easeInOut.fn(.8) * 100, 0.0001);
		}
		
	}
	
}
