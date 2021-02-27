package cs {

	import flash.display.MovieClip;
	import flash.events.*;


	public class Marco extends MovieClip {
		var m = MovieClip(root);
		var order: int = 1;
		var talkPhase: Boolean = false;


		public function Marco() {
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
					m.talk(["Is he... Dead?"], "Asako",null,false);
					bubble.gotoAndStop("asako");
					order++;
					break;
				case 2:
					m.talk(["...A train murder mystery? Isn't that a bit overdone?"], "Daniel");
					bubble.gotoAndStop("daniel");
					order++;
					break;
				case 3:
					m.talk(["Does it really matter? No one liked Marco anyway."], "Thomas");
					bubble.gotoAndStop("thomas");
					order++;
					break;
				case 4:
					m.talk(["Yeah, no harm, no foul."], "Mr. Greene");
					bubble.gotoAndStop("greene");
					order++;
					break;
				case 5:
					m.talk(["Shouldn't we figure out who did it regardless?"], "Asako",null,false);
					bubble.gotoAndStop("asako");
					order++;
					break;
				case 6:
					m.talk(["Greene did it. I saw him vent."], "Daniel");
					bubble.gotoAndStop("daniel");
					order++;
					break;
				case 7:
					m.talk(["....Excuse me??"], "Mr. Greene");
					bubble.gotoAndStop("greene");
					order++;
					break;
				case 8:
					m.talk(["Yeah, I heard you venting about how Marco was gonna", "take all your inheritance.... Def sus."], "Daniel");
					bubble.gotoAndStop("daniel");
					order++;
					break;
				case 9:
					m.talk(["Sounds legit."], "Thomas");
					bubble.gotoAndStop("thomas");
					order++;
					break;
				case 10:
					m.talk(["Yeah, I'm convinced."], "Asako",null,false);
					bubble.gotoAndStop("asako");
					order++;
					break;
				case 11:
					m.talk(["Wait... So... What happens to me now?"], "Mr. Greene");
					bubble.gotoAndStop("greene");
					order++;
					break;
				case 12:
					m.talk(["Well................"], "Daniel");
					bubble.gotoAndStop("daniel");
					order++;
					break;
				case 13:
					talkPhase = false;
					break;
			}
		}
	}

}