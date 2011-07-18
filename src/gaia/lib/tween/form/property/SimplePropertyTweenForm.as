package gaia.lib.tween.form.property
{
	import gaia.lib.tween.Tween;
	
	final public class SimplePropertyTweenForm implements PropertyTweenForm
	{
		private var _map:PropertyTweenMap;
		
		private var _subject:*;
		
		private var _count:uint;
		private var _active:uint;
		private var _keys:Vector.<String>;
		private var _starts:Vector.<Number>;
		private var _ranges:Vector.<Number>;
		
		private var i:uint;

		public function SimplePropertyTweenForm(subject:*, properties:Object, map:PropertyTweenMap)
		{
			_subject = subject;
			parseProperties(properties);
			_map = map;
		}
		
		public function bind(tween:Tween):void
		{
			_map.bind(_subject, _keys, this);
			_active = _count;
		}
		
		public function update(proportion:Number):void
		{
			i = _active;
			while (i--)
				_subject[_keys[i]] = _starts[i] + proportion * _ranges[i];
		}

		public function unbind(tween:Tween):void
		{
			_map.unbind(_subject, _keys);
		}

		public function set(key:String, value:Number):void
		{
			var start:Number = _subject[key];
			if (start != start)
				return;
			
			i = _keys.indexOf(key);
			if (i != -1)
				changeValue(i, start, value - start);
			else
				addValue(key, start, value - start);
		}
		
		private function changeValue(index:uint, start:Number, range:Number):void
		{
			_starts[i] = start;
			_ranges[i] = range;
		}
		
		private function addValue(key:String, start:Number, range:Number):void
		{
			_keys.fixed = false;
			_starts.fixed = false;
			_ranges.fixed = false;
			
			_keys.unshift(key);
			_starts.unshift(start);
			_ranges.unshift(range);
			
			_keys.fixed = true;
			_starts.fixed = true;
			_ranges.fixed = true;
			
			++_active;
			++_count;
			
			_map.bind(_subject, Vector.<String>([key]), this);
		}
		
		private function parseProperties(properties:Object):void
		{
			_keys = new Vector.<String>();
			_starts = new Vector.<Number>();
			_ranges = new Vector.<Number>();
			
			_count = 0;
			for (var key:String in properties)
			{
				var start:Number = _subject[key];
				if (start != start)
					continue;
				
				var end:Number = properties[key];
				if (end != end)
					continue;
				
				_keys.push(key);
				_starts.push(start);
				_ranges.push(end - start);
				++_count;
			}
			
			_active = _count;
			_keys.fixed = true;
			_starts.fixed = true;
			_ranges.fixed = true;
		}

		public function disable(key:String):void
		{
			var i:int = _keys.indexOf(key);
			if (i == -1)
				return;
			
			var start:Number = _starts[i];
			var range:Number = _ranges[i];
			
			--_active;
			_keys[i] = _keys[_active];
			_keys[_active] = key;
			
			_starts[i] = _starts[_active];
			_starts[_active] = start;
			
			_ranges[i] = _ranges[_active];
			_ranges[_active] = range;
		}
		
	}
}
