package {
	import flash.display.MovieClip;
	import flash.events.*;

	public class Enemy extends MovieClip {
		var player;
		var damage: Number = 1;
		var speed: Number = 5;
		var distance: Number = 200;
		var r_distance: Number = 0;
		var knockback: Number = 20;
		var going_right: Boolean = true;
		var died: Boolean = false;

		public function Enemy() {
			this.addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, kill, false, 0, true);
			r_distance = distance * 2;
			gotoAndStop(1);

		}
		function loop(e: Event): void {

			player = Main.panda;
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
				if (player.isAttacking && this.hitbox.hitTestObject(player.damage)) {
					if (currentFrame < 2) {
						this.removeEventListener(Event.ENTER_FRAME, loop);
						Mixer.play.FX("die");
						if (Main.i.enemyKilled(name)) {
								died = true;
								this.removeEventListener(Event.ENTER_FRAME, loop);
								this.gotoAndStop(3);
							} else {
								died = true;
								this.gotoAndStop(2);
								Main.i.pushEnemy(name);
							}

						}
					}


					if (!died && this.hitbox.hitTestObject(player.hitbox)) {
						if (currentFrame < 2) {
							player.knockback();
							if (!player.isInvincible) {
								player.hurt();
							}
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
