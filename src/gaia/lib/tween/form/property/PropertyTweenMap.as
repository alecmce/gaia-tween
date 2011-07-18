package gaia.lib.tween.form.property
{
	import flash.utils.Dictionary;
	
	public class PropertyTweenMap
	{
		private var _map:Dictionary;

		public function PropertyTweenMap()
		{
			_map = new Dictionary(true);
		}

		public function bind(subject:*, keys:Vector.<String>, form:PropertyTweenForm):void
		{
			var map:Object = _map[subject] ||= {};
			
			var i:uint = keys.length;
			while (i--)
			{
				var key:String = keys[i];
				var other:PropertyTweenForm = map[key];
				if (other)
					other.disable(key);
				
				map[key] = form;
			}
		}
		
		public function unbind(subject:*, keys:Vector.<String>):void
		{
			var map:Object = _map[subject];
			if (!map)
				return;
			
			var i:uint = keys.length;
			while (i--)
				delete map[keys[i]];
		}
		
	}
}
