package Cutscene {

	import flash.display.MovieClip;
	import flash.events.*;


	public class Frigg1 extends Cutscene {

		function talk(speech: Array, char: String, gender: Boolean = true): void {
			Main.u.talk.say(speech, char, gender);

		}


		override function action(): void {
			switch (order) {
				case 0:
					break;
				case 1:
					talk(["I'm sure you have many questions,","but they will have to wait.", "It's too public to discuss here,", "meet me in the bathroom at the bar next door.",
				"it's just outside this zoo. You can't miss it."], "Frigg",false);
					break;
				case 10:
					talk(["See ya there… Panda."], "Frigg",false);
					talking.visible = false;
					walking.play();
					break;
				case 11:
					talkPhase = false;
					break;
			}
		}
	}

}