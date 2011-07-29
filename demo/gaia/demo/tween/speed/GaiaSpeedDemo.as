package gaia.demo.tween.speed
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import gaia.demo.util.DemoRandom;
	import gaia.lib.notice.SingularNotice;
	import gaia.lib.notice.SingularNoticeDispatcher;
	import gaia.lib.time.SimpleTime;
	import gaia.lib.time.Time;
	import gaia.lib.tween.Tween;
	import gaia.lib.tween.Tweens;
	import gaia.lib.tween.easing.Quad;
	import gaia.lib.tween.form.PropertyTweenForm;
	import gaia.lib.tween.form.manager.TweenOverlapManager;

	
	public class GaiaSpeedDemo implements LibrarySpeedDemo
	{

		private static const X:String = "x";
		private static const Y:String = "y";

		private var _completed:SingularNoticeDispatcher;

		private var _time:Time;
		private var _random:DemoRandom;
		private var _tweens:Tweens;
		private var _list:Vector.<Tween>;

		private var _count:uint;
		private var _forms:Vector.<PropertyTweenForm>;
		private var _map:TweenOverlapManager;

		private var _tween:Tween;

		private var _isStarted:Boolean;

		private var _iterations:uint;

		public function GaiaSpeedDemo(random:DemoRandom)
		{
			_completed = new SingularNoticeDispatcher();

			_time = new SimpleTime();
			this._random = random;
			_map = new TweenOverlapManager();

			_isStarted = false;
		}

		public function init(sprites:Vector.<Sprite>):void
		{
			_count = sprites.length;
			_tweens = new Tweens(_time, _count);
			_list = new Vector.<Tween>(_count, true);
			_forms = new Vector.<PropertyTweenForm>(_count, true);

			var i:int = _count;
			var pt:Point = new Point();
			while (i--)
			{
				pt = _random.nextPoint(pt);
				_forms[i] = new PropertyTweenForm(sprites[i], {x:pt.x, y:pt.y}, _map);
			}
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
				var form:PropertyTweenForm = _forms[i];
				pt = _random.nextPoint(pt);
				form.set(X, pt.x);
				form.set(Y, pt.y);
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

		public function get completed():SingularNotice
		{
			return _completed;
		}

	}
}
