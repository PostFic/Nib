/// Support for the set of relations defined by XSD.
public protocol Relatable {

	/// Identity, for the purposes of XSD.
	///
	/// This is not the same as Swift's `===`.
	/// Instances may be different and yet still identical.
	static func ≡(lhs: Self, rhs: Self) -> Bool

	/// Not-identity, for the purposes of XSD.
	///
	/// This is not the same as Swift's `!==`.
	static func ≢(lhs: Self, rhs: Self) -> Bool

	/// Equality, for the purposes of XSD.
	///
	/// This is not the same as Swift's `==`.
	/// Two different instances might have equal values (`≍`) but otherwise be inequal (`!=`).
	static func ≍(lhs: Self, rhs: Self) -> Bool

	/// Not-equality, for the purposes of XSD.
	///
	/// This is not the same as Swift's `!=`.
	static func ≭(lhs: Self, rhs: Self) -> Bool

	/// Less-than, for the purposes of XSD.
	///
	/// This is not the same as Swift's `<`.
	/// In particular, Swift's `<` typically implies ordering.
	static func ≺(lhs: Self, rhs: Self) -> Bool

	/// Not-less-than, for the purposes of XSD.
	///
	/// + Note: This does not imply greater-than-or-equals, as the literals may not be comparable.
	static func ⊀(lhs: Self, rhs: Self) -> Bool

	/// Greater-than, for the purposes of XSD.
	///
	/// This is not the same as Swift's `>`.
	/// In particular, Swift's `<` typically implies ordering.
	static func ≻(lhs: Self, rhs: Self) -> Bool


	/// Not-greater-than, for the purposes of XSD.
	///
	/// + Note: This does not imply less-than-or-equals, as the literals may not be comparable.
	static func ⊁(lhs: Self, rhs: Self) -> Bool


	/// Less-than-or-equals, for the purposes of XSD.
	///
	/// This is not the same as Swift's `<=`.
	static func ≼(lhs: Self, rhs: Self) -> Bool


	/// Not-less-than-or-equals, for the purposes of XSD.
	///
	/// + Note: This does not imply greater-than, as the literals may not be comparable.
	static func ⋠(lhs: Self, rhs: Self) -> Bool


	/// Greater-than-or-equals, for the purposes of XSD.
	///
	/// This is not the same as Swift's `>=`.
	static func ≽(lhs: Self, rhs: Self) -> Bool


	/// Not-greater-than-or-equals, for the purposes of XSD.
	///
	/// + Note: This does not imply less-than, as the literals may not be comparable.
	static func ⋡(lhs: Self, rhs: Self) -> Bool


	/// Incomperable, for the purposes of XSD.
	///
	/// + Note: Comparability of literals may vary within a type.
	static func ⟡(lhs: Self, rhs: Self) -> Bool


	/// Comparable, for the purposes of XSD.
	///
	/// This does not imply the `Comparable` protocol.
	///
	/// + Note: Comparability of literals may vary within a type.
	static func ⟡̸(lhs: Self, rhs: Self) -> Bool

}

/*
Provides the default implementations for the XSD relations.
*/
public extension Relatable {

	/// Inverses the result of the identity relation.
	static func ≢(lhs: Self, rhs: Self) -> Bool {
		return !(lhs ≡ rhs)
	}

	/// Inverses the result of the equality relation.
	static func ≭(lhs: Self, rhs: Self) -> Bool {
		return !(lhs ≍ rhs)
	}

	/// Inverses the result of the less-than relation.
	static func ⊀(lhs: Self, rhs: Self) -> Bool {
		return !(lhs ≺ rhs)
	}

	/// Inverses the result of the greater-than relation.
	static func ⊁(lhs: Self, rhs: Self) -> Bool {
		return !(lhs ≻ rhs)
	}

	/// Identifies whether exactly one of less-than and equality is true.
	static func ≼(lhs: Self, rhs: Self) -> Bool {
		return (lhs ≺ rhs || lhs ≍ rhs) && !(lhs ≺ rhs && lhs ≍ rhs)
	}

	/// Inverses the result of the less-than-or-equals relation.
	static func ⋠(lhs: Self, rhs: Self) -> Bool {
		return !(lhs ≼ rhs)
	}

	/// Identifies whether exactly one of greater-than and equality is true.
	static func ≽(lhs: Self, rhs: Self) -> Bool {
		return (lhs ≻ rhs || lhs ≍ rhs) && !(lhs ≻ rhs && lhs ≍ rhs)
	}

	/// Inverses the result of the greater-than-or-equals relation.
	static func ⋡(lhs: Self, rhs: Self) -> Bool {
		return !(lhs ≽ rhs)
	}

	/// Identifies whether exactly one of less-than, equality, and greater-than is true.
	static func ⟡̸(lhs: Self, rhs: Self) -> Bool {
		if !(lhs ≺ rhs) && !(lhs ≻ rhs) {
			return !(lhs ≍ rhs) // No relations are true
		} else if lhs ≺ rhs || lhs ≻ rhs {
			return lhs ≍ rhs // Both a strict ordering and equality are true
		} else {
			return lhs ≺ rhs && lhs ≻ rhs // Both strict orderings are true
		}
	}

	/// Inverses the result of the incomperable relation.
	static func ⟡(lhs: Self, rhs: Self) -> Bool {
		return !(lhs ⟡̸ rhs)
	}

}
