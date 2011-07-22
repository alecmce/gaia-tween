package gaia.demo.tween.speed
{
	
	import gaia.lib.notice.SingularNotice;
	import gaia.lib.notice.SingularNoticeDispatcher;
	import gaia.lib.time.SimpleTime;
	import gaia.lib.time.Time;
	import gaia.lib.tween.Tween;
	import gaia.lib.tween.Tweens;
	import gaia.lib.tween.easing.Quad;
	import gaia.lib.tween.form.property.PropertyTweenForm;
	import gaia.lib.tween.form.property.PropertyTweenMap;
	import gaia.lib.tween.form.property.SimplePropertyTweenForm;
	import gaia.lib.util.Random;

	import flash.display.Sprite;

	public class GaiaSpeedDemo implements LibrarySpeedDemo
	{

		private static const X:String = "x";
		private static const Y:String = "y";

		private var _completed:SingularNoticeDispatcher;

		private var time:Time;
		private var random:Random;
		private var tweens:Tweens;
		private var list:Vector.<Tween>;

		private var count:uint;
		private var forms:Vector.<PropertyTweenForm>;
		private var map:PropertyTweenMap;

		private var tween:Tween;

		private var isStarted:Boolean;

		private var _iterations:uint;

		public function GaiaSpeedDemo(random:Random)
		{
			_completed = new SingularNoticeDispatcher();

			time = new SimpleTime();
			this.random = random;
			map = new PropertyTweenMap();

			isStarted = false;
		}

		public function init(sprites:Vector.<Sprite>):void
		{
			count = sprites.length;
			tweens = new Tweens(time, count);
			list = new Vector.<Tween>(count, true);
			forms = new Vector.<PropertyTweenForm>(count, true);

			var i:int = count;
			while (i--)
			{
				var x:int = random.nextInt(700) + 50;
				var y:int = random.nextInt(500) + 50;
				forms[i] = new SimplePropertyTweenForm(sprites[i], {x:x, y:y}, map);
			}
		}

		public function start(iterations:uint):void
		{
			if (isStarted)
				return;

			isStarted = true;
			_iterations = iterations;
			restart();
		}

		public function stop():void
		{
			if (!isStarted)
				return;

			isStarted = false;
			tween.completed.remove(restart);

			var i:int = count;
			while (i--)
				list[i].cancel();
		}

		private function restart(t:Tween = null):void
		{
			var i:int = count;
			while (i--)
			{
				var form:PropertyTweenForm = forms[i];
				form.set(X, random.nextInt(700) + 50);
				form.set(Y, random.nextInt(500) + 50);
				list[i] = tween = tweens.add(form, 1000, 0, Quad.easeInOut);
			}

			if (_iterations--)
				tween.completed.addOnce(restart);
			else
				tween.completed.addOnce(complete);
		}

		private function complete(t:Tween):void
		{
			isStarted = false;
			_completed.dispatch();
		}

		public function get completed():SingularNotice
		{
			return _completed;
		}

	}
}
