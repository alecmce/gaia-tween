package  
{
	import asunit.core.TextCore;

	import flash.display.Sprite;

	[SWF(backgroundColor="#FFFFFF", frameRate="60", width="800", height="600")]
	final public class ProjectTestRunner extends Sprite
	{
		
		public function ProjectTestRunner()
		{
			var core:TextCore = new TextCore();
			core.start(AllTests, null, this);
		}
		
	}
}
