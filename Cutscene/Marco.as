package Cutscene {

	import flash.display.MovieClip;
	import flash.events.*;


	public class Marco extends Cutscene {
		
		
		function talk(speech: Array, char: String, gender: Boolean = true): void {
			Main.u.talk.say(speech, char, gender);
			this.bubble.gotoAndStop(char);

		}


		override function action(): void {
			switch (order) {
				case 0:
					break;
				case 1:
					talk(["Is he... Dead?"], "Asako", false);
					break;
				case 2:
					talk(["...A train murder mystery? Isn't that a bit overdone?"], "Daniel");
					break;
				case 3:
					talk(["Does it really matter? No one liked Marco anyway."], "Thomas");
					break;
				case 4:
					talk(["Yeah, no harm, no foul."], "Mr. Greene");
					break;
				case 5:
					talk(["Shouldn't we figure out who did it regardless?"], "Asako", false);
					break;
				case 6:
					talk(["Greene did it. I saw him vent."], "Daniel");
					break;
				case 7:
					talk(["....Excuse me??"], "Mr. Greene");
					break;
				case 8:
					talk(["Yeah, I heard you venting about how Marco was gonna", "take all your inheritance.... Def sus."], "Daniel");
					break;
				case 9:
					talk(["Sounds legit."], "Thomas");
					break;
				case 10:
					talk(["Yeah, I'm convinced."], "Asako", false);
					break;
				case 11:
					talk(["Wait... So... What happens to me now?"], "Mr. Greene");
					break;
				case 12:
					talk(["Well................"], "Daniel");
					break;
				case 13:
					talkPhase = false;
					break;
			}
			
		}
	}
}