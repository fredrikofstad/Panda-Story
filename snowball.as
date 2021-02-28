package {
	import flash.display.MovieClip;
	import flash.events.*;

	public class Snowball extends MovieClip {
		var player: MovieClip;
		var mainTimeLine = MovieClip(root);
		var speed: Number = 1;
		var originalX: Number;
		var grow, snowMax, madehead: Boolean = false;
		var head: snowhead = new snowhead();
		var finished: finishedsnow = new finishedsnow();



		public function Snowball() {
			this.addEventListener(Event.ENTER_FRAME, upDate);
			originalX = this.x;


		}

		function snowgrow(): void {
			if (grow && !snowMax) {
				//this.rotation += 1;
				this.scaleX += 0.005;
				this.scaleY += 0.005;
			}
		}

		function growleft(): void {
			if (this.x < originalX - 15) {
				grow = true;
				originalX = this.x;
				if (!snowMax) {
					this.rotation -= 4;
				}
			} else {
				grow = false;
			}
		}
		function growright(): void {
			if (this.x > originalX + 15) {
				grow = true;
				originalX = this.x;
				if (!snowMax) {
					this.rotation += 4;
					this.y -= 0.25
				}
			} else {
				grow = false;
			}
		}

		public function makesnowman(): void {
			if (snowMax) {
				if (!madehead) {
					MovieClip(root).collisions.addChild(head);
					head.x = this.x;
					head.y = this.y - 80;
					madehead = true;
				} else {
					if (head.scaleX < 2.8) {
						head.scaleX += 0.2
						head.scaleY += 0.2
						head.y -= 2
					} else {
						magicsnow();

					}
				}
			}
		}
		public function magicsnow(): void {
			mainTimeLine = MovieClip(root)
			mainTimeLine.snowmanComplete = true;
			this.parent.addChild(finished);
			finished.x = this.x;
			finished.y = this.y - 15;
			mainTimeLine.collisions.removeChild(head);
		}

		function upDate(e: Event): void {

			snowgrow();

			mainTimeLine = MovieClip(root);
			player = mainTimeLine.player;

			if (this.scaleX > 1.5) {
				snowMax = true;
				mainTimeLine.pushing = false;
				mainTimeLine.rightSnowball = false;
				mainTimeLine.leftSnowball = false;
				mainTimeLine.overSnowball = false;
			}
			if (!mainTimeLine.snowmanComplete) {


				if (this.hitTestPoint(player.x - 25, player.y - 33)) {
					if (!snowMax && this.x > -12000) {
						mainTimeLine.pushing = true;
						this.x -= mainTimeLine.player_xLeft;
						growleft();
					} else {
						mainTimeLine.leftSnowball = true;
					}
				} else if (this.hitTestPoint(player.x + 25, player.y - 33)) {
					if (!snowMax && this.x < -8300) {
						mainTimeLine.pushing = true;
						this.x += mainTimeLine.player_xRight;
						growright();
					} else {
						mainTimeLine.rightSnowball = true;
					}
				} else {
					mainTimeLine.pushing = false;
					mainTimeLine.rightSnowball = false;
					mainTimeLine.leftSnowball = false;



				}
				if (this.hitTestPoint(player.x, player.y)) {
					mainTimeLine.overSnowball = true;
				} else {
					mainTimeLine.overSnowball = false;
				}
			}

		}

	}

}