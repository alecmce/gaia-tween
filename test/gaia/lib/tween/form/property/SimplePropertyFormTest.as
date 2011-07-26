package gaia.lib.tween.form.property
{
	import asunit.asserts.assertEquals;
	import asunit.framework.Async;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import gaia.lib.time.SimpleTime;
	import gaia.lib.tween.Tweens;
	import gaia.lib.tween.easing.Quad;
	import gaia.lib.tween.form.manager.TweenOverlapManager;


	
	public class SimplePropertyFormTest
	{
		[Inject]
		public var container:Sprite;
		
		[Inject]
		public var async:Async;
		
		private var tweens:Tweens;
		private var map:TweenOverlapManager;
		private var sprite:Sprite;
		private var timer:Timer;
		
		private var form:PropertyTweenForm;
		
		[Before]
		public function before():void
		{
			var time:SimpleTime = new SimpleTime();
			tweens = new Tweens(time, 2);
			
			map = new TweenOverlapManager();
			
			sprite = generateBall();
			container.addChild(sprite);
		}
		
		[After]
		public function after():void
		{
			container.removeChild(sprite);
			
			tweens = null;
		}
		
		[Test]
		public function can_tween_a_property():void
		{
			timer = new Timer(1100, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, async.add(onTimerComplete, 1200));
			timer.start();
			
			form = new SimplePropertyTweenForm(sprite, {x:700, y:500}, map);
			tweens.add(form, 1000, 0, Quad.easeInOut);
		}
		private function onTimerComplete(event:TimerEvent):void
		{
			assertEquals(700, sprite.x);
			assertEquals(500, sprite.y);
		}
		
		[Test]
		public function property_tweens_cancel_overlapping():void
		{
			timer = new Timer(1100, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, async.add(onTimerComplete2, 1200));
			timer.start();
			
			form = new SimplePropertyTweenForm(sprite, {x:700, y:500}, map);
			tweens.add(form, 1000, 0, Quad.easeInOut);
			
			form = new SimplePropertyTweenForm(sprite, {x:700, y:100}, map);
			tweens.add(form, 1000, 0, Quad.easeInOut);
		}
		private function onTimerComplete2(event:TimerEvent):void
		{
			assertEquals(700, sprite.x);
			assertEquals(100, sprite.y);
		}
		
		private function generateBall():Sprite
		{
			var s:Sprite = new Sprite();
			s.graphics.beginFill(0x9900FF);
			s.graphics.drawCircle(0, 0, 20);
			s.graphics.endFill();
			
			s.x = 100;
			s.y = 100;
			
			return s;
		}
		
	}
}
