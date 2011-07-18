package gaia.lib.tween.easing
{
	import asunit.asserts.assertEqualsFloat;
	
	/**
	 * values were found by running inputs through Penner's original easing equations
	 */
	public class QuadTest
	{
		private const EASE_IN_20:Number = 4;
		private const EASE_IN_50:Number = 25;
		private const EASE_IN_80:Number = 64;
		
		private const EASE_OUT_20:Number = 36;
		private const EASE_OUT_50:Number = 75;
		private const EASE_OUT_80:Number = 96;
		
		private const EASE_INOUT_20:Number = 8;
		private const EASE_INOUT_50:Number = 50;
		private const EASE_INOUT_80:Number = 92;
		
//		[Test]
//		public function test_easeIn():void
//		{
//			assertEqualsFloat(EASE_IN_20, Quad.easeIn(20, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_IN_50, Quad.easeIn(50, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_IN_80, Quad.easeIn(80, 0, 100, 100), 0.000001);
//		}
//
//		[Test]
//		public function test_easeOut():void
//		{
//			assertEqualsFloat(EASE_OUT_20, Quad.easeOut(20, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_OUT_50, Quad.easeOut(50, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_OUT_80, Quad.easeOut(80, 0, 100, 100), 0.000001);
//		}
//		
//		[Test]
//		public function test_easeInOut():void
//		{
//			assertEqualsFloat(EASE_INOUT_20, Quad.easeInOut(20, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_INOUT_50, Quad.easeInOut(50, 0, 100, 100), 0.000001);
//			assertEqualsFloat(EASE_INOUT_80, Quad.easeInOut(80, 0, 100, 100), 0.000001);
//		}
		
		[Test]
		public function test_easeIn():void
		{
			assertEqualsFloat(EASE_IN_20, Quad.easeIn(.2) * 100, 0.000001);
			assertEqualsFloat(EASE_IN_50, Quad.easeIn(.5) * 100, 0.000001);
			assertEqualsFloat(EASE_IN_80, Quad.easeIn(.8) * 100, 0.000001);
		}

		[Test]
		public function test_easeOut():void
		{
			assertEqualsFloat(EASE_OUT_20, Quad.easeOut(.2) * 100, 0.000001);
			assertEqualsFloat(EASE_OUT_50, Quad.easeOut(.5) * 100, 0.000001);
			assertEqualsFloat(EASE_OUT_80, Quad.easeOut(.8) * 100, 0.000001);
		}
		
		[Test]
		public function test_easeInOut():void
		{
			assertEqualsFloat(EASE_INOUT_20, Quad.easeInOut(.2) * 100, 0.000001);
			assertEqualsFloat(EASE_INOUT_50, Quad.easeInOut(.5) * 100, 0.000001);
			assertEqualsFloat(EASE_INOUT_80, Quad.easeInOut(.8) * 100, 0.000001);
		}
		
	}
	
}
