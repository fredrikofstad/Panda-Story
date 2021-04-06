package {

	import flash.display.MovieClip;
	import flash.events.*;


	public class Talk extends MovieClip {
		var body: Array;
		var speech: String;
		var male: Boolean;

		var arrayPosition: int = 0;
		var textPosition: int = 0;
		var textSpeed: int = 1;
		var talking = false;
		var asking = false;
		var timer: int = 0;
		public var safe: Boolean = false;
		var yes: String;
		var no: String;
		var qyes: Boolean = true;
		var signal: int = 0;
		var fAsk: Array = null;



		public function Talk() {
			this.gotoAndStop("say");
			addEventListener(Event.ENTER_FRAME, loop);
		}

		public function say(i_body: Array, i_name: String, i_male: Boolean = true,
			i_ask: Array = null): void {
			if (!talking && !safe && !Main.paused) {
				this.gotoAndStop("say");
				talking = true;
				Main.pauseGame();
				arrayPosition = 0;
				textPosition = 0;
				//inputs
				body = i_body;
				male = i_male;
				if (i_name == "") {
					tName.text = "";
				} else {
					var cName: String = (i_name.substr(0, 1).toUpperCase() + i_name.substr(1, i_name.length));
					tName.text = "-" + cName + "-";
				}
				//setting up text
				speech = body[arrayPosition];
				fAsk = i_ask;
			}
		}

		public function ask(i_body: Array, i_yes: String = "Yes", i_no: String = "No"): void {
			if (!asking && !safe && !Main.paused) {
				this.gotoAndStop("ask");
				arrow.visible = false;
				tyes.text = "";
				tno.text = "";
				qyes = true;
				asking = true;
				Main.pauseGame();
				arrayPosition = 0;
				textPosition = 0;
				body = i_body;
				yes = i_yes;
				no = i_no;
				speech = body[arrayPosition];
			}

		}

		function loop(e: Event): void {
			if (timer > 0) {
				timer--;
				safe = true;
			} else {
				safe = false;
			}
			if (talking) {
				this.visible = true;
				tBody.text = speech.substr(0, textPosition);
				speech = body[arrayPosition];
				if (textPosition < speech.length) {
					textPosition += textSpeed;
					arrow.visible = false;
					if (male) {
						Mixer.play.FX("male");
					} else {
						Mixer.play.FX("female");
					}

				} else {
					arrow.visible = true;
					if (Main.key.space) {
						arrayPosition++
						textPosition = 0;
						if (arrayPosition >= body.length) {
							exit();
						}
					}
				}
			} else if (asking) {
				this.visible = true;
				tBody.text = speech.substr(0, textPosition);
				speech = body[arrayPosition];
				if (textPosition < speech.length) {
					textPosition += textSpeed;
					arrow.visible = false;
				} else {
					arrow.visible = true;
					tyes.text = yes;
					tno.text = no;


					if (qyes) {
						arrow.gotoAndStop("yes");
						if (Main.key.right) {
							qyes = false;
						}
					} else {
						arrow.gotoAndStop("no");
						if (Main.key.left) {
							qyes = true;
						}
					}

					if (Main.key.space) {
						if (qyes) {
							signal = 2;
						} else {
							signal = 1;
						}
						exit();
					}

				}

			} else {
				this.visible = false;
			}

		}
		function exit(): void {
			asking = false;
			talking = false;
			Main.unpauseGame();
			Main.panda.makeSafe(true);
			Main.panda.normal();
			if (fAsk) {
				ask(fAsk);
				fAsk = null;
			} else {
				safe = true;
				timer = 10;
			}
		}
		public function get getSignal(): int {
			return signal;
		}
		public function reset(): void {
			signal = 0;
		}
		public function get ready(): Boolean {
			if (safe) {
				return false;
			} else {
				return true;
			}
		}
	}

}