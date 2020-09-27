import XSD

public extension XSD {

	@propertyWrapper
	struct LexicalMapping<L, V>
	where L: XSD.Literal {

		public let wrappedValue: (L) -> V

		internal let fromSubstring: (Substring) -> V

		internal init (
			_ function: @escaping (Substring) -> V
		) {
			fromSubstring = function
			wrappedValue = { function(Substring(String($0))) }
		}

	}

}
