package gaia.lib.util
{
	public class Random
	{
		private var _seed:uint;
		private var _current:uint;
		
		public function Random(seed:uint = 1)
		{
			_seed = seed == 0 ? 1 : seed;
			_current = _seed;
		}

		public function get seed():uint
		{
			return _seed;
		}

		public function set seed(seed:uint):void
		{
			_seed = seed;
			_current = seed;
		}

		public function nextInt(range:uint = 0):uint
		{
			return range == 0 ? next() : next() % range;
		}

		public function nextDouble(range:Number = 1):Number
		{
			return range * (next() / 2147483647);
		}
		
		private function next():uint
		{
			return (_current = (_current * 16807) % 2147483647);
		}
		
	}
}
