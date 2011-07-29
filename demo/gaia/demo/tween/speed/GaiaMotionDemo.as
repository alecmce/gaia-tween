package gaia.demo.tween.speed
{
	import gaia.demo.util.DemoRandom;
	import gaia.lib.time.SimpleTime;
	import gaia.lib.time.Time;
	import gaia.lib.tween.Tween;
	import gaia.lib.tween.Tweens;
	import gaia.lib.tween.easing.Quad;
	import gaia.lib.tween.form.MotionTweenForm;
	import gaia.lib.tween.form.manager.TweenOverlapManager;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class GaiaMotionDemo implements LibrarySpeedDemo
	{
		private var _completed:Signal;

		private var _time:Time;
		private var _random:DemoRandom;
		private var _tweens:Tweens;
		private var _list:Vector.<Tween>;

		private var _count:uint;
		private var _forms:Vector.<MotionTweenForm>;
		private var _manager:TweenOverlapManager;

		private var _tween:Tween;

		private var _isStarted:Boolean;

		private var _iterations:uint;

		public function GaiaMotionDemo(random:DemoRandom)
		{
			_completed = new Signal();

			_time = new SimpleTime();
			_random = random;
			_manager = new TweenOverlapManager();

			_isStarted = false;
		}

		public function init(sprites:Vector.<Sprite>):void
		{
			_count = sprites.length;
			_tweens = new Tweens(_time, _count);
			_list = new Vector.<Tween>(_count, true);
			_forms = new Vector.<MotionTweenForm>(_count, true);

			var i:int = _count;
			while (i--)
				_forms[i] = new MotionTweenForm(sprites[i], 0, 0, _manager);
		}

		public function start(iterations:uint):void
		{
			if (_isStarted)
				return;

			_isStarted = true;
			_iterations = iterations;
			restart();
		}

		public function stop():void
		{
			if (!_isStarted)
				return;

			_isStarted = false;
			_tween.completed.remove(restart);

			var i:int = _count;
			while (i--)
				_list[i].cancel();
		}

		private function restart(t:Tween = null):void
		{
			var i:int = _count;
			var pt:Point = new Point();
			while (i--)
			{
				var form:MotionTweenForm = _forms[i];
				pt = _random.nextPoint(pt);
				form.set(pt.x, pt.y);
				_list[i] = _tween = _tweens.add(form, 1000, 0, Quad.easeInOut);
			}

			if (_iterations--)
				_tween.completed.addOnce(restart);
			else
				_tween.completed.addOnce(complete);
		}

		private function complete(t:Tween):void
		{
			_isStarted = false;
			_completed.dispatch();
		}

		public function get completed():ISignal
		{
			return _completed;
		}

	}
}
