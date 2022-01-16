package {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Bullet extends MovieClip {
		var speed: int = 14;
		var bullet_y: int = 10 + Math.floor(Math.random() * 6)
		var gravity: Number = 1;
		var maxGravity: int = 1
		var initialY: int;
		var levelSpeed: Number;

		public function Bullet(playerX: int, playerY: int, playerScale: int) {
			if (playerScale == 1) {
				speed = -10;
				x = playerX - 25;
			} else {
				speed = 10;
				x = playerX + 25
			}
			y = playerY - 50;
			addEventListener(Event.ENTER_FRAME, loop);
			initialY = y;
		}
		public function loop(e: Event): void {
			if (y > initialY + 150 || x > stage.stageWidth- width/2 || x < 0 + width/2) { 
				removeSelf();
			}
			gravity += 0.4;
			x += speed + Main.panda.levelSpeed;
			//y -= Main.player_y + bullet_y - gravity;
			y -= bullet_y - gravity;
			
		}
		public function removeSelf(): void {
			removeEventListener(Event.ENTER_FRAME, loop);
			this.parent.removeChild(this); 
			
		}
	}
}