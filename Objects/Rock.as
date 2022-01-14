package Objects {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Rock extends MovieClip {
		var content: Number = 1 + Math.floor(Math.random() * 8);
		var object: String;
		var sled: Boolean = true;
		var rand: int = 1 + Math.floor(Math.random() * 4);
		var direction: int = 1 + Math.floor(Math.random() * 3);
		public var unit: int = rand;


		public function Rock(sled = true) {
			if (sled) {
				x = 1400;
				y = 650;
				addEventListener(Event.ENTER_FRAME, loop);
				if (content == 3) {
					this.gotoAndStop("penguin");
				} else {
					this.gotoAndStop("rock");
				}
			} else {
				addEventListener(Event.ENTER_FRAME, skiLoop);

				if(content > 6){
					gotoAndStop("skipenguin");
				} else if(content >= 4 && content <=6){
					gotoAndStop("ski1");
				} else if(content <= 3){
					gotoAndStop("ski2");
				}


				if (unit == 1) {
					x = 1400;
					y = 350;
				} else if (unit == 2) {
					x = -100;
					y = 425;
				} else if (unit == 3) {
					x = 1400;
					y = 500;
				} else if (unit == 4) {
					x = -100;
					y = 575;
					
				}
			}


		}
		public function loop(e: Event): void {
			if (x < -50) {
				removeSelf();
			}
			x -= 16;
			y -= 6;
		}
		public function skiLoop(e: Event): void {
			if (x < -110 || x > 1500) {
				removeSelf2();
			}
			if (unit == 1 || unit == 3) {
				scaleX = -1;
				x -= 16 + Math.floor(Math.random() * 2);
			} else {
				x += 10 + Math.floor(Math.random() * 2);
			}

		}
		public function removeSelf(): void {
				removeEventListener(Event.ENTER_FRAME, loop);
				this.parent.removeChild(this); 
		}
		
		public function removeSelf2(): void {
			removeEventListener(Event.ENTER_FRAME, skiLoop);
			this.parent.removeChild(this)
		}

	}
}