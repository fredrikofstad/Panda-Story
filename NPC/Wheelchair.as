package NPC {
	import flash.display.MovieClip;
	import flash.events.*;

	public class Wheelchair extends NPC {
		var rotationSpeed: int = 4;

		var leftLimit: int;
		var rightLimit: int;
		var maxDistance: int = 400;
		var toilet: int;

		var state: Number = 0;
		//0 before toilet 1 at toilet 2 after toilet
		var head: Boolean = false;

		var bumpTrigger: Boolean = false;
		var upBumpTrigger: Boolean = false;



		public function Wheelchair() {
			leftLimit = this.x;
			rightLimit = this.x + maxDistance;
			toilet = this.x + 200;
		}


		override function loopCode(): void {
			player = Main.panda;
			if (this.hitbox.hitTestPoint(player.x - 25, player.y - 33)) {
				bumpTrigger = true;
				if (this.x > leftLimit) {
					player.push();
					this.x -= player.left;
					if (player.left > 0) {
						this.wheel.rotation -= rotationSpeed;
					}
				} else {
					player.leftBumping = true;
				}
			} else if (this.hitbox.hitTestPoint(player.x + 25, player.y - 33)) {
				bumpTrigger = true;
				if (this.x < rightLimit) {
					player.push();
					this.x += player.right;
					if (player.right > 0) {
						this.wheel.rotation += rotationSpeed;
					}
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
			if (this.hitbox.hitTestPoint(player.x, player.y)) {
				player.downBumping = true;
				head = true;
				upBumpTrigger = true;
			} else {
				if (upBumpTrigger) {
					player.downBumping = false;
					upBumpTrigger = false;
				}
			}

			if (this.x < toilet) {
				state = 0;
			} else if (this.x >= toilet - 50 && this.x < toilet + 50) {
				state = 1;
			} else {
				state = 2;
			}

			//talking
			if (head) {
				if (this.hitTestObject(player.hitbox) && Main.key.space) {
					Main.u.talk.say(["Sure, just use my head as a ladder..."], _name);
					head = false;
				}
			} else {
				if (state == 1) {
					talk(["Thanks, now please give me some privacy...", "I can do the rest myself."]);
				} else if (state == 2) {
					talk(["Hey man, you pushed me too far..."]);
				} else {
					talk(["Hey, can you help push me to the toilet?"]);
				}
			}

		}
	}
}