/*  Copyright 2012 Amazon.com, Inc. or its affiliates. All Rights Reserved. */
package tests {
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

	public class OverloadHandlerTest {
		public var one:int = 1;

		[Test]
		public function testExecute():void {
			const handler:OverloadHandler = new OverloadHandler([int], addOne);
			assertEquals(6, handler.execute(this, [5]));
		}

		private function addOne(value:int):int {
			return value + one;
		}

		[Test]
		public function testAnonymousFunctionScope():void {
			var alt:AltObject = new AltObject();
			var f:Function = function(value:int):*{return value + this.one};
			const handler:OverloadHandler = new OverloadHandler([int], f);
			assertEquals(6, handler.execute(this, [5]));
			assertEquals("5 one", handler.execute(alt, [5]));
			// TODO: show change without `this` and/or with private
		}

		[Test]
		public function testMethodClosureScope():void {
			var alt:AltObject = new AltObject();
			const handler:OverloadHandler = new OverloadHandler([int], addOne);
			assertEquals(6, handler.execute(this, [5]));
			assertEquals(6, handler.execute(alt, [5]));
		}

		[Test]
		public function testExternalMethodClosue():void {
			const alt:AltObject = new AltObject();
			const handler:OverloadHandler = new OverloadHandler([int], alt.addOne);
			assertEquals("5 one", handler.execute(this, [5]));
			assertEquals("5 one", handler.execute(alt, [5]));
		}

		public function testNumericIsMoreExplicit():void {
			const intHandler:OverloadHandler = new OverloadHandler([int], addOne);
			const uintHandler:OverloadHandler = new OverloadHandler([uint], addOne);
			const NumberHandler:OverloadHandler = new OverloadHandler([Number], addOne);
			assertTrue(intHandler.isMoreExplicit(NumberHandler));
			assertFalse(intHandler.isMoreExplicit(uintHandler));
			assertTrue(uintHandler.isMoreExplicit(intHandler));
			assertTrue(uintHandler.isMoreExplicit(NumberHandler));
			assertFalse(NumberHandler.isMoreExplicit(uintHandler));
			assertFalse(NumberHandler.isMoreExplicit(intHandler));
		}

		[Test]
		public function testMatches():void {
			const handler:OverloadHandler = new OverloadHandler([String, int, Boolean], addOne);
			assertTrue(handler.matches(["1", 13, false]));
			assertFalse(handler.matches(["1", 13, 0]));
			assertFalse(handler.matches([1, 13, false]));
			assertFalse(handler.matches(["1", 13.5, false]));
		}
	}
}

class AltObject {
	public var one:String = " one";

	public function addOne(value:int):String {
		return value.toString() + one;
	}
}
