package Item {
	
	import flash.events.*;
	
	public class CoinSpawn extends Coin {
		var jump_height: Number = 18;
		var jump_height_range: Number = 2;
		var side_length: Number = 3;
		var range: Number = 100;
		var y_speed: Number = -0;
		var x_speed: Number = 0;
		var y_value: Number = 0;
		var distanceX: Number;
		var distanceY: Number;
		var distanceTotal: Number;
		var moveX: Number;
		var moveY: Number;
		var downBumping: Boolean = false;
		var count: int = 0;
		public function CoinSpawn() {
			x_speed = randomRange(-side_length, side_length);
			y_value = y;
			y_speed = -randomRange(jump_height - jump_height_range, jump_height + jump_height_range);
		}
		override function loop(e: Event): void {
			count += 1;
			player = Main.panda;

			if (this.hitTestObject(player.hitbox) && count > 20) {
				playerHit();
				Mixer.play.FX("coin");
			}

			if (y > y_value) {
				downBumping = true;
			}
			if (downBumping) {
				y_speed = 0;
				if (x_speed < 0) {
					x_speed += 0.1;
					if (x_speed > -0.1) {
						x_speed = 0;
					}
				}
				if (x_speed > 0) {
					x_speed -= 0.1;
					if (x_speed < 0.1) {
						x_speed = 0;
					}
				}
			} else {
				if (x_speed > 0) {
					x_speed -= 0.01;
				}
				if (x_speed < 0) {
					x_speed += 0.01;
				}
				y_speed += 1;
			}
			y += y_speed;
			x += x_speed;
		}
		override function playerHit(): void {
			Main.i.coinAdd();
			remove();

		}
		function randomRange(minNum: Number, maxNum: Number): Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}

	}
}