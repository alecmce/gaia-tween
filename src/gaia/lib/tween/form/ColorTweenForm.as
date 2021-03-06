package gaia.lib.tween.form
{
	import gaia.lib.tween.Tween;
	import gaia.lib.tween.form.manager.ManagedTweenForm;
	import gaia.lib.tween.form.manager.TweenOverlapManager;

	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;

	final public class ColorTweenForm implements ManagedTweenForm
	{
		private static const COLOR:String = "color";
		private static const KEY:Vector.<String> = Vector.<String>([COLOR]);
		
		private static const R_MASK:uint = 0x00FF0000;
		private static const G_MASK:uint = 0x0000FF00;
		private static const B_MASK:uint = 0x000000FF;
		
		private var _manager:TweenOverlapManager;
		
		private var _subject:DisplayObject;
		private var _transform:Transform;
		private var _colorTransform:ColorTransform;
		
		private var _isDisabled:Boolean;
		
		private var _startR:uint;
		private var _startG:uint;
		private var _startB:uint;

		private var _rangeR:int;
		private var _rangeG:int;
		private var _rangeB:int;
		
		private var _color:uint;
		private var _endR:int;
		private var _endG:int;
		private var _endB:int;
		
		private var r:uint, g:uint, b:uint;
		
		public function ColorTweenForm(subject:DisplayObject, color:uint, manager:TweenOverlapManager)
		{
			_subject = subject;
			_manager = manager;
			
			this.color = color;
		}
		
		public function get color():uint
		{
			return _color;
		}
		
		public function set color(value:uint):void
		{
			_color = value;
			_endR = ((_color & R_MASK) >> 16) & 0xFF;
			_endG = ((_color & G_MASK) >> 8) & 0xFF;
			_endB = (_color & B_MASK) & 0xFF;
		}
		
		public function bind(tween:Tween):void
		{
			_manager.bind(_subject, KEY, this);
			_isDisabled = false;
			
			_transform = _subject.transform;
			_colorTransform = _transform.colorTransform;
			
			var color:uint = _colorTransform.color;
			
			_startR = ((color & R_MASK) >> 16) & 0xFF;
			_startG = ((color & G_MASK) >> 8) & 0xFF;
			_startB = (color & B_MASK) & 0xFF;
			
			_rangeR = _endR - _startR;
			_rangeG = _endG - _startG;
			_rangeB = _endB - _startB;
		}
		
		public function disable(key:String):void
		{
			if (key == COLOR)
				_isDisabled = true;
		}
		
		public function update(proportion:Number):void
		{
			if (_isDisabled)
				return;
			
			r = _startR + (proportion * _rangeR) | 0;
			g = _startG + (proportion * _rangeG) | 0;
			b = _startB + (proportion * _rangeB) | 0;
			
			_colorTransform.color = r << 16 | g << 8 | b;
			_transform.colorTransform = _colorTransform;
		}

		public function unbind(tween:Tween):void
		{
			_manager.unbind(_subject, KEY);
		}
		
	}
}
