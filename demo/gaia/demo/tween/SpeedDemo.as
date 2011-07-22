package gaia.demo.tween
{
	import flash.text.TextFormatAlign;
	import gaia.demo.tween.speed.GaiaSpeedDemo;
	import gaia.demo.tween.speed.LibrarySpeedDemo;
	import gaia.demo.tween.speed.TweenLiteSpeedDemo;
	import gaia.lib.util.Random;
	import com.bit101.components.PushButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	[SWF(backgroundColor="#FFFFFF", frameRate="60", width="800", height="600")]
	public class SpeedDemo extends Sprite
	{
		private static const COUNT:int = 2000;
		private static const ITERATIONS:int = 5;
		
		private var random:Random;
		private var sprites:Vector.<Sprite>;
		
		private var _gaia:LibrarySpeedDemo;
		private var _tweenlite:LibrarySpeedDemo;
		
		private var _gaiaButton:PushButton;
		private var _tweenliteButton:PushButton;
		private var _output:TextField;
		private var _frames:uint;
		
		public function SpeedDemo()
		{
			random = new Random();
			sprites = new Vector.<Sprite>(COUNT, true);
			
			_frames = 0;
			
			var i:int = COUNT;
			while (i--)
			{
				var sprite:Sprite = generateSprite();
				sprites[i] = sprite;
				addChild(sprite);
			}
			
			_gaia = new GaiaSpeedDemo(random);
			_gaia.init(sprites);
			
			_tweenlite = new TweenLiteSpeedDemo(random);
			_tweenlite.init(sprites);
			
			_gaiaButton = new PushButton(this, 5, 5, "gaia-tween", onGaiaTween);
			_tweenliteButton = new PushButton(this, 5, 30, "TweenLite", onTweenLite);
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
		
		private function onGaiaTween(event:MouseEvent):void
		{
			disableButtons();
			
			_frames = 0;
			_gaia.completed.addOnce(onGaiaTweenCompleted);
			_gaia.start(ITERATIONS);
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
			_gaiaButton.visible = true;
			_tweenliteButton.visible = true;
		}

		private function disableButtons():void
		{
			_gaiaButton.visible = false;
			_tweenliteButton.visible = false;
		}

		private function onGaiaTweenCompleted():void
		{
			_output.appendText("GaiaTween: " + _frames + " frames\n");
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
			s.graphics.beginFill(0x9900FF);
			s.graphics.drawCircle(0, 0, 2);
			s.graphics.endFill();
			
			s.x = random.nextInt(700) + 50;
			s.y = random.nextInt(500) + 50;
			
			return s;
		}
	}
}
