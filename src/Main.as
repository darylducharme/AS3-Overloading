package {
	import flash.display.Sprite;

	public class Main extends Sprite {
		public function Main() {
			super();
			aFunction("Hello", 5);
			aFunction(13);
			aFunction("Goodbye");
		}

		// run a test with differing namespaces?
		private function aFunction(... args):void {
			const overloader:Overloader = new Overloader();
			overloader.addHandler(new <Class>[String, Number], onStringNumber);
			overloader.addHandler(new <Class>[String], onString);
			overloader.addHandler(new <Class>[Number], onNumber);
			overloader.process(args);
		}

		private function onNumber(num:Number):void {
			trace("We got number: " + num);
		}

		private function onString(str:String):void {
			trace("We got string: " + str);
		}

		private function onStringNumber(str:String, num:Number):void {
			trace("We got string, number: " + str + ", " + num);
		}
	}
}
