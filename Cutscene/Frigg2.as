package Cutscene {

	import flash.display.MovieClip;
	import flash.events.*;


	public class Frigg2 extends Cutscene {

		function talk(speech: Array, char: String, gender: Boolean = true): void {
			Main.u.talk.say(speech, char, gender);

		}


		override function action(): void {
			switch (order) {
				case 0:
					break;
				case 1:
					talk(["Good, you made it.", "I'm afraid it's still too soon for answers.",
				"What I can say though, is that a great power is approaching.","...And you seem to be involved.",
				"I have a humble request... Head to Mount Luna.","The fate of the world might depend on it.","You should be able to take the train there.",
				"There's a shortcut this way. If you're able to jump high enough hehe..."], "Frigg",false);
					break;
				case 10:
					talk(["See ya around… Panda."], "Frigg",false);
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