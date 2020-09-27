import XSD

public extension XSD {

	@propertyWrapper
	struct LexicalSequenceMapping<L, V>
	where L: XSD.Literal {

		public let wrappedValue: (XSD.Sequence<L>) -> V

		internal let fromSubstring: (XSD.Sequence<Substring>) -> V

		internal init (
			_ function: @escaping (XSD.Sequence<Substring>) -> V
		) {
			fromSubstring = function
			wrappedValue = { S in
				function(
					sequence(
						state: S.makeIterator()
					) { state in
						var nextState = state as! XSD.Sequence<Substring>.Iterator
						guard let S_i = nextState.next()
						else
						{ return nil }
						state = nextState
						return Substring(String(S_i))
					}
				)
			}
		}

	}

}
