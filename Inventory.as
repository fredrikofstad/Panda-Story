package {

	import flash.display.Sprite;
	import flash.net.SharedObject;

	public class Inventory extends Sprite {

		private var coins: int = 0;
		private var coinsTaken: Array = [];
		private var enemies: Array = []
		public var item: Array = ["bamboo", "empty", "empty", "empty"];
		//save data
		private var so: SharedObject = SharedObject.getLocal("panda");

		public function Inventory() {

		}
		public function saveGame(): void {
			so.data.coins = coins;
			so.data.enemies = enemies;
			so.data.coinsTaken = coinsTaken;
			so.data.item = item;

		}
		public function loadGame(): void {
			coins = so.data.coins;
			enemies = so.data.enemies;
			coinsTaken = so.data.coinsTaken;
			item = so.data.item;
		}

		public function coinAdd(amount: int = 1): void {
			coins += amount;
		}
		public function removeKeyItem(_item: String): void {
			for (var i: int = 0; i < item.length; i++) {
				if (item[i] == _item) {
					item[i] = "empty";
				}
			}
		}
		public function keyItemAdd(_item: String): void {
			for (var i: int = 0; i < item.length; i++) {
				if (item[i] == _item) {
					break;
				} else if (item[i] == "empty") {
					item[i] = _item;
					break;
				}
			}
			Main.panda.gotItem(_item);
			switch (_item) {
				case "key":
					Main.u.talk.say(["You got the apartment key! Better not lose it."], "Key");
				case "ticket":
					Main.u.talk.say(["You finally found a train ticket! Next stop, the train station!"], "Ticket");
				case "gelato":
					Main.u.talk.say(["Looks delicious!"], "Icecream");
			}
		}
		public function pushCoins(_name: String): void {
			coinsTaken.push(_name);
		}
		public function pushEnemy(_name: String): void {
			enemies.push(_name);
		}

		//gets

		public function alreadyTaken(_name: String): Boolean {
			if (coinsTaken.indexOf(_name) > -1) {
				return true;
			} else {
				return false;
			}
		}
		public function enemyKilled(_name: String): Boolean {
			if (enemies.indexOf(_name) > -1) {
				return true;
			} else {
				return false;
			}
		}

		public function get coinAmount(): int {
			return coins;
		}
		public function takeCoin(amount: int): void {
			coins -= amount;
		}

		//key items
		public function hasItem(_item: String): Boolean {
			for (var i: int = 0; i < item.length; i++) {
				if (item[i] == _item) {
					return true;
					break;
				}
			}
			return false;
		}

	}

}