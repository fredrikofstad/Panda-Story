package Cutscene {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.media.Sound;
	
	/*
	loop logic ugly as sin. gonna need to rewrite at some point.
	*/


	public class Daniel extends Cutscene {

		public var wait: Boolean = false;
		var asakoForgive = true;
		var asking: Boolean = false;


		public function Daniel() {

		}
		override function loop(e: Event): void {

			if (this.currentFrame == 2) {
				if (talkPhase) {
					if (!Main.isPaused && Main.u.talk.ready) {
						action();
						order++;
					}
				}
			} else if (this.currentFrame == 4) {
				if (!asking) {
					if (talkPhase) {
						if (!Main.isPaused && Main.u.talk.ready) { //asako yes and no
							action2();
						}
					} else {
						this.gotoAndStop(5);
					}

				} else {
					if (Main.u.talk.getSignal == 2) {
						asakoForgive = true;
						order++;
						asking = false;
						Main.u.talk.reset();
					} else if (Main.u.talk.getSignal == 1) {
						asakoForgive = false;
						order++;
						asking = false;
						Main.u.talk.reset();
					}
				}
			}
		}

		function talk(speech: Array, char: String, gender: Boolean = true): void {
			Main.u.talk.say(speech, char, gender);

		}

		override function action(): void {
			switch (order) {
				case 0:
					order++;
					break;
				case 1:
					talk(["Huh.....", "....", "....", "I guess it's just you and me left, panda.", "...",
						"And I know it's not me, so it must be you...", "...",
						"...uh oh, looks like we're about to enter a tunnel."
					], "Asako", false);
					break;
				case 2:
					this.gotoAndStop(3);
					order = 0;
					break;
			}
		}
		function action2(): void {
			switch (order) {
				case 1:
					panda.gotoAndPlay("fall");
					talk(["Oh..."], "Asako", false);
					order++;
					break;
				case 2:
					//yes no case here
					talk(["Well uh.. this is awkward.", "....", "Yeah, ok it was me.",
							"But if you really think about it, aren't we all the murderers?",
							"We threw innocent people off the train!", "You get what I'm saying, right?"
						],
						"Asako");
					order++;
					break;
				case 3:
					Main.u.talk.ask(["What will you do?"], "Forgive", "Pusish");
					asking = true;
					break;
				case 4:
					if (asakoForgive) {
						talk(["Hey thanks, panda! You're alright!", "Looks like we're about to arrive."], "Asako", false);
					} else {
						talk(["!!!", "Ouch! That bamboo hurt!", "...", "Whatever, seems we're about to arrive..."], "Asako", false);
						panda.gotoAndPlay("attack");
					}
					order++;
					break;
				case 5:
					talk(["See you around, Panda."], "Asako", false);
					break;
				case 6:
					talkPhase = false;
					break;

			}
		}
	}

}