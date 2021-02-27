package cs {

	import flash.display.MovieClip;
	import flash.events.*;


	public class Engineer extends MovieClip {
		var m = MovieClip(root);
		var order: int = 1;
		var talkPhase: Boolean = false;


		public function Engineer() {
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
					
					order++;
					break;
				case 2:
					m.talk(["Yeah, I'm starting to think you did this, Asako."], "Daniel");
					bubble.gotoAndStop("daniel");
					order++;
					break;
				case 3:
					m.talk(["Oh please, the little-girl-did-it-trope? Too cliché.",
					"Besides, Do you think I'm stupid enough to kill the only person who", 
					"can drive this train?"], "Asako",null,false);
					bubble.gotoAndStop("asako");
					order++;
					break;
				case 4:
					m.talk(["Yeah... who would be that stupid?"], "Pen Quinn");
					bubble.gotoAndStop("pengi");
					order++;
					break;
				case 5:
					m.talk(["Maybe the same person who would wear a fake mustache!"], "Daniel");
					bubble.gotoAndStop("daniel");
					order++;
					break;
				case 6:
					m.talk(["Yeah, and why are you wearing a trench coat inside, huh?","What are you hiding?"], "Asako",null,false);
					bubble.gotoAndStop("asako");
					order++;
					break;
				case 7:
					m.talk(["Wait! Don't you see what's going on?", "The culprit is trying to make us suspisious of eachother!"], "Pen Quinn");
					bubble.gotoAndStop("pengi");
					order++;
					break;
				case 8:
					m.talk(["Sounds like something a killer would say!"], "Daniel");
					bubble.gotoAndStop("daniel");
					order++;
					break;
		
				case 9:
					m.talk(["Wait, just think about it...","I think our best bet is to trust eachother!"], "Pen Quinn");
					bubble.gotoAndStop("pengi");
					order++;
					break;
				case 10:
					m.talk(["I have a better idea!"], "Daniel");
					bubble.gotoAndStop("daniel");
					order++;
					break;
				
				case 11:
					talkPhase = false;
					break;
			}
		}
	}

}