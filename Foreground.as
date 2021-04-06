package {

	import flash.display.MovieClip;
	import flash.events.*;

	public class Foreground extends MovieClip {
		var _scene:String = "empty";

		public function Foreground() {
			this.gotoAndStop(_scene);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		function init(e: Event): void {
			this.addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		function loop(e: Event) {
			if(_scene == "downtown"){
				this.x = Main.level.x + 12000;
				this.y = Main.level.y - 635
			}
		}
		public function change(scene:String):void {
			_scene = scene;
			gotoAndStop(scene);
		}
	}

}