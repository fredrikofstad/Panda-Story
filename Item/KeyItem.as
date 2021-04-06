package Item {
	
	public class KeyItem extends Item{

		override function playerHit():void{
			Main.i.keyItemAdd(name);
		}

	}
	
}
