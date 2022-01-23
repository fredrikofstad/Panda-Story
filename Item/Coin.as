package Item {

	public class Coin extends Item {

		var coinValue: int = 1;

		override function playerHit(): void {
			Main.i.coinAdd();

		}
	}
}
