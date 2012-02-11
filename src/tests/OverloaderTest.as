package tests {
	import org.flexunit.asserts.assertEquals;

	public class OverloaderTest {
		private static const NUMBER:String = "NUMBER";
		private static const INT:String = "INT";
		private static const UINT:String = "UINT";
		private static const STRING:String = "STRING";
		private static const BOOLEAN:String = "BOOLEAN";

		private var _overloader:Overloader;

		[Before]
		public function setup():void {
			_overloader = new Overloader(this);
		}

		[After]
		public function teardown():void {
			_overloader = null;
		}

		[Test]
		public function testNumerics_defineOrder_NumberIntUint():void {
			_overloader.addHandler([Number], handleNumber);
			_overloader.addHandler([int], handleInt);
			_overloader.addHandler([uint], handleUint);
			assertEquals(_overloader.process([1.1]), NUMBER);
			assertEquals(_overloader.process([-2]), INT);
			assertEquals(_overloader.process([3]), UINT);
		}

		[Test]
		public function testNumerics_defineOrder_UintIntNumber():void {
			_overloader.addHandler([uint], handleUint);
			_overloader.addHandler([int], handleInt);
			_overloader.addHandler([Number], handleNumber);
			assertEquals(_overloader.process([1.1]), NUMBER);
			assertEquals(_overloader.process([-2]), INT);
			assertEquals(_overloader.process([3]), UINT);
		}

		[Test]
		public function testMatchStringNumber():void {
			_overloader.addHandler([String,Number], handleStringNumber);
			_overloader.addHandler([String], handleString);
			_overloader.addHandler([Number], handleNumber);
			assertEquals(_overloader.process(["Hello", 5]), STRING + NUMBER);
		}

		private function handleString(value:String):String {
			return STRING;
		}

		private function handleStringNumber(str:String, num:Number):String {
			return STRING + NUMBER;
		}

		private function handleUint(value:uint):String {
			return UINT;
		}

		private function handleInt(value:int):String {
			return INT;
		}

		private function handleNumber(value:Number):String {
			return NUMBER;
		}
	}
}
