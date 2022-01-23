package {

    import flash.display.MovieClip;
    import flash.events.*;
    import flash.desktop.NativeApplication;


    public class UI extends MovieClip {

        private var itemOpen: Boolean = false;
        private var menuOpen: Boolean = false;
        private var coolDown: int = 0;
        private var itemSlot: Array;



        public function UI(startY: int) {
            //need mute button, consider seperate music and sfx
            wpbutton.addEventListener(MouseEvent.CLICK, doWm);
            itembutton.addEventListener(MouseEvent.CLICK, doItem);
            menubtn.addEventListener(MouseEvent.CLICK, doMenu);
            menubar.exitbtn.addEventListener(MouseEvent.CLICK, doexit);
            menubar.savebtn.addEventListener(MouseEvent.CLICK, doSave);
            itembox.visible = false;
            menubar.visible = false;
            menubar.musiconoff.mouseEnabled = false;
            this.y = startY;
            addEventListener(Event.ENTER_FRAME, loop);
            itemSlot = [itembox.item1, itembox.item2, itembox.item3, itembox.item4];
        }


        function loop(e: Event) {
            hearts.gotoAndStop(Main.panda.hp);
            life.text = String(Main.panda.life);
            coins_txt.text = String(Main.i.coinAmount);
            if (Input.i && coolDown == 0) {
                coolDown = 10;
                doItem2();
            }
            if (Input.m && coolDown == 0) {
                coolDown = 10;
                doWm2();
            }
            if (coolDown > 0) {
                coolDown--;
            }
        }

        function doItem(e: MouseEvent): void {
            doItem2();
        }

        function doItem2(): void {
            if (!itemOpen) {
                itemOpen = true;
                itembox.visible = true;
                for (var j: int = 0; j < itemSlot.length; j++) {
                    itemSlot[j].gotoAndStop(Main.i.item[j]);
                }
            } else {
                itemOpen = false;
                itembox.visible = false;
            }
        }
        function doMenu(e: MouseEvent): void {
            if (!menuOpen) {
                menuOpen = true;
                menubar.visible = true;
            } else {
                menuOpen = false;
                menubar.visible = false;
            }
        }
        public function transition(): void {
            trans.play();
        }
        function doWm(e: MouseEvent): void {
            doWm2();
        }
        function doWm2(): void {
            if (!Main.paused) {
                Main.screen.changeScreens("map");
            }
        }
        function doexit(e: MouseEvent): void {
            NativeApplication.nativeApplication.exit();
        }
        function doSave(e: MouseEvent): void {
            Mixer.play.FX("coin");
            Data.saveGame();
        }
    }

}