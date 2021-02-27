package cs {

	import flash.display.MovieClip;
	import flash.events.*;


	public class Thomas extends MovieClip {
		var m = MovieClip(root);
		var order: int = 1;
		var talkPhase: Boolean = false;


		public function Thomas() {
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
				}
			}

		}
		function action(): void {
			switch (order) {
				case 0:
					break;
				case 1:
					m.talk(["Huh.. I was beginning to think thomas was the culprit."], "Daniel");
					bubble.gotoAndStop("daniel");
					order++;
					break;
				case 2:
					m.talk(["This is getting ridiculous.", "We are dropping like flies."], "Asako",null,false);
					bubble.gotoAndStop("asako");
					order++;
					break;
				case 3:
					m.talk(["Hey, you don't think its the panda?"], "Daniel");
					bubble.gotoAndStop("daniel");
					order++;
					break;
				case 4:
					m.talk(["Yeah, I don't trust non-humans!"], "Pen Quinn");
					bubble.gotoAndStop("pengi");
					order++;
					break;
				case 5:
					m.talk(["Works for me..."], "Asako",null,false);
					bubble.gotoAndStop("asako");
					order++;
					break;
				case 6:
					m.talk(["WAIT A MINUTE!!"], "???");
					bubble.gotoAndStop("normal");
					order++;
					break;
				case 7:
					m.talk(["What's going on over here?"], "Mrs. Marble");
					bubble.gotoAndStop("marble");
					marble.gotoAndPlay(2);
					order++;
					break;
				case 8:
					m.talk(["Oh, nothing. We're just investigating the third murder."], "Asako",null,false);
					bubble.gotoAndStop("asako");
					order++;
					break;
				case 9:
					m.talk(["Third?! Without me? Young lady, I am a semi-pro detective!","I'll take it over from here!",
				"Let's start from the beginning and look through this thoroughly!"], "Mrs. Marble");
					bubble.gotoAndStop("marble");
					order++;
					break;
				case 10:
					m.talk(["...................."], "");
					bubble.gotoAndStop("normal");
					order++;
					break;
				
				case 11:
					talkPhase = false;
					break;
			}
		}
	}

}