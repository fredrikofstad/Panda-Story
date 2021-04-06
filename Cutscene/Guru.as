package Cutscene {

	import flash.display.MovieClip;
	import flash.events.*;


	public class Guru extends Cutscene {

		function talk(speech: Array, char: String, gender: Boolean = true): void {
			Main.u.talk.say(speech, char);

		}


		override function action(): void {
			switch (order) {
				case 0:
					break;
				case 1:
					talk(["Panda..."], "???");
					break;
				case 2:
					talk(["Panda... A great force is approaching...","You must prepare yourself","You have a great journey ahead of you, Panda",
					"But you will not be without allies."], "???");
					break;
				case 3:
					talk(["There are many things I need to tell you...","But I fear I lack the time","The most important thing you need to know is..."], "???");
					break;
				case 4:
					die.play();
					break;
				case 10:
					talkPhase = false;
					break;
			}
		}
	}

}