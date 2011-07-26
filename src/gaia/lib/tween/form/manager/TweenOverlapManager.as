package gaia.lib.tween.form.manager
{
	import flash.utils.Dictionary;
	
	public class TweenOverlapManager
	{
		private var _map:Dictionary;

		public function TweenOverlapManager()
		{
			_map = new Dictionary(true);
		}

		public function bind(subject:*, keys:Vector.<String>, form:ManagedTweenForm):void
		{
			var map:Object = _map[subject] ||= {};
			
			var i:uint = keys.length;
			while (i--)
			{
				var key:String = keys[i];
				var other:ManagedTweenForm = map[key];
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
