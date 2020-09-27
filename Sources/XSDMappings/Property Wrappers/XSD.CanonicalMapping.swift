import XSD

public extension XSD {

	@propertyWrapper
	struct CanonicalMapping<V, L>
	where L: XSD.Literal {

		public let wrappedValue: (V) -> L

		internal let toString: (V) -> String

		internal init (
			_ function: @escaping (V) -> String
		) {
			toString = function
			wrappedValue = { L(function($0))! }
		}

	}

}
