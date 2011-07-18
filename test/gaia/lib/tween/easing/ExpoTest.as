package gaia.lib.tween.easing
{
	import asunit.asserts.assertEqualsFloat;
	
	/**
	 * values were found by running inputs through Penner's original easing equations
	 */
	public class ExpoTest
	{
		private const EASE_IN_20:Number = .290625;
		private const EASE_IN_50:Number = 3.025;
		private const EASE_IN_80:Number = 24.9;
		
		private const EASE_OUT_20:Number = 75;
		private const EASE_OUT_50:Number = 96.875;
		private const EASE_OUT_80:Number = 99.609375;
		
		private const EASE_INOUT_20:Number = .78125;
		private const EASE_INOUT_50:Number = 50;
		private const EASE_INOUT_80:Number = 99.21875;
		
		
//		[Test]
//		public function test_easeIn():void
//		{
//			assertEqualsFloat(EASE_IN_20, Expo.easeIn(20, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_IN_50, Expo.easeIn(50, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_IN_80, Expo.easeIn(80, 0, 100, 100), 0.000001);
//		}
//
//		[Test]
//		public function test_easeOut():void
//		{
//			assertEqualsFloat(EASE_OUT_20, Expo.easeOut(20, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_OUT_50, Expo.easeOut(50, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_OUT_80, Expo.easeOut(80, 0, 100, 100), 0.000001);
//		}
//		
//		[Test]
//		public function test_easeInOut():void
//		{
//			assertEqualsFloat(EASE_INOUT_20, Expo.easeInOut(20, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_INOUT_50, Expo.easeInOut(50, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_INOUT_80, Expo.easeInOut(80, 0, 100, 100), 0.000001);
//		}
		
		[Test]
		public function test_easeIn():void
		{
			assertEqualsFloat(EASE_IN_20, Expo.easeIn(.2) * 100, 0.000001);
			assertEqualsFloat(EASE_IN_50, Expo.easeIn(.5) * 100, 0.000001);
			assertEqualsFloat(EASE_IN_80, Expo.easeIn(.8) * 100, 0.000001);
		}

		[Test]
		public function test_easeOut():void
		{
			assertEqualsFloat(EASE_OUT_20, Expo.easeOut(.2) * 100, 0.000001);
			assertEqualsFloat(EASE_OUT_50, Expo.easeOut(.5) * 100, 0.000001);
			assertEqualsFloat(EASE_OUT_80, Expo.easeOut(.8) * 100, 0.000001);
		}
		
		[Test]
		public function test_easeInOut():void
		{
			assertEqualsFloat(EASE_INOUT_20, Expo.easeInOut(.2) * 100, 0.000001);
			assertEqualsFloat(EASE_INOUT_50, Expo.easeInOut(.5) * 100, 0.000001);
			assertEqualsFloat(EASE_INOUT_80, Expo.easeInOut(.8) * 100, 0.000001);
		}
		
	}
	
}
