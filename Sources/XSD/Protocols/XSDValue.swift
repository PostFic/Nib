public protocol XSDValue: Hashable {

	associatedtype
		LexicalRepresentation: XSDLexicalRepresentation
	where LexicalRepresentation.Value == Self

	init(
		mapping literal: Self.LexicalRepresentation
	)

	init?(
		_ description: String
	)

	static func ≡<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool

	static func ≡(
		lhs: Self,
		rhs: Self
	) -> Bool

	static func ≢<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool

	static func ≢(
		lhs: Self,
		rhs: Self
	) -> Bool

	static func ≍<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool

	static func ≍(
		lhs: Self,
		rhs: Self
	) -> Bool

	static func ≭<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool

	static func ≭(
		lhs: Self,
		rhs: Self
	) -> Bool

	static func ≺<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool

	static func ≺(
		lhs: Self,
		rhs: Self
	) -> Bool

	static func ⊀<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool

	static func ⊀(
		lhs: Self,
		rhs: Self
	) -> Bool

	static func ≻<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool

	static func ≻(
		lhs: Self,
		rhs: Self
	) -> Bool

	static func ⊁<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool

	static func ⊁(
		lhs: Self,
		rhs: Self
	) -> Bool

	static func ≼<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool

	static func ≼(
		lhs: Self,
		rhs: Self
	) -> Bool

	static func ⋠<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool

	static func ⋠(
		lhs: Self,
		rhs: Self
	) -> Bool

	static func ≽<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool

	static func ≽(
		lhs: Self,
		rhs: Self
	) -> Bool

	static func ⋡<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool

	static func ⋡(
		lhs: Self,
		rhs: Self
	) -> Bool

	static func ⟡<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool

	static func ⟡(
		lhs: Self,
		rhs: Self
	) -> Bool

	static func ⟡̸<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool

	static func ⟡̸(
		lhs: Self,
		rhs: Self
	) -> Bool

}

public extension XSDValue {

	@inlinable
	init?(
		_ description: String
	) {
		guard let literal: Self.LexicalRepresentation = description◊?
		else { return nil }
		self.init(mapping: literal)
	}

	@inlinable
	static func ≡<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool { false }

	@inlinable
	static func ≢<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool { true }

	@inlinable
	static func ≢(
		lhs: Self,
		rhs: Self
	) -> Bool { !(lhs ≡ rhs) }

	@inlinable
	static func ≍<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool { false }

	@inlinable
	static func ≭<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool { true }

	@inlinable
	static func ≭(
		lhs: Self,
		rhs: Self
	) -> Bool { !(lhs ≍ rhs) }

	@inlinable
	static func ≺<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool { false }

	@inlinable
	static func ⊀<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool { true }

	@inlinable
	static func ⊀(
		lhs: Self,
		rhs: Self
	) -> Bool { !(lhs ≺ rhs) }

	@inlinable
	static func ≻<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool { false }

	@inlinable
	static func ⊁<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool { true }

	@inlinable
	static func ⊁(
		lhs: Self,
		rhs: Self
	) -> Bool { !(lhs ≻ rhs) }

	@inlinable
	static func ≼<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool { false }

	@inlinable
	static func ≼(
		lhs: Self,
		rhs: Self
	) -> Bool { lhs ≺ rhs || lhs ≍ rhs }

	@inlinable
	static func ⋠<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool { true }

	@inlinable
	static func ⋠(
		lhs: Self,
		rhs: Self
	) -> Bool { !(lhs ≼ rhs) }

	@inlinable
	static func ≽<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool { false }

	@inlinable
	static func ≽(
		lhs: Self,
		rhs: Self
	) -> Bool { lhs ≻ rhs || lhs ≍ rhs }

	@inlinable
	static func ⋡<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool { true }

	@inlinable
	static func ⋡(
		lhs: Self,
		rhs: Self
	) -> Bool { !(lhs ≽ rhs) }

	@inlinable
	static func ⟡<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool { true }

	@inlinable
	static func ⟡(
		lhs: Self,
		rhs: Self
	) -> Bool { !(lhs ≺ rhs || lhs ≻ rhs || lhs ≍ rhs) }

	@inlinable
	static func ⟡̸<N: XSDValue>(
		lhs: Self,
		rhs: N
	) -> Bool { false }

	@inlinable
	static func ⟡̸(
		lhs: Self,
		rhs: Self
	) -> Bool { !(lhs ⟡ rhs) }

}
