package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.*;


	public class Sledding extends MovieClip {
		var friction: Number = .75;
		var velocity: Number = 50;
		var direction: int = -1; //resets to -1 every time the jump starts
		var jumping = false;
		var rockList: Array = new Array();
		var rockSpawnTimeLeft: Number = 10;
		var HP: int = 6;
		var invincibilityTimeLeft: Number;
		var invicounter: Number = 20;
		var isInvincible: Boolean = false;
		var scoreC: Number = 0;
		var lost: Boolean = true;
		var start: Boolean = true;
		var hurt: hurtsound = new hurtsound();
		var snow2: Snow = new Snow(3, 200, false);
		
		var m = MovieClip(root);
		//var t: Touch = new Touch;

		public function Sledding() {
			// constructor code
			addEventListener(Event.ENTER_FRAME, update);
			addChild(snow2);
			/*addChild(t);
			t.hu.addEventListener(TouchEvent.TOUCH_BEGIN, dohu);
			t.hs.addEventListener(TouchEvent.TOUCH_BEGIN, dohs);
			*/
			HP = 6;


		}
		function update(e: Event): void {
			if (scoreC <= 2500) {
				sky.gotoAndStop("day")
				score.textColor = 0x000000;
				highscore.textColor = 0x000000;
				info.textColor = 0x000000;
			} else if (scoreC > 2500 && scoreC < 4000) {
				sky.gotoAndStop("sunset");
			} else {
				sky.gotoAndStop("night");
				score.textColor = 0xFFFFFF;
				highscore.textColor = 0xFFFFFF;
				info.textColor = 0xFFFFFF;
			}

			if (lost) {
				if (start) {
					bar.gotoAndStop("start");
					if (Main.transfer) {
						start = true;
						lost = true;
						removeSelf();
					}
				} else {
					bar.gotoAndStop("lost");
					if (Main.upPressed) {
						restart();
					} else if (Main.transfer) {
						start = true;
						lost = true;
						removeSelf();
					}
				}
			} else {
				bar.gotoAndStop("alive");
			}

			if (start) {
				if (Main.upPressed) {
					start = false;
					lost = false;
					restart();

				}
			}

			score.text = String(scoreC);
			highscore.text = String(Main.sledscore);

			sledTree();

			if (!lost) {
				sledHP.gotoAndStop(HP);
			} else {
				if (Main.sledscore < scoreC) {
					Main.sledscore = scoreC;
				}
				sledHP.gotoAndStop("lost");
			}
			if (HP < 1) {
				lost = true;
				if (rockList.length > 0) {
					for (var i: int = 0; i < rockList.length; i++) {
						rockList[i].removeSelf();
					}
				}
			}

			if (!lost) {
				scoreC++
				if (isInvincible) {
					invincibilityTimeLeft--;
				}
				if (invincibilityTimeLeft < 1) {
					isInvincible = false;
				}


				if (rockList.length > 0) {
					for (var j: int = 0; j < rockList.length; j++) {
						if (sled.hitbox.hitTestObject(rockList[j]) && !isInvincible) {
							HP -= 2;
							hurt.play();
							invincibilityTimeLeft = invicounter;
							isInvincible = true;
						}
					}
				}


				rockSpawnTimeLeft--;
				if (rockSpawnTimeLeft < 1) {
					sledRock()
					rockSpawnTimeLeft = 30 + Math.floor(Math.random() * 30);
				}

				if (Main.upPressed && !jumping) {
					jumping = true;
					velocity = 25;
					direction = -1;
				}
				if (jumping) {
					mainJump();
				}
			}

		}

		function sledTree(): void {
			tree.x -= 13;
			tree.y -= 5;
			if (tree.x < -700) {
				tree.x = 1400;
				tree.y = 540;
			}
		}

		function sledRock(): void {
			var rock: Rock = new Rock;
			addChild(rock);
			rockList.push(rock);
			rock.addEventListener(Event.REMOVED, rockRemoved);
		}
		function rockRemoved(e: Event): void {
			e.currentTarget.removeEventListener(Event.REMOVED, rockRemoved);
			rockList.splice(rockList.indexOf(e.currentTarget), 1);
		}


		//jumping function
		function mainJump() {
			sled.y += velocity * direction;
			if (direction < 0) {
				velocity *= friction; //reduce velocity goin up
			} else {
				velocity *= 1 + (1 - friction); //increase velocity while falling
			}

			if (velocity < 1) direction = 1; //if less than 1 pixel, change direction
			if (sled.y > 390) { //floor
				sled.y = 390;
				jumping = false;
			}
		}
		function dohu(e: TouchEvent): void {
			addEventListener(TouchEvent.TOUCH_END, endhu);
			Main.upPressed = true;
		}
		function dohs(e: TouchEvent): void {
			addEventListener(TouchEvent.TOUCH_END, endhs);
			m.space();
		}

		//FINISH
		function endhu(e: TouchEvent): void {
			removeEventListener(TouchEvent.TOUCH_END, endhu);
			Main.upPressed = false;
		}

		function endhs(e: TouchEvent): void {
			removeEventListener(TouchEvent.TOUCH_END, endhs);
			m.spaceUp();
		}

		function restart(): void {
			lost = false;
			HP = 6;
			scoreC = 0;
		}
		public function removeSelf(): void {
			removeEventListener(Event.ENTER_FRAME, upDate);
			MovieClip(root).sledding = false;
			MovieClip(root).paused = false;
			this.parent.removeChild(this);
		}
	}
}