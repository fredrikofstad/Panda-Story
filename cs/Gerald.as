package cs {

	import flash.display.MovieClip;
	import flash.events.*;


	public class Gerald extends MovieClip {
		var m = MovieClip(root);
		var order: int = 1;
		var talkPhase: Boolean = false;


		public function Gerald() {
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
					m.talk(["Welp, looks like another one bit the dust."], "Thomas");
					bubble.gotoAndStop("thomas");
					order++;
					break;
				case 2:
					m.talk(["Is this gonna be a regular occurance?", "Cause I got other stuff to do besides playing detective."], "Daniel");
					bubble.gotoAndStop("daniel");
					order++;
					break;
				case 3:
					m.talk(["Hey trench coat guy, what do you think?"], "Asako",null,false);
					bubble.gotoAndStop("asako");
					order++;
					break;
				case 4:
					m.talk(["I uhh... Well... He did die in the diner cart..."], "Pen Quinn");
					bubble.gotoAndStop("pengi");
					order++;
					break;
				case 5:
					m.talk(["Of course! The culprit must be the chef!"], "Thomas");
					bubble.gotoAndStop("thomas");
					order++;
					break;
				case 6:
					m.talk(["Yeah, I didn't even understand a single word he said."], "Asako",null,false);
					bubble.gotoAndStop("asako");
					order++;
					break;
				case 7:
					m.talk(["Well, if we all agree........"], "Daniel");
					bubble.gotoAndStop("daniel");
					order++;
					break;
				case 8:
					talkPhase = false;
					break;
			}
		}
	}

}