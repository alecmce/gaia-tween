package gaia.lib.tween.form
{
	import gaia.lib.tween.Tween;
	
	public interface TweenForm
	{
		/**
		 * The method that is used when a tween is about to begin
		 */
		function bind(tween:Tween):void;
		
		/**
		 * The method that is used by a Tween to update the on-going tween
		 * 
		 * @param proportion The eased value of the tween (probably between 0 and 1, but
		 * potentially a broader range depending upon the applied ease)
		 */
		function update(proportion:Number):void;
		
		/**
		 * The method that is used when a tween has completed
		 * 
		 * @param tween The tween that has been 
		 */
		function unbind(tween:Tween):void;

	}
}
