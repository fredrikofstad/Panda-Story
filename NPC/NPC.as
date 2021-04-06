package NPC {
	import flash.display.MovieClip;
	import flash.events.*;
	import com.greensock.easing.Strong;

	public class NPC extends MovieClip {

		var _name;
		var _gender: Boolean = true; //true = male
		var safeTrigger: Boolean = true;
		var player;
		var speed: int = 4;
		var distance: int = 250;
		var r_distance: int = distance * 2;
		var going_right: Boolean = true;
		var asking = false;
		var trigger = false;
		var giving: Boolean = false;
		var _item: String;
		var level:MovieClip = (parent as MovieClip);

		public function NPC() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		function init(e: Event): void {
			this.addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, kill, false, 0, true);
			player = Main.panda;
			_name = this.name;
		}
		function loop(e: Event) {
			if (colliding) {
				player.makeSafe();
				safeTrigger = true;
			} else {
				if (safeTrigger) {
					player.makeUnsafe();
					safeTrigger = false;
				}
			}
			if (asking) {
				if (Main.u.talk.getSignal == 2) {
					asking = false;
					Main.u.talk.reset();
					doAction();
				} else if (Main.u.talk.getSignal == 1) {
					asking = false;
					Main.u.talk.reset();
				}
			}
			if (giving) {
				giveItem(_item);
			}
			loopCode();

		}
		function loopCode(): void {

		}
		public function get touch() {
			if (this.hitTestObject(player.hitbox) && Input.space && player.player_xLeft < 0.5 && player.player_xRight < 0.5 && !asking) {
				return true;
			} else {
				asking = false;
				return false;
			}
		}
		public function say(body: Array, nName: String = null, nGender: Boolean = true,
			nAsk: Array = null, item: String = null) {
			if (!nName) {
				nName = _name;
			}
			if (nGender) {
				nGender = _gender;
			}
			if (nAsk && !asking) {
				Main.u.talk.say(body, nName, nGender, nAsk);
				asking = true;
			} else {
				Main.u.talk.say(body, nName, nGender);
			}
			if (item) {
				giving = true;
				_item = item;
			}
		}
		public function talk(body: Array, nName: String = null, nGender: Boolean = true,
			nAsk: Array = null, item: String = null) {
			if (touch) {
				if (!nName) {
					nName = _name;
				}
				if (nGender) {
					nGender = _gender;
				}
				if (nAsk && !asking) {
					Main.u.talk.say(body, nName, nGender, nAsk);
					asking = true;
				} else {
					Main.u.talk.say(body, nName, nGender);
				}
				if (item) {
					giving = true;
					_item = item;
				}
			}
		}
		
		public function ask(body: Array, yes: String = "Yes", no: String = "No") {
			if (touch && !asking) {
				Main.u.talk.ask(body, yes, no);
				asking = true;
			}

		}
		function giveItem(item: String): void {
			if (Main.u.talk.ready && !Main.isPaused) {
				Main.i.keyItemAdd(item);
				giving = false;
			}
		}
		function doAction(): void {
			trace(this.name + " -check this object");
		}
		public function wander() {
			if (!Main.isPaused) {
				if (going_right) {
					x += speed;
					this.scaleX = -1;
					distance -= speed;
					if (distance < 1) {
						going_right = false;
						distance = r_distance;
					}
				} else {
					x -= speed;
					this.scaleX = 1;
					distance -= speed;
					if (distance < 1) {
						going_right = true;
						distance = r_distance;
					}
				}
			}
		}
		function get colliding(): Boolean {
			if (this.hitTestObject(player.hitbox)) {
				return true;
			} else {
				return false;
			}
		}

		function kill(e: Event) {
			this.removeEventListener(Event.ENTER_FRAME, loop);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, kill);
		}

	}

}