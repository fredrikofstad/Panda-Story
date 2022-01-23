package  {
	
	public class Data {

		public function Data() {
			// constructor code
		}
		
		public static function saveGame(): void{
			Main.i.saveGame();
			Progression.flag.saveGame();
		}
		public static function loadGame(): void{
			Main.i.loadGame();
			Progression.flag.loadGame();
		}

	}
	
}
