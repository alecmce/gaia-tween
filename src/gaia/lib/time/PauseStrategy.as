package gaia.lib.time
{
	public class PauseStrategy
	{
		private static var _inited:Boolean;
		
		public static const ABSOLUTE_TIME:PauseStrategy = new AbsoluteTimeStrategy();
		public static const RELATIVE_TIME:PauseStrategy = new RelativeTimeStrategy();
		
		// static code block
		{
			_inited = true;
		}
		
		public function PauseStrategy()
		{
			if (_inited)
				throw new Error("Construction of run-time PauseStrategy objects is not intended");
		}

		public function resolve(offset:uint, pauseDuration:uint):uint
		{
			return Number.NaN;
		}
		
	}
}
import gaia.lib.time.PauseStrategy;

final internal class AbsoluteTimeStrategy extends PauseStrategy
{
	override public function resolve(offset:uint, pauseDuration:uint):uint
	{
		return offset;
	}
}

final internal class RelativeTimeStrategy extends PauseStrategy
{
	override public function resolve(offset:uint, pauseDuration:uint):uint
	{
		return offset + pauseDuration;
	}
}