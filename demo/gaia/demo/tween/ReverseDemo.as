package gaia.demo.tween
{
	import gaia.demo.util.DemoRandom;
	import gaia.lib.time.SimpleTime;
	import gaia.lib.tween.Tween;
	import gaia.lib.tween.Tweens;
	import gaia.lib.tween.easing.Quad;
	import gaia.lib.tween.form.MotionTweenForm;
	import gaia.lib.tween.form.manager.TweenOverlapManager;

	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	[SWF(backgroundColor="#FFFFFF", frameRate="60", width="800", height="600")]
	public class ReverseDemo extends Sprite
	{
		private static const COUNT:uint = 25;
		private static const DELAY:uint = 2500;
		private static const DURATION:uint = 5000;
		
		private var time:SimpleTime;
		private var random:DemoRandom;
		private var tweens:Tweens;
		
		private var state:Vector.<uint>;
		private var delays:Vector.<uint>;
		private var sprites:Vector.<Sprite>;
		private var motions:Vector.<MotionTweenForm>;
		private var list:Vector.<Tween>;
		
		public function ReverseDemo()
		{
			time = new SimpleTime();
			time.tick.add(onTick);
			
			random = new DemoRandom(new Rectangle(25, 25, 750, 550));
			tweens = new Tweens(time, COUNT);
			
			state = new Vector.<uint>(COUNT, true);
			delays = new Vector.<uint>(COUNT, true);
			sprites = new Vector.<Sprite>(COUNT, true);
			motions = new Vector.<MotionTweenForm>(COUNT, true);
			list = new Vector.<Tween>(COUNT, true);
			
			generateSprites();
			generateMotions();
			generateTweens();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.focus = this;
		}

		private function onKeyDown(event:KeyboardEvent):void
		{
			var i:int = COUNT;
			while (i--)
			{
				if (list[i] && list[i].reverse())
					setState(i, 0xFF8800);
				else
					generateTween(i);
			}
		}

		private function generateSprites():void
		{
			var i:int = COUNT;
			while (i--)
			{
				var sprite:Sprite = generateSprite();
				sprites[i] = sprite;
				addChild(sprite);
			}
		}

		private function generateSprite():Sprite
		{
			var sprite:Sprite = new Sprite();
			
			sprite.graphics.beginFill(0xFFFFFF);
			sprite.graphics.drawCircle(0, 0, 20);
			sprite.graphics.endFill();
			
			var pt:Point = random.nextPoint(pt);
			sprite.x = pt.x;
			sprite.y = pt.y;
			
			return sprite;
		}
		
		private function generateMotions():void
		{
			var manager:TweenOverlapManager = new TweenOverlapManager();
			
			var i:int = COUNT;
			while (i--)
				motions[i] = new MotionTweenForm(sprites[i], 0, 0, manager);
		}
		
		private function generateTweens():void
		{
			var i:int = COUNT;
			while (i--)
				generateTween(i);
		}
		
		private function generateTween(i:uint):void
		{
			var delay:uint = random.nextInt(DELAY);
			var duration:uint = random.nextInt(DURATION);

			var pt:Point = random.nextPoint(pt);
			motions[i].set(pt.x, pt.y);
			
			var tween:Tween = tweens.add(motions[i], duration, delay, Quad.easeOut);
			tween.completed.addOnce(onTweenCompleted);
			
			delays[i] = delay + time.now;
			list[i] = tween;
			setState(i, 0x1E90FF);
		}

		private function onTweenCompleted(tween:Tween):void
		{
			var i:int = list.indexOf(tween);
			list[i] = null;
			setState(i, 0xFF0000);
		}
		
		private function onTick(time:uint):void
		{
			var i:uint = COUNT;
			while (i--)
			{
				if (state[i] == 0x1E90FF && time > delays[i])
					setState(i, 0x00FF00);
			}
		}
		
		private function setState(i:uint, color:uint):void
		{
			state[i] = color;
			
			var sprite:Sprite = sprites[i];
			var ct:ColorTransform = sprite.transform.colorTransform;
			
			ct.color = color;
			sprite.transform.colorTransform = ct;
		}
		
	}
}
