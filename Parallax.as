package {

	import flash.display.MovieClip;
	import flash.events.*;


	public class Parallax extends MovieClip {

		private var level: LevelManager;

		public function Parallax(level: LevelManager) {
			this.level = level;
			addEventListener(Event.ADDED_TO_STAGE, init);
			this.gotoAndStop("night");
		}
		function loop(e: Event): void {
			this.x = level.getX * 0.2;
		}
		function init(e: Event): void {
			this.addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, kill, false, 0, true);
		}
		public function change(scene:String):void {
			gotoAndStop(scene);
		}
		function kill(e: Event) {
			this.removeEventListener(Event.ENTER_FRAME, loop);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, kill);
		}
	}

}