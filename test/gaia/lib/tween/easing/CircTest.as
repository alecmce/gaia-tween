package gaia.lib.tween.easing
{
	import asunit.asserts.assertEqualsFloat;
	
	/**
	 * values were found by running inputs through Penner's original easing equations
	 */
	public class CircTest
	{
		private const EASE_IN_20:Number = 2.0204102886728803;
		private const EASE_IN_50:Number = 13.397459621556141;
		private const EASE_IN_80:Number = 40.000000000000014;
		
		private const EASE_OUT_20:Number = 60;
		private const EASE_OUT_50:Number = 86.60254037844386;
		private const EASE_OUT_80:Number = 97.97958971132712;
		
		private const EASE_INOUT_20:Number = 4.174243050441601;
		private const EASE_INOUT_50:Number = 50;
		private const EASE_INOUT_80:Number = 95.82575694955841;
		
//		[Test]
//		public function test_easeIn():void
//		{
//			assertEqualsFloat(EASE_IN_20, Circ.easeIn(20, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_IN_50, Circ.easeIn(50, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_IN_80, Circ.easeIn(80, 0, 100, 100), 0.000001);
//		}
//
//		[Test]
//		public function test_easeOut():void
//		{
//			assertEqualsFloat(EASE_OUT_20, Circ.easeOut(20, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_OUT_50, Circ.easeOut(50, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_OUT_80, Circ.easeOut(80, 0, 100, 100), 0.000001);
//		}
//		
//		[Test]
//		public function test_easeInOut():void
//		{
//			assertEqualsFloat(EASE_INOUT_20, Circ.easeInOut(20, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_INOUT_50, Circ.easeInOut(50, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_INOUT_80, Circ.easeInOut(80, 0, 100, 100), 0.000001);
//		}
		
		[Test]
		public function test_easeIn():void
		{
			assertEqualsFloat(EASE_IN_20, Circ.easeIn(.2) * 100, 0.000001);
			assertEqualsFloat(EASE_IN_50, Circ.easeIn(.5) * 100, 0.000001);
			assertEqualsFloat(EASE_IN_80, Circ.easeIn(.8) * 100, 0.000001);
		}

		[Test]
		public function test_easeOut():void
		{
			assertEqualsFloat(EASE_OUT_20, Circ.easeOut(.2) * 100, 0.000001);
			assertEqualsFloat(EASE_OUT_50, Circ.easeOut(.5) * 100, 0.000001);
			assertEqualsFloat(EASE_OUT_80, Circ.easeOut(.8) * 100, 0.000001);
		}
		
		[Test]
		public function test_easeInOut():void
		{
			assertEqualsFloat(EASE_INOUT_20, Circ.easeInOut(.2) * 100, 0.000001);
			assertEqualsFloat(EASE_INOUT_50, Circ.easeInOut(.5) * 100, 0.000001);
			assertEqualsFloat(EASE_INOUT_80, Circ.easeInOut(.8) * 100, 0.000001);
		}
	}
	
}
