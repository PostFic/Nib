/// Support for the identity operator (`≡`).
///
/// The identity operator suggests that two instances are utterly indistinguishable.
/// This means that all relevant properties have identical values.
///
/// + Note: Neither Swift identity (`===`) nor Swift equality (`==`) implies identity as defined here, nor vice-versa.
public protocol Identifiable {

	/// Identity, for the purposes of XSD.
	///
	/// This is not the same as Swift's `===`.
	/// Instances may be different and yet still identical.
	static func ≡(lhs: Self, rhs: Self) -> Bool

	/// Not-identity, for the purposes of XSD.
	///
	/// This is not the same as Swift's `!==`.
	static func ≢(lhs: Self, rhs: Self) -> Bool

}

public extension Identifiable {

	/// Inverses the result of the identity relation.
	static func ≢(lhs: Self, rhs: Self) -> Bool {
		return !(lhs ≡ rhs)
	}

}
