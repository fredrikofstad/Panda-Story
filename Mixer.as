package {

	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.*;
	import flash.events.Event;
	import flash.display.PixelSnapping;

	public class Mixer {
		//BG music
		var intro: Sound = new Intro();
		var zoo: Sound = new Zoo();
		var pixels: Sound = new Pixels();
		var train1: Sound = new Train1();
		var train2: Sound = new Train2();
		var train3: Sound = new Train3();
		var winter: Sound = new Winter();
		//blank
		var nosound: Sound = new blank();
		//jingles
		var himym: Sound = new himymSong();
		//sound effects
		var coin: Sound = new CoinSound();
		var die: Sound = new EnemyDie();
		var hurt: Sound = new Hurt();
		var enemy: Sound = new EnemyDie();
		var male: Sound = new talkingsound();
		var female: Sound = new talkingsound2();
		var horn: Sound = new HornSound();
		//static instance reference
		private static var _play: Mixer = null;
		//channels
		var fx: SoundChannel = new SoundChannel();
		var bg: SoundChannel = new SoundChannel();
		var soundPosition: int;
		var songList:Array = [intro,zoo,pixels, train1, train2, train3, winter];
		var currentSong:int = 0;
		var muted:Boolean = false;

		public function Mixer() {
			_play = this;
			nosound.play(0, 999);
		}
		public function pause(): void {
			soundPosition = bg.position;
			bg.stop();
		}
		public function resume(): void {
			if (!muted) {
				bg = songList[currentSong].play(soundPosition);
				bg.addEventListener(Event.SOUND_COMPLETE, onComplete);
			}
		}
		public function unMute():void {
			muted = false;
			resume();
		}
		public function mute():void {
			muted = true;
			bg.removeEventListener(Event.SOUND_COMPLETE, onComplete);
		}
		function onComplete(event: Event): void {
			soundPosition = 0;
			resume();
		}
		public static function get play(): Mixer {
			return _play;
		}
		public function BG(current:int): void {
			bg.stop();
			currentSong = current;
			soundPosition = 0;
			resume();
		}
		public function train(change:int): void {
			soundPosition = bg.position;
			bg.stop();
			if(change == 1){
				currentSong = 3;
			} else if (change == 2) {
				currentSong = 4;
			} else {
				currentSong = 5;
			}
			resume();
		}
		public function FX(sound: String): void {
			switch (sound) {
				case "coin":
					coin.play();
					break;
				case "die":
					die.play();
					break;
				case "hurt":
					hurt.play();
					break;
				case "enemy":
					enemy.play();
					break;
				case "male":
					male.play();
					break;
				case "female":
					female.play();
					break;
				case "horn":
					horn.play(1000);
			}
		}
		public function jingle(sound: String): void {
			bg.stop();
			switch (sound) {
				case "himym":
					bg = himym.play();
					break;
			}
			bg.addEventListener(Event.SOUND_COMPLETE, onComplete);
		}

	}

}