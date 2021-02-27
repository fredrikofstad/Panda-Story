package{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.*;
	import flash.geom.Point;

	public class Tesla extends MovieClip {

		var player: MovieClip;
		var mainTimeLine = MovieClip(root);
		var speed: int = 7;
		var dogG: Point;
		var enemy: Boolean = false;

		public function Tesla() {
			this.addEventListener(Event.ENTER_FRAME, loop);
			this.gotoAndStop("walk");
		}

		function loop(e: Event): void {
			mainTimeLine = MovieClip(root);
			player = mainTimeLine.player;

			dogG = this.localToGlobal(new Point(0));
			
			if(!mainTimeLine.collisions.monkey1.died && mainTimeLine.collisions.monkey1.x < this.x + 400){
				enemy = true;
				speed = 12;
			} else{
				if(mainTimeLine.collisions.monkey1.x > this.x + 1000){
				enemy = false;
				speed = 7;
				}
			}

			if (enemy) {
				moveRight();
			} else {

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

		}

		function moveRight(): void {
			this.x -= speed;
			this.gotoAndStop("walk");
			this.scaleX = 1;
		}
		function moveLeft(): void {
			this.x += speed;
			this.gotoAndStop("walk");
			this.scaleX = -1;
		}

	}
}