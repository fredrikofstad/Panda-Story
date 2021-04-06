package  {
	
	public class Data {
		
		import flash.net.SharedObject;

		public function Data() {
			// constructor code
		}
		
		public static function saveGame(){
			Main.i.saveGame();
			Progression.flag.saveGame();
		}
		public static function loadGame(){
			Main.i.loadGame();
			Progression.flag.loadGame();
		}

	}
	
}
