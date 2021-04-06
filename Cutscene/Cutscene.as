package  Cutscene {

	import flash.display.MovieClip;
	import flash.events.*;


	public class Cutscene extends MovieClip {
		var m = MovieClip(root);
		var order: int = 1;
		var talkPhase: Boolean = false;
		var _char: String;
		
		public function Cutscene() {
			setup();
			
		}
		function setup(){
			this.gotoAndStop(1);
			addEventListener(Event.ENTER_FRAME, loop);
			this.addEventListener(Event.REMOVED_FROM_STAGE, kill, false, 0, true);
			talkPhase = true;
		}
		function loop(e: Event): void {
			if (this.currentFrame == 2) {
				if (talkPhase) {
					if (!Main.isPaused && Main.u.talk.ready) {
						action();
						order++;
					}
				} else {
					this.gotoAndStop(3);
				}
			}

		}
		function start(){
			this.gotoAndStop(2);
		}
		
		function action():void {}
		function kill(e: Event) {
			this.removeEventListener(Event.ENTER_FRAME, loop);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, kill);
		}

	}

}