package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.*;

	public class Wheelchair extends MovieClip {
		var player: MovieClip;
		var mainTimeLine = MovieClip(root);
		var speed: Number = 1;

		var state: Number = 0;
		//1 before toilet
		//2 at toilet
		//3 after toilet
		var head: Boolean = false;



		public function Wheelchair() {
			// constructor code
			this.addEventListener(Event.ENTER_FRAME, upDate);
		}


		function upDate(e: Event): void {
			mainTimeLine = MovieClip(root);
			player = mainTimeLine.player;

			if (mainTimeLine.currentStage == 1) {

				if (this.hitbox.hitTestPoint(player.x - 25, player.y - 33)) {
					if (this.x > 6500) {
						mainTimeLine.wpushing = true;
						this.x -= mainTimeLine.player_xLeft;
						this.wheel.rotation -= 4;
					} else {
						mainTimeLine.leftWheel = true;
					}
				} else if (this.hitbox.hitTestPoint(player.x + 25, player.y - 33)) {
					if (this.x < 7300) {
						mainTimeLine.wpushing = true;
						this.x += mainTimeLine.player_xRight;
						this.wheel.rotation += 4;
					} else {
						mainTimeLine.rightWheel = true;
					}
				} else {
					mainTimeLine.wpushing = false;
					mainTimeLine.rightWheel = false;
					mainTimeLine.leftWheel = false;
				}
				if (this.hitbox.hitTestPoint(player.x, player.y)) {
					mainTimeLine.overWheel = true;
					head = true;
				} else {
					mainTimeLine.overWheel = false;
				}
				
				if (this.x < 6915) {
					state = 0;
				} else if (this.x >= 6915 && this.x < 7015) {
					state = 1;
				} else {
					state = 2;
				}
				
				
			}
		}
	}
}