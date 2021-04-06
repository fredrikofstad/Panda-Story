package Item {

	public class Coin extends Item {

		var coinValue: int = 1;

		public function Coin() {}
		override function playerHit(): void {
			Main.i.coinAdd();

		}
	}
}
