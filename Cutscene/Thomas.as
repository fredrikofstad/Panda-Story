package Cutscene {

	import flash.display.MovieClip;
	import flash.events.*;


	public class Thomas extends Cutscene {

		function talk(speech: Array, char: String, gender: Boolean = true): void {
			Main.u.talk.say(speech, char, gender);
			if (char == "???" || char == "") {
				this.bubble.gotoAndStop("normal");
			} else {
				this.bubble.gotoAndStop(char);
			}

		}


		override function action(): void {
			switch (order) {
				case 0:
					break;
				case 1:
					talk(["Huh.. I was beginning to think thomas was the culprit."], "Daniel");
					break;
				case 2:
					talk(["This is getting ridiculous.", "We are dropping like flies."], "Asako", false);
					break;
				case 3:
					talk(["Hey, you don't think its the panda?"], "Daniel");
					break;
				case 4:
					talk(["Yeah, I don't trust non-humans!"], "Pen Quinn");
					break;
				case 5:
					talk(["Works for me..."], "Asako", false);
					break;
				case 6:
					talk(["WAIT A MINUTE!!"], "???");
					break;
				case 7:
					talk(["What's going on over here?"], "Mrs. Marble");
					marble.gotoAndPlay(2);
					break;
				case 8:
					talk(["Oh, nothing. We're just investigating the third murder."], "Asako", false);
					break;
				case 9:
					talk(["Third?! Without me? Young lady, I am a semi-pro detective!", "I'll take it over from here!",
						"Let's start from the beginning and look through this thoroughly!"], "Mrs. Marble");
					break;
				case 10:
					talk(["...................."], "");
					break;
				case 11:
					talkPhase = false;
					break;
			}
		}
	}

}