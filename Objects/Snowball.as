package Objects {
	import flash.display.MovieClip;
	import flash.events.*;

	public class Snowball extends MovieClip {
		var player;
		var speed: Number = 1;
		var originalX: Number;
		var snowMax, madehead: Boolean = false;
		var snowmanComplete: Boolean = false;
		var head: Snowhead = new Snowhead();
		var finished: finishedsnow = new finishedsnow();
		var bumpTrigger: Boolean = false;
		var upBumpTrigger: Boolean = false;

		var leftLimit: int;
		var rightLimit: int;
		var maxDistance: int = 300;


		public function Snowball() {
			this.addEventListener(Event.ENTER_FRAME, loop, false,0,true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, kill, false,0,true);
			originalX = this.x;
			leftLimit = originalX - maxDistance;
			rightLimit = originalX + maxDistance;


		}

		function snowgrow(): void {
			this.scaleX += 0.005;
			this.scaleY += 0.005;
		}

		function growleft(): void {
			if (this.x < originalX - 15) {
				snowgrow()
				originalX = this.x;
				if (!snowMax) {
					this.rotation -= 4;
				}
			}
		}
		function growright(): void {
			if (this.x > originalX + 15) {
				snowgrow()
				originalX = this.x;
				if (!snowMax) {
					this.rotation += 4;
					this.y -= 0.25
				}
			}
		}

		public function makesnowman(): void {
			if (snowMax) {
				if (!madehead) {
					addChild(head);
					head.x = this.x;
					head.y = this.y - 80;
					madehead = true;
				} else {
					if (head.scaleX < 2.8) {
						head.scaleX += 0.2
						head.scaleY += 0.2
						head.y -= 2
					} else {
						magicsnow();

					}
				}
			}
		}
		public function magicsnow(): void {
			snowmanComplete = true; //in progression class also 
			this.parent.addChild(finished);
			finished.x = this.x;
			finished.y = this.y - 15;
			removeChild(head);
		}

		function loop(e: Event): void {

			player = Main.panda;

			if (this.scaleX > 1.5) {
				snowMax = true;
				if (bumpTrigger) {
					player.leftBumping = false;
					player.rightBumping = false;
					player.normal();
					bumpTrigger = false;
				}
			}
			if (!snowmanComplete) {


				if (this.hitTestPoint(player.x - 25, player.y - 33)) {
					bumpTrigger = true;
					if (!snowMax && this.x > leftLimit) {
						player.push();
						this.x -= player.left;
						growleft();
					} else {
						player.leftBumping = true;
					}
				} else if (this.hitTestPoint(player.x + 25, player.y - 33)) {
					bumpTrigger = true;
					if (!snowMax && this.x < rightLimit) {
						player.push();
						this.x += player.right;
						growright();
					} else {
						player.rightBumping = true;
					}
				} else {
					if (bumpTrigger) {
						player.leftBumping = false;
						player.rightBumping = false;
						player.normal();
						bumpTrigger = false;
					}
				}
				if (this.hitTestPoint(player.x, player.y - 10)) {
					player.downBumping = true;
					upBumpTrigger = true;
				} else {
					if (upBumpTrigger) {
						player.downBumping = false;
						upBumpTrigger = false;
					}
				}
			}

		}
		function kill(e: Event) {
			this.removeEventListener(Event.ENTER_FRAME, loop);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, kill);
		}

	}

}