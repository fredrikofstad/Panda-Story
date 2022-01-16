package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import MiniGame.ValveGame;

	public class Player extends MovieClip {

		private var _hp: int = 6;
		private var _life: int = 3;
		private var _scale: int = 1;

		//movement
		private var player_topSpeed: int = 10; //	max speed
		private var player_acceleration: Number = 0.4; //	acc
		private var player_friction: Number = 0.8;
		private var player_1stJumpHeight: int = -18;
		private var player_2ndJumpHeight: int = -10; //	deactivated for now
		private var player_gravity: int = 1;
		private var player_maxGravity: int = 25; //   max fall speed
		private var player_doubleJump: Boolean = false; //	maybe maybe not
		private var player_currentSpeed: Number; //  To help the calculations on the speed of player
		private var player_doubleJumpReady: Boolean = false;
		private var player_inAir: Boolean = false;
		public var player_xRight: Number = 0;
		public var player_xLeft: Number = 0;
		private var player_y: Number = 0;
		private var jump: Boolean = true;
		//ground
		private var gControl: Boolean = false;
		//collisions
		public var downBumping, leftBumping, upBumping, rightBumping, underBumping: Boolean = false;
		//animation
		private var _clothes: String = "normal";
		private var _state: String = "normal";
		//states
		public var riding: Boolean = false;
		private var getItem: String = null;
		private var attacking: Boolean = false;
		private var invincible: Boolean = false;
		private var pushing: Boolean = false;
		private var cut: Boolean = false;
		public var holding: String = null;
		//batttle
		private var invincibilityTimeLeft: int = 0;
		private var invicounter = 40;
		private var _damage = false;
		private var _knockback: int = 10;
		private var safe: Boolean = false;
		private var safetyTimer: int = 0;
		
		public var levelSpeed: Number = 0;
		public var bulletList: Array = new Array();
		

		//injects:
		private var level: LevelManager;


		public function Player(level: LevelManager) {
			this.level = level;
			createPlayer();
		}

		private function createPlayer(): void {
			addEventListener(Event.ENTER_FRAME, loop);
			x = 200;
			y = 400;
		}

		function loop(e: Event) {
			if (!cut) {
				animation();
				battle();
				movement();
				extra();
			}

		}

		function animation(): void {
			if (riding) {
				_state = "riding";
				attacking = false;
			} else if (getItem) {
				_state = "getItem";
			} else if (attacking) {
				_state = "attack"
			} else if (invincible) {
				_state = "hurt";
			} else if (pushing || (rightBumping && scaleX == -1) || (leftBumping && scaleX == 1)) {
				_state = "push"
			} else if (holding) {
				_state = "holding"
			} else {
				_state = "normal";
			}
			gotoAndStop(_clothes);
			char.gotoAndStop(_state);
			if (char.currentLabel == "holding") {
				char.holding.gotoAndStop(holding);
			}
			if (getItem) {
				itemOver.gotoAndStop(getItem);
			} else {
				itemOver.gotoAndStop("empty");
			}
			if (char.currentLabel == "riding") {
				if (player_xRight > 0.5 || player_xLeft > 0.5) {
					char.wheel.play();
				} else {
					char.wheel.stop();
				}
				if(player_inAir){
					char.skateboard.play();
					char.wheel.visible = false;
				} else {
					char.skateboard.gotoAndStop(1);
					char.wheel.visible = true;
				}
			}
		}
		function battle(): void {
			if (!Main.paused) {
				if (!invincible && !safe && Input.space && !riding) {
					attacking = true;
				}
				if (_clothes == "normal" && _state == "attack") {
					if (char.attack.currentLabel == "attack") {
						_damage = true;
					} else if (char.attack.currentLabel == "attack_done") {
						attacking = false;
						_damage = false;
					} else {
						_damage = false;
					}
				} else if(_clothes == "winter" && _state == "attack"){ //TODO: check if can attack
					if (char.attack.currentLabel == "attack") {
						fireBullet();
					} else if (char.attack.currentLabel == "attack_done") {
						attacking = false;
					}
				}
			}

			if (invincible) {
				invincibilityTimeLeft--;
			}
			if (invincibilityTimeLeft < 1) {
				invincible = false;
			}
		}
		function movement(): void {
			if(riding){
				player_topSpeed = 18;
				player_acceleration= 0.7;
			} else {
				player_topSpeed = 10;
				player_acceleration= 0.4;
			}
			if (!Main.paused) {
				if (Input.right) {
					if (player_xRight < player_topSpeed) {
						player_xRight += player_acceleration;
						scaleX = -1;
					}
				} else {
					if (player_xRight > 0.5) {
						player_xRight -= player_friction;
					} else if (player_xRight < -0.5) {
						player_xRight += player_friction;
					} else {
						player_xRight = 0;
					}
				}
				if (Input.left) {
					if (player_xLeft < player_topSpeed) {
						player_xLeft += player_acceleration;
						scaleX = 1;
					}
				} else {
					if (player_xLeft > 0.5) {
						player_xLeft -= player_friction;
					} else if (player_xLeft < -0.5) {
						player_xLeft += player_friction;
					} else {
						player_xLeft = 0;
					}
				}


				if (rightBumping) {
					player_xRight = 0;
				}

				if (leftBumping) {
					player_xLeft = 0;
				}
				if (upBumping) {
					player_y = 1;
				}
				if (downBumping) {
					player_y = 0;
					player_inAir = false;
				} else {
					if (player_y < player_maxGravity) {
						player_y += player_gravity;
					}
				}

				if (underBumping) {
					player_y = -2;
				}
				if (Input.up && jump) {
					if (downBumping) {
						player_y = player_1stJumpHeight;
						player_doubleJumpReady = false;
						player_inAir = true;
					}

					if (player_doubleJumpReady && player_inAir && player_doubleJump) {
						player_y = player_2ndJumpHeight;
						player_doubleJumpReady = false;
						player_inAir = false;
					}

				} else {
					if (player_inAir) {
						player_doubleJumpReady = true;
					}
				}
			} else {
				player_y = 0;
				player_xLeft = 0;
				player_xRight = 0;
				levelSpeed = 0;
			}
			//movement
			if (x < 850) {
				x += player_xRight;
			} else {
				level.x -= player_xRight;
				levelSpeed = -player_xLeft;
			}
			if (x > 400) {
				x -= player_xLeft;
			} else {
				level.x += player_xLeft;
				levelSpeed = player_xLeft;
				
			}

			if (y < 330 && !gControl) {
				gControl = true;
			} else if (level.y <= level.startY && gControl) {
				level.y = level.startY;
				gControl = false
			}
			if (gControl) {
				level.y -= player_y * 0.7;
				y += player_y * 0.3;
			} else {
				y += player_y;
			}

		}

		function extra(): void {
			if (_hp > 6) {
				_hp = 6;
			}
			_scale = scaleX //for mirror

			if (safetyTimer > 0) {
				safetyTimer--;
			}
			if (safetyTimer == 1) {
				safe = false;

			}

		}
		function fireBullet(): void {
			var bullet: Bullet = new Bullet(x, y, _scale);
			stage.addChild(bullet);
			bulletList.push(bullet);
			bullet.addEventListener(Event.REMOVED, bulletRemoved);
		}
		function bulletRemoved(e: Event): void {
			e.currentTarget.removeEventListener(Event.REMOVED, bulletRemoved);
			bulletList.splice(bulletList.indexOf(e.currentTarget), 1);
		}
		//mess with poor panda
		public function hurt(): void {
			Mixer.play.FX("hurt");
			invincible = true;
			invincibilityTimeLeft = invicounter;
			_hp--;
		}
		public function takeLife(): void {
			Mixer.play.FX("enemy");
			_life--;
		}
		public function knockback(): void {
			if (scaleX == 1) {
				x += _knockback;
			} else {
				x -= _knockback;
			}
		}
		public function push(): void {
			pushing = true;
		}
		public function normal(): void {
			pushing = false;
			attacking = false;
			getItem = null;
			canJump(true);
			_state = "normal";
		}
		public function reset(): void {
			_hp = 6;
			_life = 3;
		}
		public function changeClothes(clothes: String){
			_clothes = clothes;
		}
		public function canJump(activate: Boolean = true): void {
			if (activate) {
				jump = true;
			} else {
				jump = false;
			}
		}
		public function positions(_x: int, _y: int): void {
			this.x = _x;
			this.y = _y;
			downBumping = false;
		}
		public function slowDown(): void {
			player_xLeft = 0;
			player_xRight = 0;
		}
		public function makeSafe(timer: Boolean = false): void {
			if (timer) {
				safetyTimer = 30;
				safe = true;
			} else {
				safe = true;
			}
		}
		public function makeUnsafe(): void {
			safe = false;
		}
		public function halt(): void {
			cut = true;
		}
		public function resume(): void {
			cut = false;
		}
		public function gotItem(item): void {
			getItem = item;
		}

		//Get functions
		public function get hp(): int {
			return _hp;
		}
		public function get life(): int {
			return _life;
		}
		public function get scale(): int {
			return _scale;
		}
		public function get state(): String {
			return _state;
		}
		public function get isHalt(): Boolean {
			return cut;
		}
		public function get left(): int {
			return player_xLeft;
		}
		public function get right(): int {
			return player_xRight;
		}
		public function get isInvincible(): Boolean {
			return invincible;
		}
		public function get isAttacking(): Boolean {
			return _damage;
		}
		public function get inAir(): Boolean {
			return player_inAir;
		}
	}

}