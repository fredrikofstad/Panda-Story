package Objects {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;


	public class Mirror extends MovieClip {

		var player;
		var _scale = 0.8

		public function Mirror() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		function init(e: Event): void {
			this.addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, kill, false, 0, true);
			panda.scaleY = _scale;
		}

		function loop(e: Event) {
			player = Main.panda;
			if (this.hitTestObject(player)) {
				var localPoint: Point = globalToLocal(new Point(player.x + 60, player.y - 50));
				panda.x = localPoint.x;
				panda.y = localPoint.y;
				if (player.state == "normal") {
					panda.gotoAndStop("normal");
				} else if (player.state == "attack") {
					panda.gotoAndStop("attack");
				} else if (player.state == "holding") {
					panda.gotoAndStop("holding");
					if (player.holding != null) {
						panda.holding.gotoAndStop(player.holding);
					}
				}
				if (player.scale == 1) {
					panda.scaleX = _scale;
				} else {
					panda.scaleX = -_scale;
				}

			}
		}
		function kill(e: Event) {
			this.removeEventListener(Event.ENTER_FRAME, loop);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, kill);
		}
	}

}