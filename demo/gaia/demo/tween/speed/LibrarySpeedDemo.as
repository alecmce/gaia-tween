package gaia.demo.tween.speed
{
	import org.osflash.signals.ISignal;

	import flash.display.Sprite;
	
	public interface LibrarySpeedDemo
	{
		
		function init(sprites:Vector.<Sprite>):void;
		
		function start(iterations:uint):void;
		
		function stop():void;
		
		function get completed():ISignal;
		
	}
}
