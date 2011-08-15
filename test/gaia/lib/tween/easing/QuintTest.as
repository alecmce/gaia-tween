package gaia.lib.tween.easing
{
	import asunit.asserts.assertEqualsFloat;
	
	/**
	 * values were found by running inputs through Penner's original easing equations
	 */
	public class QuintTest
	{
		private const EASE_IN_20:Number = .032;
		private const EASE_IN_50:Number = 3.125;
		private const EASE_IN_80:Number = 32.768;
		
		private const EASE_OUT_20:Number = 67.232;
		private const EASE_OUT_50:Number = 96.875;
		private const EASE_OUT_80:Number = 99.968;
		
		private const EASE_INOUT_20:Number = .512;
		private const EASE_INOUT_50:Number = 50;
		private const EASE_INOUT_80:Number = 99.488;
		
//		[Test]
//		public function test_easeIn():void
//		{
//			assertEqualsFloat(EASE_IN_20, Quint.easeIn(20, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_IN_50, Quint.easeIn(50, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_IN_80, Quint.easeIn(80, 0, 100, 100), 0.0001);
//		}
//
//		[Test]
//		public function test_easeOut():void
//		{
//			assertEqualsFloat(EASE_OUT_20, Quint.easeOut(20, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_OUT_50, Quint.easeOut(50, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_OUT_80, Quint.easeOut(80, 0, 100, 100), 0.0001);
//		}
//		
//		[Test]
//		public function test_easeInOut():void
//		{
//			assertEqualsFloat(EASE_INOUT_20, Quint.easeInOut(20, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_INOUT_50, Quint.easeInOut(50, 0, 100, 100), 0.0001);
//			assertEqualsFloat(EASE_INOUT_80, Quint.easeInOut(80, 0, 100, 100), 0.0001);
//		}
		
		[Test]
		public function test_easeIn():void
		{
			assertEqualsFloat(EASE_IN_20, Quint.easeIn.fn(.2) * 100, 0.0001);
			assertEqualsFloat(EASE_IN_50, Quint.easeIn.fn(.5) * 100, 0.0001);
			assertEqualsFloat(EASE_IN_80, Quint.easeIn.fn(.8) * 100, 0.0001);
		}

		[Test]
		public function test_easeOut():void
		{
			assertEqualsFloat(EASE_OUT_20, Quint.easeOut.fn(.2) * 100, 0.0001);
			assertEqualsFloat(EASE_OUT_50, Quint.easeOut.fn(.5) * 100, 0.0001);
			assertEqualsFloat(EASE_OUT_80, Quint.easeOut.fn(.8) * 100, 0.0001);
		}
		
		[Test]
		public function test_easeInOut():void
		{
			assertEqualsFloat(EASE_INOUT_20, Quint.easeInOut.fn(.2) * 100, 0.0001);
			assertEqualsFloat(EASE_INOUT_50, Quint.easeInOut.fn(.5) * 100, 0.0001);
			assertEqualsFloat(EASE_INOUT_80, Quint.easeInOut.fn(.8) * 100, 0.0001);
		}
		
	}
	
}
