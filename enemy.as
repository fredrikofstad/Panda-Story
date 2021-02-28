package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.*;
	
	public class Enemy extends MovieClip {
		var player: MovieClip;
		var mainTimeLine = MovieClip(root);
		var damage: Number = 1;
		var speed: Number = 5;
		var distance: Number = 90;
		var r_distance: Number = 0;
		var knockback: Number = 20;
		var going_right: Boolean = true;
		var died: Boolean = false;
		var hurt: hurtsound = new hurtsound();
		var die: enemydiesound = new enemydiesound();

		public function Enemy() {
			this.addEventListener(Event.ENTER_FRAME, upDate);
			r_distance = distance * 2;
			if (this.name.indexOf("man") >= 0) {
				this.ani.gotoAndStop("salaryman");
			} else {
				this.ani.gotoAndStop("monkey");
			}

		}
		function upDate(e: Event): void {
			mainTimeLine = MovieClip(root);
			player = mainTimeLine.player;
			if (!died) {
				if (going_right) {
					x += speed;
					this.scaleX = 1;
					distance -= speed;
					if (distance <= 0) {
						going_right = false;
						distance = r_distance;
					}
				} else {
					x -= speed;
					this.scaleX = -1;
					distance -= speed;
					if (distance <= 0) {
						going_right = true;
						distance = r_distance;
					}
				}
			}

			if (!died && mainTimeLine.hurtbox) {
				if (this.hitbox.hitTestObject(player.hurtbox)) {
					if (currentFrame < 2) {
						die.play();
						if (mainTimeLine.enemiestaken.indexOf(this.name) > -1) {
							died = true;
							this.removeEventListener(Event.ENTER_FRAME, upDate);
							this.gotoAndStop(3);
						} else {
							died = true;
							this.gotoAndStop(2);
							mainTimeLine.enemiestaken.push(this.name);
							trace(mainTimeLine.enemiestaken);
							this.removeEventListener(Event.ENTER_FRAME, upDate);
						}
					}
				}

			}

			if (!died && this.hitbox.hitTestObject(player.hitbox)) {
				if (currentFrame < 2) {
					if (!mainTimeLine.isInvincible) {
						mainTimeLine.gotHit();
						mainTimeLine.hp -= damage;
						hurt.play();

					}
					if (player.scaleX == 1) {
						player.x += knockback;
					} else {
						player.x -= knockback;
					}
				}
			}
		}
	}

}