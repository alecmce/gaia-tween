package gaia.lib.tween.easing
{
	import asunit.asserts.assertEqualsFloat;
	
	/**
	 * values were found by running inputs through Penner's original easing equations
	 */
	public class BackTest
	{
		private const EASE_IN_20:Number = -4.645056;
		private const EASE_IN_50:Number = -8.769750000000004;
		private const EASE_IN_80:Number = 29.419776;
		
		private const EASE_OUT_20:Number = 70.58022399999999;
		private const EASE_OUT_50:Number = 108.76975;
		private const EASE_OUT_80:Number = 104.645056;
		
		private const EASE_INOUT_20:Number = -9.2555656;
		private const EASE_INOUT_50:Number = 50;
		private const EASE_INOUT_80:Number = 109.25556560000001;
		
//		[Test]
//		public function test_easeIn():void
//		{
//			assertEqualsFloat(EASE_IN_20, Back.easeIn(20, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_IN_50, Back.easeIn(50, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_IN_80, Back.easeIn(80, 0, 100, 100), 0.000001);
//		}
//
//		[Test]
//		public function test_easeOut():void
//		{
//			assertEqualsFloat(EASE_OUT_20, Back.easeOut(20, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_OUT_50, Back.easeOut(50, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_OUT_80, Back.easeOut(80, 0, 100, 100), 0.000001);
//		}
//		
//		[Test]
//		public function test_easeInOut():void
//		{
//			assertEqualsFloat(EASE_INOUT_20, Back.easeInOut(20, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_INOUT_50, Back.easeInOut(50, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_INOUT_80, Back.easeInOut(80, 0, 100, 100), 0.000001);
//		}
		
		[Test]
		public function test_easeIn():void
		{
			assertEqualsFloat(EASE_IN_20, Back.easeIn(.2) * 100, 0.000001);
			assertEqualsFloat(EASE_IN_50, Back.easeIn(.5) * 100, 0.000001);
			assertEqualsFloat(EASE_IN_80, Back.easeIn(.8) * 100, 0.000001);
		}
		
		[Test]
		public function test_easeOut():void
		{
			assertEqualsFloat(EASE_OUT_20, Back.easeOut(.2) * 100, 0.000001);
			assertEqualsFloat(EASE_OUT_50, Back.easeOut(.5) * 100, 0.000001);
			assertEqualsFloat(EASE_OUT_80, Back.easeOut(.8) * 100, 0.000001);
		}
		
		[Test]
		public function test_easeInOut():void
		{
			assertEqualsFloat(EASE_INOUT_20, Back.easeInOut(.2) * 100, 0.000001);
			assertEqualsFloat(EASE_INOUT_50, Back.easeInOut(.5) * 100, 0.000001);
			assertEqualsFloat(EASE_INOUT_80, Back.easeInOut(.8) * 100, 0.000001);
		}
		
	}
	
}
