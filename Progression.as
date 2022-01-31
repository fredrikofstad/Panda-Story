package  {
	
	import flash.net.SharedObject;
	
	public class Progression {
		//set up
		private var so: SharedObject = SharedObject.getLocal("panda");
		// LEVEL 1
		public var Frigg:int = 0;
		// LEVEL 2
		public var ticket: int = 0;
		public var skateUnlocked: Boolean = false;
		public var toilclear: Boolean = false;
		// LEVEL 3
		public var trainDone: Boolean = false;
		public var asakoForgive: Boolean = false;
		// LEVEL 4 Winter
		public var sledScore:int = 0;
		
		
		
		private static var _flag: Progression = null;

		public function Progression() {
			_flag = this;
		}
		public function saveGame():void{
			so.data.Frigg = Frigg;
			so.data.ticket = ticket;
			so.data.skateUnlocked = skateUnlocked;
			so.data.toilclear = toilclear;
			so.data.trainDone = trainDone;
			so.data.asakoForgive = asakoForgive;
			so.data.sledScore = sledScore;
			so.data.currentStage = Main.level.getStage;
		}
		public function loadGame():void{
			Frigg = so.data.Frigg;
			ticket = so.data.ticket;
			skateUnlocked = so.data.skateUnlocked;
			toilclear = so.data.toilclear;
			trainDone = so.data.trainDone;
			asakoForgive = so.data.asakoForgive;
			ticket = so.data.ticket;
			sledScore = so.data.sledScore;
		}
		public static function get flag():Progression {
			return _flag
		}

	}
	
}
