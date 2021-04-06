package Objects {
	import flash.display.MovieClip;
	import flash.events.*;

	public class Door extends MovieClip {

		var player;
		var doorTrigger: Boolean = false;

		public function Door() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		function init(e: Event): void {
			this.addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, kill, false, 0, true);
			player = Main.panda;
		}
		function loop(e: Event) {
			loopCode();
			cantJump();
		}

		function loopCode(): void {

		}
		function cantJump(): void {
			if (!player.riding) {
				if (this.hitTestObject(player.hitbox)) {
					player.canJump(false);
					doorTrigger = true;
				} else {
					if (doorTrigger) {
						player.canJump();
						doorTrigger = false;
					}
				}
			}
		}

		public function enter(levelselect: int, extra: int = 0): void {
			if (active && Input.up) {
				Main.level.changeStage(levelselect, extra);
			}
		}
		public function get active(): Boolean {
			if (this.hitTestObject(player.hitbox) && !player.inAir && !player.riding) {
				return true;
			} else {
				return false
			}
		}

		function kill(e: Event) {
			this.removeEventListener(Event.ENTER_FRAME, loop);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, kill);
		}

	}

}