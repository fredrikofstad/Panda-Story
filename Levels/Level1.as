package Levels {
	
	import NPC.NPC;

	public class Level1 extends LevelClass {
		//flags


		public function Level1(first:Boolean = false) {
			guruCS.gotoAndStop(1);
			if(first){
				Main.panda.visible = false;
				Main.panda.halt();
				introcut.play();
			}
		}
		override function loopCode(): void {
			//first time
			if(introcut.currentLabel == "done"){
				guruCS.gotoAndStop(2);
				Main.panda.resume();
			}
			if(guruCS.currentFrame == 3){
				Mixer.play.FX("die");
				Main.u.transition();
				Main.panda.visible = true;
				Main.bg.change("morning");
				Mixer.play.BG(1);
				guruCS.gotoAndStop(4);
				introcut.gotoAndStop("gone");
			}
			//door
			door.enter(2);

			//cage
			if (cage.hitTestObject(player.hitbox)) {
				fadeOut(cage);
			} else {
				fadeIn(cage);
			}
			//Frigg
			if (player.hitTestObject(frigg) && Progression.flag.Frigg == 0) {
					frigg.gotoAndStop(2);
					player.halt();
					Progression.flag.Frigg = 1;
					Main.u.transition();
			}
			if(Progression.flag.Frigg > 1){
				frigg.visible = false;
			}
			if(frigg.currentFrame == 3){
				Progression.flag.Frigg = 2;
				player.resume();
			}


		}
	}

}