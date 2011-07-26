package gaia.lib.tween.form.property
{
	import flash.utils.Dictionary;
	import gaia.lib.tween.form.manager.TweenOverlapManager;
	
	final public class PropertyTweenFormPool
	{
		private var _map:TweenOverlapManager;
		
		private var _dimension:uint;
		private var _length:uint;
		private var _list:Vector.<PooledPropertyTweenForm>;
		private var _count:uint;
		private var _propertyMaps:Dictionary;
		
		public function PropertyTweenFormPool(map:TweenOverlapManager, initialCount:uint)
		{
			_map = map;
			
			_dimension = Math.ceil(Math.log(initialCount) * Math.LOG2E);
			_length = 1 << _dimension;
			_list = new Vector.<PooledPropertyTweenForm>(_length, true);
			_count = 0;
			
			_propertyMaps = new Dictionary(true);
			
			var i:int = initialCount;
			while (i--)
				_list[i] = new PooledPropertyTweenForm(this, _map);
		}
		
		public function require(subject:*, properties:Object):PropertyTweenForm
		{
			if (_count == _length)
			{
				_list.fixed = false;
				_list.length = _length = 1 << ++_dimension;
				_list.fixed = true;
			}

			var form:PooledPropertyTweenForm = _list[_count] ||= new PooledPropertyTweenForm(this, _map);
			form.init(subject, properties, _count++);
			
			return form;
		}
		
		// called by PropertyTweenForm
		internal function reset(form:PooledPropertyTweenForm, i:uint):void
		{
			_list[i] = _list[--_count];
			_list[_count] = form;
		}
		
	}
}
