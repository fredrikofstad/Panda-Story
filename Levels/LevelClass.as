package Levels {

	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.*;
	import com.greensock.easing.*;

	public class LevelClass extends MovieClip {
		var player;

		public function LevelClass() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		function init(e: Event): void {
			this.addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, kill, false, 0, true);
		}
		function loop(e: Event) {
			player = Main.panda;
			loopCode();
		}
		function loopCode(): void {
			//subclass override
		}
		public function say(body: Array, nName: String = null, nGender: Boolean = true) {
			Main.u.talk.say(body, nName, nGender);
		}
		function kill(e: Event) {
			this.removeEventListener(Event.ENTER_FRAME, loop);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, kill);
		}
		function fadeIn(mc: MovieClip): void {
			TweenLite.to(mc, 0.4, {
				alpha: 1
			});
		}

		function fadeOut(mc: MovieClip): void {
			TweenLite.to(mc, 1, {
				alpha: 0
			});
		}


	}

}