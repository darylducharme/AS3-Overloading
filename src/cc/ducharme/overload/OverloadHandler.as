package cc.ducharme.overload {
	import avmplus.getQualifiedClassName;

	import flash.utils.describeType;

	public class OverloadHandler {
		private static const ORDERED_NUMBER_CLASSES:Vector.<Class> = new <Class>[Number, int, uint];

		private var _method:Function;
		private var _types:Vector.<Class>;
		private var _isStrict:Boolean = true;

		public function OverloadHandler(types:Array, method:Function) {
			_types = Vector.<Class>(types);
			_method = method;
		}

		public function matches(args:Array):Boolean {
			if (args.length == _types.length) {
				for (var index:uint = 0; index < args.length; index++) {
					if (!(args[index] is _types[index])) {
						return false;
					} else if (_isStrict && args[index] !== _types[index](args[index])) {
						return false;
					}
				}
				return true;
			}
			return false;
		}

		public function execute(target:Object, args:Array):* {
			return _method.apply(target, args);
		}

		public function isMoreExplicit(handler:OverloadHandler):Boolean {
			var localType:Class, compareType:Class;
			if (handler != null) {
				var compareTypes:Vector.<Class> = handler.argumentTypes;
				if (compareTypes.length != _types.length) {
					return true;
				}
				var points:int = 0;
				for (var index:uint = 0; index < _types.length; index++) {
					localType = _types[index];
					compareType = compareTypes[index];
					if (localType == null) {
						points--;
					} else if (compareType == null) {
						points++;
					} else if (isMoreExplicitNumberClass(localType, compareType)) {
						points++;
					} else if (classExtendsClass(localType, compareType)) {
						points++;
					} else {
						points--;
					}
				}
				if (points == 0) {
					throw Error("2 handlers with the same explicitness");
				}
				return 0 < points;
			}
			return true;
		}

		private function isMoreExplicitNumberClass(localType:Class, compareType:Class):Boolean {
			const localTypePosition:int = ORDERED_NUMBER_CLASSES.indexOf(localType);
			const compareTypePosition:int = ORDERED_NUMBER_CLASSES.indexOf(compareType);
			if (!(localTypePosition == -1 || compareTypePosition == -1)) {
				return compareTypePosition < localTypePosition;
			}
			return false;
		}

		private function classExtendsClass(localType:Class, compareType:Class):Boolean {
			if (localType == compareType) {
				return true;
			}
			var typeXML:XML = describeType(localType);
			var compareName:String = getQualifiedClassName(new compareType());
			return typeXML.factory.extendsClass.(@type==compareName).length() > 0;
		}

		protected function get argumentTypes():Vector.<Class> {
			return _types.concat();
		}

		public function get method():Function {
			return _method;
		}
	}
}
