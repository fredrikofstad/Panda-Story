package Cutscene {

	import flash.display.MovieClip;
	import flash.events.*;


	public class Engineer extends Cutscene {
		
		function talk(speech: Array, char: String, gender: Boolean = true): void {
			Main.u.talk.say(speech, char, gender);
			this.bubble.gotoAndStop(char);

		}


		override function action(): void {
			switch (order) {
				case 0:
					break;
				case 1:
					break;
				case 2:
					talk(["Yeah, I'm starting to think you did this, Asako."], "Daniel");
					break;
				case 3:
					talk(["Oh please, the little-girl-did-it-trope? Too cliché.",
						"Besides, Do you think I'm stupid enough to kill the only person who",
						"can drive this train?"
					], "Asako", false);
					break;
				case 4:
					talk(["Yeah... who would be that stupid?"], "Pen Quinn");
					break;
				case 5:
					talk(["Maybe the same person who would wear a fake mustache!"], "Daniel");
					break;
				case 6:
					talk(["Yeah, and why are you wearing a trench coat inside, huh?",
					"What are you hiding?"], "Asako",false);
					break;
				case 7:
					talk(["Wait! Don't you see what's going on?",
					"The culprit is trying to make us suspisious of eachother!"], "Pen Quinn");
					break;
				case 8:
					talk(["Sounds like something a killer would say!"], "Daniel");
					break;

				case 9:
					talk(["Wait, just think about it...", "I think our best bet is to trust eachother!"], "Pen Quinn");
					break;
				case 10:
					talk(["I have a better idea!"], "Daniel");
					break;

				case 11:
					talkPhase = false;
					break;
			}
		}
	}

}