package gaia.demo.tween
{
	import gaia.demo.tween.speed.GaiaMotionDemo;
	import gaia.demo.tween.speed.GaiaSpeedDemo;
	import gaia.demo.tween.speed.LibrarySpeedDemo;
	import gaia.demo.util.DemoRandom;

	import com.bit101.components.PushButton;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	[SWF(backgroundColor="#FFFFFF", frameRate="60", width="800", height="600")]
	public class SpeedDemo extends Sprite
	{
		private static const COUNT:int = 2000;
		private static const ITERATIONS:int = 5;
		
		private var _random:DemoRandom;
		private var _sprites:Vector.<Sprite>;
		
		private var _property:LibrarySpeedDemo;
		private var _motion:LibrarySpeedDemo;
		private var _tweenlite:LibrarySpeedDemo;
		
		private var _propertyButton:PushButton;
		private var _motionButton:PushButton;
		private var _tweenliteButton:PushButton;
		
		private var _output:TextField;
		private var _frames:uint;

		public function SpeedDemo()
		{
			_random = new DemoRandom(new Rectangle(20, 20, stage.stageWidth - 40, stage.stageHeight - 40));
			_sprites = new Vector.<Sprite>(COUNT, true);
			
			_frames = 0;
			
			var i:int = COUNT;
			while (i--)
			{
				var sprite:Sprite = generateSprite();
				_sprites[i] = sprite;
				addChild(sprite);
			}
			
			_property = new GaiaSpeedDemo(_random);
			_property.init(_sprites);
			
			_motion = new GaiaMotionDemo(_random);
			_motion.init(_sprites);
			
			_tweenlite = new GaiaMotionDemo(_random);
			_tweenlite.init(_sprites);
			
			_propertyButton = new PushButton(this, 5, 5, "property form", onPropertyTween);
			_motionButton = new PushButton(this, 5, 30, "motion form", onMotionTween);
			_tweenliteButton = new PushButton(this, 5, 55, "TweenLite", onTweenLite);
			_output = new TextField();
			
			_output.defaultTextFormat = new TextFormat("_sans", 12, 0, null, null, null, null, null, TextFormatAlign.RIGHT);
			_output.x = 550;
			_output.width = 250;
			_output.multiline = true;
			_output.background = true;
			_output.backgroundColor = 0xFFFFFF;
			_output.height = 12;
			addChild(_output);
			
			addEventListener(Event.ENTER_FRAME, iterate);
		}

		private function iterate(event:Event):void
		{
			++_frames;
		}
		
		private function onPropertyTween(event:MouseEvent):void
		{
			disableButtons();
			
			_frames = 0;
			_property.completed.addOnce(onGaiaTweenCompleted);
			_property.start(ITERATIONS);
		}

		private function onMotionTween(event:MouseEvent):void
		{
			disableButtons();
			
			_frames = 0;
			_motion.completed.addOnce(onMotionTweenCompleted);
			_motion.start(ITERATIONS);
		}
		
		private function onTweenLite(event:MouseEvent):void
		{
			disableButtons();
			
			_frames = 0;
			_tweenlite.completed.addOnce(onTweenliteCompleted);
			_tweenlite.start(ITERATIONS);
		}

		private function enableButtons():void
		{
			_propertyButton.visible = true;
			_motionButton.visible = true;
			_tweenliteButton.visible = true;
		}

		private function disableButtons():void
		{
			_propertyButton.visible = false;
			_motionButton.visible = false;
			_tweenliteButton.visible = false;
		}

		private function onGaiaTweenCompleted():void
		{
			_output.appendText("property form: " + _frames + " frames\n");
			_output.height = _output.textHeight + 5;
			enableButtons();
		}

		private function onMotionTweenCompleted():void
		{
			_output.appendText("motion form: " + _frames + " frames\n");
			_output.height = _output.textHeight + 5;
			enableButtons();
		}

		private function onTweenliteCompleted():void
		{
			_output.appendText("TweenLite: " + _frames + " frames\n");
			_output.height = _output.textHeight + 5;
			enableButtons();
		}
		
		private function generateSprite():Sprite
		{
			var s:Sprite = new Sprite();
			s.graphics.beginFill(_random.nextColor());
			s.graphics.drawCircle(0, 0, 2);
			s.graphics.endFill();

			var pt:Point = _random.nextPoint();
			s.x = pt.x;
			s.y = pt.y;
			
			return s;
		}
	}
}
