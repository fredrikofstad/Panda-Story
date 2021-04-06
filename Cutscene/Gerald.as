package  Cutscene {

	import flash.display.MovieClip;
	import flash.events.*;


	public class Gerald extends Cutscene {
		
		function talk(speech: Array, char: String, gender: Boolean = true): void {
			Main.u.talk.say(speech, char, gender);
			this.bubble.gotoAndStop(char);

		}


		override function action(): void {
			switch (order) {
				case 0:
					break;
				case 1:
					talk(["Welp, looks like another one bit the dust."], "Thomas");
					break;
				case 2:
					talk(["Is this gonna be a regular occurance?",
						"Cause I got other stuff to do besides playing detective."
					], "Daniel");
					break;
				case 3:
					talk(["Hey trench coat guy, what do you think?"], "Asako", false);
					break;
				case 4:
					talk(["I uhh... Well... He did die in the diner cart..."], "Pen Quinn");
					break;
				case 5:
					talk(["Of course! The culprit must be the chef!"], "Thomas");
					break;
				case 6:
					talk(["Yeah, I didn't even understand a single word he said."], "Asako", false);
					break;
				case 7:
					talk(["Well, if we all agree........"], "Daniel");
					break;
				case 8:
					talkPhase = false;
					break;
			}
		}
	}

}