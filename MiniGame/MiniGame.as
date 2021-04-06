package MiniGame {

	import flash.display.MovieClip;
	
	public class MiniGame extends MovieClip {
		
		var level:MovieClip = (parent as MovieClip);
		
		function quit(): void {
			level.inGame = false;
			Main.unpauseGame();
			this.parent.removeChild(this);
		}

	}
	
}
