package gaia.demo.tween.graph
{
	
	public class GraphVO
	{
			public var fn:Function;
			public var label:String;
			public var color:uint;
		
			public function GraphVO(fn:Function, label:String, color:uint)
			{
				this.fn = fn;
				this.label = label;
				this.color = color;
			}
	}
	
}
