package {

	public class Overloader {

		private var _scope:Object;
		private var _handlers:Vector.<OverloadHandler>;

		public function Overloader(scope:Object = null) {
			_scope = scope;
			_handlers = new Vector.<OverloadHandler>();
		}

		public function addHandler(types:Vector.<Class>, method:Function):void {
			_handlers.push(new OverloadHandler(types, method));
		}

		public function process(args:Array):* {
			const matching:Vector.<OverloadHandler> = findMatchingHandlers(args);
			const best:OverloadHandler = findBestHandler(matching);
			if (best == null) {
				// have a default that can be called
				throw new Error("No overload match for this function!");
			}
			best.method.apply(_scope, args);
		}

		private function findBestHandler(matching:Vector.<OverloadHandler>):OverloadHandler {
			var best:OverloadHandler;
			for each (var match:OverloadHandler in matching) {
				if (match.isMoreExplicit(best)) {
					best = match;
				}
			}
			return best;
		}

		private function findMatchingHandlers(args:Array):Vector.<OverloadHandler> {
			const matches:Vector.<OverloadHandler> = new Vector.<OverloadHandler>();
			for each (var handler:OverloadHandler in _handlers) {
				if (handler.matches(args)) {
					matches.push(handler);
				}
			}
			return matches;
		}
	}
}
