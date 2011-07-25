package gaia.demo.tween
{
	import gaia.lib.time.PausableTime;
	import gaia.lib.time.pause.IntrinsicTimeStrategy;
	import gaia.lib.tween.Tween;
	import gaia.lib.tween.Tweens;
	import gaia.lib.tween.easing.Quad;
	import gaia.lib.tween.form.color.ColorTweenMap;
	import gaia.lib.tween.form.color.SimpleColorTweenForm;
	import gaia.lib.util.Random;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;

	[SWF(backgroundColor="#FFFFFF", frameRate="60", width="800", height="600")]
	public class ColorDemo extends Sprite
	{
		private static const SIZE:uint = 40;
		
		private var time:PausableTime;
		private var random:Random;
		private var map:ColorTweenMap;
		
		private var grid:Vector.<Sprite>;
		private var count:uint;
		private var tweens:Tweens;
		
		private var forms:Vector.<SimpleColorTweenForm>;
		
		private var tween:Tween;
		
		public function ColorDemo()
		{
			time = new PausableTime(new IntrinsicTimeStrategy());
			time.pause();
			
			random = new Random();
			map = new ColorTweenMap();
			
			grid = generateGrid();
			count = grid.length;
			tweens = new Tweens(time, count);
			forms = generateForms();
			
			restart();
			
			stage.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			stage.addEventListener(Event.MOUSE_LEAVE, onMouseLeave);
		}

		private function onMouseOver(event:MouseEvent):void
		{
			time.resume();
		}

		private function onMouseLeave(event:Event):void
		{
			time.pause();
		}
		
		private function restart(t:Tween = null):void
		{
			var i:int = count;
			while (i--)
			{
				var form:SimpleColorTweenForm = forms[i];
				form.color = randomColor();
				tween = tweens.add(form, 1000, 0, Quad.easeInOut);
			}
			
			tween.completed.addOnce(restart);
		}
		
		private function generateForms():Vector.<SimpleColorTweenForm>
		{
			var forms:Vector.<SimpleColorTweenForm> = new Vector.<SimpleColorTweenForm>(count, true);
			
			var i:int = count;
			while (i--)
				forms[i] = new SimpleColorTweenForm(grid[i], 0, map);
			
			return forms;
		}
		
		private function generateGrid():Vector.<Sprite>
		{
			var xx:uint = 800 / SIZE;
			var yy:uint = 600 / SIZE;

			var grid:Vector.<Sprite> = new Vector.<Sprite>();
			
			for (var x:int = 0; x < xx; x++)
			{
				for (var y:int = 0; y < yy; y++)
					grid.push(generateSquare(x, y));
			}
			
			return grid;
		}

		private function generateSquare(x:int, y:int):Sprite
		{
			var s:Sprite = new Sprite();
			s.graphics.beginFill(0xFFFFFF);
			s.graphics.drawRect(0, 0, SIZE, SIZE);
			s.graphics.endFill();

			var t:ColorTransform = s.transform.colorTransform;
			t.color = randomColor();
			s.transform.colorTransform = t;
			
			s.x = x * SIZE;
			s.y = y * SIZE;
			
			addChild(s);
			return s;
		}
		
		private function randomColor():uint
		{
			var r:uint = random.nextInt(0xFF) << 16;
			var g:uint = random.nextInt(0xFF) << 8;
			var b:uint = random.nextInt(0xFF);
			
			return 0xFF000000 | r | g | b;
		}
	}
}
