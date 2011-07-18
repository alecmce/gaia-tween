package gaia.lib.tween
{
	import gaia.lib.tween.form.TweenForm;
	
	public class MockTweenForm implements TweenForm
	{
		
		public var id:String;
		public var proportion:Number;
		public var tween:Tween;
		
		public function MockTweenForm(id:String)
		{
			this.id = id;
		}

		public function update(proportion:Number):void
		{
			this.proportion = proportion;
		}

		public function bind(tween:Tween):void
		{
			this.tween = tween;
		}

		public function unbind(tween:Tween):void
		{
			this.tween = null;
		}

	}
	
}
