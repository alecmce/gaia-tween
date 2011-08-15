package gaia.demo.tween.graph
{
	import gaia.lib.tween.easing.Ease;
	
	public class GraphVO
	{
			public var ease:Ease;
			public var label:String;
			public var color:uint;
		
			public function GraphVO(ease:Ease, label:String, color:uint)
			{
				this.ease = ease;
				this.label = label;
				this.color = color;
			}
	}
	
}
