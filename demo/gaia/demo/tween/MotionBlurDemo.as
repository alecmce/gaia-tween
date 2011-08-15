package gaia.demo.tween
{
	import gaia.demo.util.DemoRandom;
	import gaia.lib.time.SimpleTime;
	import gaia.lib.tween.Tween;
	import gaia.lib.tween.Tweens;
	import gaia.lib.tween.easing.Quad;
	import gaia.lib.tween.form.MotionBlurTweenForm;
	import gaia.lib.tween.form.manager.TweenOverlapManager;

	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	[SWF(backgroundColor="#FFFFFF", frameRate="60", width="800", height="600")]
	public class MotionBlurDemo extends Sprite
	{
		private static const COUNT:uint = 200;
		private static const DELAY:uint = 100;
		private static const DURATION:uint = 5000;
		
		private var time:SimpleTime;
		private var random:DemoRandom;
		private var tweens:Tweens;
		
		private var state:Vector.<uint>;
		private var delays:Vector.<uint>;
		private var sprites:Vector.<Sprite>;
		private var motions:Vector.<MotionBlurTweenForm>;
		private var list:Vector.<Tween>;

		public function MotionBlurDemo()
		{
			time = new SimpleTime();
			
			random = new DemoRandom(new Rectangle(25, 25, 750, 550));
			tweens = new Tweens(time, COUNT);
			
			state = new Vector.<uint>(COUNT, true);
			delays = new Vector.<uint>(COUNT, true);
			sprites = new Vector.<Sprite>(COUNT, true);
			motions = new Vector.<MotionBlurTweenForm>(COUNT, true);
			list = new Vector.<Tween>(COUNT, true);
			
			generateSprites();
			generateMotions();
			generateTweens();
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
			sprite.graphics.drawCircle(0, 0, 5);
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
				motions[i] = new MotionBlurTweenForm(sprites[i], 0, 0, 10, manager, Quad.easeOut);
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
			
			var tween:Tween = tweens.add(motions[i], duration, delay);
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
			
			generateTween(i);
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
