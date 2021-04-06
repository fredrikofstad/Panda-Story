package Item {
	import flash.display.MovieClip;
	import flash.events.*;
	import Mixer;

	public class Item extends MovieClip {
		var player;

		public function Item() {
			
			if (Main.i.alreadyTaken(this.name)) {
				this.visible = false;
			} else {
				this.addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
				this.addEventListener(Event.REMOVED_FROM_STAGE, kill, false, 0, true);
			}
		}
		function loop(e: Event): void {
			player = Main.panda;

			if (this.hitTestObject(player.hitbox)) {
				playerHit();
				remove();
				Main.i.pushCoins(this.name);
				Mixer.play.FX("coin");
			}
		}

		function playerHit(): void {
			//override this
		}
		function kill(e: Event) {
			this.removeEventListener(Event.ENTER_FRAME, loop);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, kill);
		}
		function remove(): void {
			this.parent.removeChild(this);
			this.removeEventListener(Event.ENTER_FRAME, loop);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, kill);
		}
	}
}