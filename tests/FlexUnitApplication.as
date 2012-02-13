package {
	import Array;

	import cc.ducharme.overload.OverloadHandlerTest;
	import cc.ducharme.overload.OverloaderTest;

	import flash.display.Sprite;

	import flexunit.flexui.FlexUnitTestRunnerUIAS;

	public class FlexUnitApplication extends Sprite {
		public function FlexUnitApplication() {
			onCreationComplete();
		}

		private function onCreationComplete():void {
			var testRunner:FlexUnitTestRunnerUIAS=new FlexUnitTestRunnerUIAS();
			this.addChild(testRunner);
			testRunner.runWithFlexUnit4Runner(currentRunTestSuite(), "Overload");
		}

		public function currentRunTestSuite():Array {
			var testsToRun:Array = new Array();
			testsToRun.push(cc.ducharme.overload.OverloaderTest);
			testsToRun.push(cc.ducharme.overload.OverloadHandlerTest);
			return testsToRun;
		}
	}
}
