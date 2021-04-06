package {

	import flash.display.MovieClip;

	public class Background extends MovieClip {

		public function Background() {
			this.gotoAndStop("morning");
		}
		public function change(scene:String):void {
			gotoAndStop(scene);
		}
	}

}