package {
	import flash.display.Sprite;
	import cc.ducharme.overload.Overloader;

	public class Main extends Sprite {
		public function Main() {
			super();
			aFunction("Hello", 5);
			aFunction(uint(13));
			aFunction(5.1);
			aFunction(int(6))
			aFunction(7.0);
			aFunction(-1);
			aFunction(false);
			aFunction("Goodbye");
		}

		// run a test with differing namespaces?
		private function aFunction(... args):* {
			const overloader:Overloader = new Overloader();
			overloader.addHandler([String, Number], onStringNumber);
			overloader.addHandler([String], onString);
			overloader.addHandler([Number], onNumber);
			overloader.addHandler([int], onInt);
			overloader.addHandler([uint], onUint);
			overloader.addHandler([Boolean], onBoolean);
			return overloader.process(args);
		}

		private function onInt(value:int):void {
			trace("We got int: " + value);
		}

		private function onUint(value:uint):void {
			trace("We got uint: " + value);
		}

		private function onBoolean(value:Boolean):void {
			trace("We got Boolean: " + value);
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
