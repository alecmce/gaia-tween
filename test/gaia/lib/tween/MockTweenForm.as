package gaia.lib.tween
{
	
	public class MockTweenForm implements TweenForm
	{
		
		public var id:String;
		public var proportion:Number;
		
		public function MockTweenForm(id:String)
		{
			this.id = id;
		}

		public function update(proportion:Number):void
		{
			this.proportion = proportion;
		}
		
	}
	
}
