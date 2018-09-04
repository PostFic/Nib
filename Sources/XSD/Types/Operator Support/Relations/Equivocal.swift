/// Support for the equivalance operator (`≍`).
///
/// The equivalence operator suggests that the *values* of two instances are equivalent.
/// The instances may have other properties (not related to their values) which are not compared.
///
/// The XSD specification uses the term "equality" to refer to equivalence.
///
/// + Note: Swift equality (`==`) does not imply equivalence, nor vice-versa.
public protocol Equivocal {

	/// Equality, for the purposes of XSD.
	///
	/// This is not the same as Swift's `==`.
	static func ≍(lhs: Self, rhs: Self) -> Bool

	/// Not-equality, for the purposes of XSD.
	///
	/// This is not the same as Swift's `!=`.
	static func ≭(lhs: Self, rhs: Self) -> Bool

}

public extension Equivocal {

	/// Inverses the result of the equality relation.
	static func ≭(lhs: Self, rhs: Self) -> Bool {
		return !(lhs ≍ rhs)
	}

}
