package Objects {

	import flash.display.MovieClip;
	import flash.events.*;


	public class Elevator extends MovieClip {
		var elevatorRise: Boolean = false;
		var elevatorFall: Boolean = false;
		var inProgress: Boolean = false;
		var player;
		var _distance: int;
		var stageSpeed: int = 5;
		var playerSpeed: int = 3;
		var signal = false;


		public function Elevator() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		function init(e: Event): void {
			this.addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, kill, false, 0, true);
			player = Main.panda;
		}
		private function loop(e: Event): void {
			if (currentLabel == "go") {
				inProgress = true;
			} else if (currentLabel == "leave") {
				player.resume();
				player.visible = true;
			}
			if (inProgress) {
				if (elevatorRise) {
					player.y -= playerSpeed;
					Main.level.y += stageSpeed;
					if (Main.level.y > _distance) {
						inProgress = false;
						elevatorRise = false;
						signal = true;
					}
				} else if (elevatorFall) {
					player.y += playerSpeed;
					Main.level.y -= stageSpeed;
					if (Main.level.y < _distance) {
						inProgress = false;
						elevatorFall = false;
						signal = true;
					}
				}
			}
		}

		public function up(distance: int = 470) {
			if (!elevatorRise && hitTestObject(player.hitbox) && Main.key.space) {
				_distance = distance;
				elevatorRise = true;
				liftOff();
			}
		}

		public function down(distance: int = 0) {
			if (!elevatorFall && hitTestObject(player.hitbox) && Main.key.space) {
				_distance = distance;
				elevatorFall = true;
				liftOff();
			}
		}
		public function get getSignal():Boolean{
			if(signal){
				signal = false;
				return true;
			} else {
				return false;
			}
			
		}
		public function openDoor():void{
			gotoAndPlay("down");
		}
		private function liftOff(): void {
			player.visible = false;
			player.normal();
			player.halt();
			gotoAndPlay("up");
		}
		private function kill(e: Event) {
			this.removeEventListener(Event.ENTER_FRAME, loop);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, kill);
		}

	}
}