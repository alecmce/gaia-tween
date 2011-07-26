package gaia.demo.util
{
	import gaia.lib.util.Random;

	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class DemoRandom extends Random
	{

		private var _bounds:Rectangle;

		public function DemoRandom(bounds:Rectangle, seed:uint = 0)
		{
			super(seed);
			
			_bounds = bounds;
		}
		
		public function nextPoint(pt:Point = null):Point
		{
			pt ||= new Point();
			pt.x = _bounds.left + nextInt(_bounds.width);
			pt.y = _bounds.top + nextInt(_bounds.height);
			
			return pt;
		}

		public function nextColor():uint
		{
			var r:uint = nextInt(0xFF) << 16;
			var g:uint = nextInt(0xFF) << 8;
			var b:uint = nextInt(0xFF);
			
			return 0xFF000000 | r | g | b;
		}

		
	}
}
