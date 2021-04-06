package NPC {

	import flash.events.*;
	import flash.geom.Point;

	public class Tesla extends NPC {
		var dogG: Point;
		var enemy: Boolean = false;
		var Dspeed: int = 7;
		public function Tesla() {
			_name = "Tesla";
			_gender = false;

		}

		override function loopCode(): void {
			
			talk(["Woof, woof!"]);
			
			player = Main.panda;
			dogG = this.localToGlobal(new Point(0));
			if (player.x > dogG.x + 130 && player.x < dogG.x + 600) {
				moveLeft();
			} else if (player.x < dogG.x - 130 && player.x > dogG.x - 600) {
				moveRight();
			} else {
				if (this.currentLabel == "walk") {
					if (this.walking.currentLabel == "change") {
						this.gotoAndStop("stand");
					}
				}
			}
		}


		function moveRight(): void {
			this.x -= Dspeed;
			this.gotoAndStop("walk");
			this.scaleX = 1;
		}
		function moveLeft(): void {
			this.x += Dspeed;
			this.gotoAndStop("walk");
			this.scaleX = -1;
		}
	}

}