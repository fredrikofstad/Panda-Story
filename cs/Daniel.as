package cs {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.media.Sound;


	public class Daniel extends MovieClip {
		var m = MovieClip(root);
		public var order: int = 1;
		var talkPhase: Boolean = false;
		public var wait: Boolean = false;


		public function Daniel() {
			this.gotoAndStop(1);
			addEventListener(Event.ENTER_FRAME, loop);
			talkPhase = true;
		}
		function loop(e: Event): void {
			m = MovieClip(root);

			if (this.currentFrame == 2) {
				if (talkPhase) {
					if (!Main.csTalk) {
						action();
					}
				} else {
					this.gotoAndStop(3);
					talkPhase = true;
					order = 1
				}
			}else if (this.currentFrame == 4) {
				if (talkPhase) {
					if (!Main.csTalk && !Main.question) {
						action2();
					}
				} else {
					this.gotoAndStop(5);
				}
			}

		}
		function action(): void {
			switch (order) {
				case 0:
					break;
				case 1:
					m.talk(["Huh.....", "....", "....", "I guess it's just you and me left, panda.", "...",
						"And I know it's not me, so it must be you...", "...",
						"...uh oh, looks like we're about to enter a tunnel."
					], "Asako", null, false);
					order++;
					break;
				case 2:
					talkPhase = false;
					break;

			}
		}
		function action2(): void {
			switch (order) {
				case 1:
					panda.gotoAndPlay("fall");
					m.talk(["Oh..."], "Asako", null, false);
					order++
					break;
				case 2:
					m.yesnoCase = 6;
					m.talk(["Well uh.. this is awkward.", "....", "Yeah, ok it was me.",
					"But if you really think about it, aren't we all the murderers?", 
					"We threw innocent people off the train!","You get what I'm saying, right?"],
					"Asako", null, false, "Forgive Asako?");
					order++;
					break;
				case 3:
					if(Main.asakoForgive){
						m.talk(["Hey thanks, panda! You're alright!","Looks like we're about to arrive."], "Asako", null, false);
						order++;
					} else{
						
						m.talk(["!!!","Ouch! That bamboo hurt!","...","Whatever, seems we're about to arrive..."], "Asako", null, false);
						panda.gotoAndPlay("attack");
						order++;
					}
					
					break;
				case 4:
					m.talk(["See you around, Panda."], "Asako", null, false);
					order++;
					break;
				case 5:
					talkPhase = false;
					break;

			}
		}
	}

}