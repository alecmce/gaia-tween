package gaia.lib.tween.form.color
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	public class ColorTweenMap
	{
		private var _map:Dictionary;

		public function ColorTweenMap()
		{
			_map = new Dictionary(true);
		}

		public function bind(subject:DisplayObject, form:ColorTweenForm):void
		{
			var other:ColorTweenForm = _map[subject];
			if (other)
				other.disable();
			
			_map[subject] = form;
		}
		
		public function unbind(subject:DisplayObject):void
		{
			delete _map[subject];
		}
		
	}
}
