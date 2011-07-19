package gaia.demo.tween
{
	import gaia.lib.time.SimpleTime;
	import gaia.lib.time.Time;
	import gaia.lib.tween.Tween;
	import gaia.lib.tween.Tweens;
	import gaia.lib.tween.form.property.PropertyTweenForm;
	import gaia.lib.tween.form.property.PropertyTweenMap;
	import gaia.lib.tween.form.property.SimplePropertyTweenForm;
	import gaia.lib.util.Random;

	import flash.display.Sprite;

	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="800", height="600")]
	public class PropertyTweenDemo extends Sprite
	{
		private static const COUNT:int = 1000;
		
		private var time:Time;
		private var random:Random;
		private var tweens:Tweens;
		
		private var balls:Vector.<Sprite>;
		private var forms:Vector.<PropertyTweenForm>;
		private var map:PropertyTweenMap;
		
		public function PropertyTweenDemo()
		{
			time = new SimpleTime();
			random = new Random();
			tweens = new Tweens(time, 8);
			
			map = new PropertyTweenMap();
			
			balls = new Vector.<Sprite>(COUNT, true);
			forms = new Vector.<PropertyTweenForm>(COUNT, true);
			
			var i:int = COUNT;
			while (i--)
			{
				var ball:Sprite = generateBall();
				var x:int = random.nextInt(700) + 50;
				var y:int = random.nextInt(500) + 50;
				var form:SimplePropertyTweenForm = new SimplePropertyTweenForm(ball, {x:x, y:y}, map);

				var tween:Tween = tweens.add(form, 1000);
				
				addChild(ball);

				balls[i] = ball;
				forms[i] = form;
			}
			
			tween.completed.addOnce(onTweenCompleted);
		}

		private function onTweenCompleted(tween:Tween):void
		{
			var i:int = COUNT;
			while (i--)
			{
				var form:PropertyTweenForm = forms[i];
				form.set("x", random.nextInt(700) + 50);
				form.set("y", random.nextInt(500) + 50);

				tween = tweens.add(form, 1000);
			}
			
			tween.completed.addOnce(onTweenCompleted);
		}
		
		private function generateBall():Sprite
		{
			var s:Sprite = new Sprite();
			s.graphics.beginFill(0x9900FF);
			s.graphics.drawCircle(0, 0, 2);
			s.graphics.endFill();
			
			s.x = random.nextInt(700) + 50;
			s.y = random.nextInt(500) + 50;
			
			return s;
		}
	}
}
