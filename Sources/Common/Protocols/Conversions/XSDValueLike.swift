/// A type which behaves similarly to `XSDValue` in many circumstances.
///
/// `XSDValueLike`s can be related to other `XSDValueLike`s of the same type, or to `XSDValue`s without need for conversion.
/// However, they *cannot* be related to `XSDValueLike`s from *different* types.
///
/// To implement this protocol, you need to at least specify the `value` property and the `hash(into:)` method (from `Hashable`).
public protocol XSDValueLike: BasicTypesConvertible, Hashable, Relatable {

	/// Gets the `XSDValue` equivalent for this instance, if possible.
	var value: XSDValue? { get }

	/// XSD left-hand identity with `XSDValue`.
	static func ≡(lhs: Self, rhs: XSDValue) -> Bool

	/// XSD right-hand identity with `XSDValue`.
	static func ≡(lhs: XSDValue, rhs: Self) -> Bool

	/// XSD left-hand not-identity with `XSDValue`.
	static func ≢(lhs: Self, rhs: XSDValue) -> Bool

	/// XSD right-hand not-identity with `XSDValue`.
	static func ≢(lhs: XSDValue, rhs: Self) -> Bool

	/// XSD left-hand equality with `XSDValue`.
	static func ≍(lhs: Self, rhs: XSDValue) -> Bool

	/// XSD right-hand equality with `XSDValue`.
	static func ≍(lhs: XSDValue, rhs: Self) -> Bool

	/// XSD left-hand not-equality with `XSDValue`.
	static func ≭(lhs: Self, rhs: XSDValue) -> Bool

	/// XSD right-hand not-equality with `XSDValue`.
	static func ≭(lhs: XSDValue, rhs: Self) -> Bool

	/// XSD left-hand less-than with `XSDValue`.
	static func ≺(lhs: Self, rhs: XSDValue) -> Bool

	/// XSD right-hand less-than with `XSDValue`.
	static func ≺(lhs: XSDValue, rhs: Self) -> Bool

	/// XSD left-hand not-less-than with `XSDValue`.
	static func ⊀(lhs: Self, rhs: XSDValue) -> Bool

	/// XSD right-hand not-less-than with `XSDValue`.
	static func ⊀(lhs: XSDValue, rhs: Self) -> Bool

	/// XSD left-hand greater-than with `XSDValue`.
	static func ≻(lhs: Self, rhs: XSDValue) -> Bool

	/// XSD right-hand greater-than with `XSDValue`.
	static func ≻(lhs: XSDValue, rhs: Self) -> Bool

	/// XSD left-hand not-greater-than with `XSDValue`.
	static func ⊁(lhs: Self, rhs: XSDValue) -> Bool

	/// XSD right-hand not-greater-than with `XSDValue`.
	static func ⊁(lhs: XSDValue, rhs: Self) -> Bool

	/// XSD left-hand less-than-or-equals with `XSDValue`.
	static func ≼(lhs: Self, rhs: XSDValue) -> Bool

	/// XSD right-hand less-than-or-equals with `XSDValue`.
	static func ≼(lhs: XSDValue, rhs: Self) -> Bool

	/// XSD left-hand not-less-than-or-equals with `XSDValue`.
	static func ⋠(lhs: Self, rhs: XSDValue) -> Bool

	/// XSD right-hand not-less-than-or-equals with `XSDValue`.
	static func ⋠(lhs: XSDValue, rhs: Self) -> Bool

	/// XSD left-hand greater-than-or-equals with `XSDValue`.
	static func ≽(lhs: Self, rhs: XSDValue) -> Bool

	/// XSD right-hand greater-than-or-equals with `XSDValue`.
	static func ≽(lhs: XSDValue, rhs: Self) -> Bool

	/// XSD left-hand not-greater-than-or-equals with `XSDValue`.
	static func ⋡(lhs: Self, rhs: XSDValue) -> Bool

	/// XSD right-hand not-greater-than-or-equals with `XSDValue`.
	static func ⋡(lhs: XSDValue, rhs: Self) -> Bool

	/// XSD left-hand incomparable with `XSDValue`.
	static func ⟡(lhs: Self, rhs: XSDValue) -> Bool

	/// XSD right-hand incomparable with `XSDValue`.
	static func ⟡(lhs: XSDValue, rhs: Self) -> Bool

	/// XSD left-hand comparable with `XSDValue`.
	static func ⟡̸(lhs: Self, rhs: XSDValue) -> Bool

	/// XSD right-hand comparable with `XSDValue`.
	static func ⟡̸(lhs: XSDValue, rhs: Self) -> Bool

}

/*
Provides the default implementations for the XSD relations.
*/
public extension XSDValueLike {

	/// The Swift less-than comparison.
	///
	/// This is defined so that implementations which are `Comparable` can simply declare the protocol without having to do any extra work.
	/// However, it does not on its own imply a strict ordering.
	static func <(lhs: Self, rhs: Self) -> Bool {
		return lhs ≺ rhs
	}

	/// The Swift equality comparison.
	///
	/// For `XSDValueLike`s, this is the same as the XSD equality relation.
	static func ==(lhs: Self, rhs: Self) -> Bool {
		return lhs ≍ rhs
	}

	/// The Swift greater-than comparison.
	///
	/// This is defined so that implementations which are `Comparable` can simply declare the protocol without having to do any extra work.
	/// However, it does not on its own imply a strict ordering.
	static func >(lhs: Self, rhs: Self) -> Bool {
		return lhs ≻ rhs
	}

	/// The default XSD identity with dual-hand `Self`.
	///
	/// Casts both sides to `XSDValue`s before comparing.
	/// Returns `false` if the cast fails.
	static func ≡(lhs: Self, rhs: Self) -> Bool {
		guard
			let lhv = lhs.value,
			let rhv = rhs.value
		else {
			return false
		}
		return lhv ≡ rhv
	}

	/// The default XSD identity with left-hand `Self`.
	///
	/// Casts the `XSDValueLike` to an `XSDValue` before comparing.
	/// Returns `false` if the cast fails.
	static func ≡(lhs: Self, rhs: XSDValue) -> Bool {
		guard let lhv = lhs.value else {
			return false
		}
		return lhv ≡ rhs
	}

	/// The default XSD identity with right-hand `Self`.
	///
	/// Casts the `XSDValueLike` to an `XSDValue` before comparing.
	/// Returns `false` if the cast fails.
	static func ≡(lhs: XSDValue, rhs: Self) -> Bool {
		guard let rhv = rhs.value else {
			return false
		}
		return lhs ≡ rhv
	}

	/// Inverses the result of the left-hand identity relation.
	static func ≢(lhs: Self, rhs: XSDValue) -> Bool {
		return !(lhs ≡ rhs)
	}

	/// Inverses the result of the right-hand identity relation.
	static func ≢(lhs: XSDValue, rhs: Self) -> Bool {
		return !(lhs ≡ rhs)
	}

	/// The default XSD equality with dual-hand `Self`.
	///
	/// Casts both sides to `XSDValue`s before comparing.
	/// Returns `false` if the cast fails.
	static func ≍(lhs: Self, rhs: Self) -> Bool {
		guard
			let lhv = lhs.value,
			let rhv = rhs.value
		else {
			return false
		}
		return lhv ≍ rhv
	}

	/// The default XSD equality with left-hand `Self`.
	///
	/// Casts the `XSDValueLike` to an `XSDValue` before comparing.
	/// Returns `false` if the cast fails.
	static func ≍(lhs: Self, rhs: XSDValue) -> Bool {
		guard let lhv = lhs.value else {
			return false
		}
		return lhv ≍ rhs
	}

	/// The default XSD equality with right-hand `Self`.
	///
	/// Casts the `XSDValueLike` to an `XSDValue` before comparing.
	/// Returns `false` if the cast fails.
	static func ≍(lhs: XSDValue, rhs: Self) -> Bool {
		guard let rhv = rhs.value else {
			return false
		}
		return lhs ≍ rhv
	}

	/// Inverses the result of the left-hand equality relation.
	static func ≭(lhs: Self, rhs: XSDValue) -> Bool {
		return !(lhs ≍ rhs)
	}

	/// Inverses the result of the right-hand equality relation.
	static func ≭(lhs: XSDValue, rhs: Self) -> Bool {
		return !(lhs ≍ rhs)
	}

	/// The default XSD less-than with dual-hand `Self`.
	///
	/// Casts both sides to `XSDValue`s before comparing.
	/// Returns `false` if the cast fails.
	static func ≺(lhs: Self, rhs: Self) -> Bool {
		guard
			let lhv = lhs.value,
			let rhv = rhs.value
		else {
			return false
		}
		return lhv ≺ rhv
	}

	/// The default XSD less-than with left-hand `Self`.
	///
	/// Casts the `XSDValueLike` to an `XSDValue` before comparing.
	/// Returns `false` if the cast fails.
	static func ≺(lhs: Self, rhs: XSDValue) -> Bool {
		guard let lhv = lhs.value else {
			return false
		}
		return lhv ≺ rhs
	}

	/// The default XSD less-than with right-hand `Self`.
	///
	/// Casts the `XSDValueLike` to an `XSDValue` before comparing.
	/// Returns `false` if the cast fails.
	static func ≺(lhs: XSDValue, rhs: Self) -> Bool {
		guard let rhv = rhs.value else {
			return false
		}
		return lhs ≺ rhv
	}

	/// Inverses the result of the left-hand less-than relation.
	static func ⊀(lhs: Self, rhs: XSDValue) -> Bool {
		return !(lhs ≺ rhs)
	}

	/// Inverses the result of the right-hand less-than relation.
	static func ⊀(lhs: XSDValue, rhs: Self) -> Bool {
		return !(lhs ≺ rhs)
	}

	/// The default XSD greater-than with dual-hand `Self`.
	///
	/// Casts both sides to `XSDValue`s before comparing.
	/// Returns `false` if the cast fails.
	static func ≻(lhs: Self, rhs: Self) -> Bool {
		guard
			let lhv = lhs.value,
			let rhv = rhs.value
		else {
			return false
		}
		return lhv ≻ rhv
	}

	/// The default XSD greater-than with left-hand `Self`.
	///
	/// Casts the `XSDValueLike` to an `XSDValue` before comparing.
	/// Returns `false` if the cast fails.
	static func ≻(lhs: Self, rhs: XSDValue) -> Bool {
		guard let lhv = lhs.value else {
			return false
		}
		return lhv ≻ rhs
	}

	/// The default XSD greater-than with right-hand `Self`.
	///
	/// Casts the `XSDValueLike` to an `XSDValue` before comparing.
	/// Returns `false` if the cast fails.
	static func ≻(lhs: XSDValue, rhs: Self) -> Bool {
		guard let rhv = rhs.value else {
			return false
		}
		return lhs ≻ rhv
	}

	/// Inverses the result of the left-hand less-than relation.
	static func ⊁(lhs: Self, rhs: XSDValue) -> Bool {
		return !(lhs ≻ rhs)
	}

	/// Inverses the result of the left-hand greater-than relation.
	static func ⊁(lhs: XSDValue, rhs: Self) -> Bool {
		return !(lhs ≻ rhs)
	}

	/// Identifies whether exactly one of (left-hand) less-than and equality is true.
	static func ≼(lhs: Self, rhs: XSDValue) -> Bool {
		return (lhs ≺ rhs || lhs ≍ rhs) && !(lhs ≺ rhs && lhs ≍ rhs)
	}

	/// Identifies whether exactly one of (right-hand) less-than and equality is true.
	static func ≼(lhs: XSDValue, rhs: Self) -> Bool {
		return (lhs ≺ rhs || lhs ≍ rhs) && !(lhs ≺ rhs && lhs ≍ rhs)
	}

	/// Inverses the result of the left-hand less-than-or-equals relation.
	static func ⋠(lhs: Self, rhs: XSDValue) -> Bool {
		return !(lhs ≼ rhs)
	}

	/// Inverses the result of the right-hand less-than-or-equals relation.
	static func ⋠(lhs: XSDValue, rhs: Self) -> Bool {
		return !(lhs ≼ rhs)
	}

	/// Identifies whether exactly one of (left-hand) greater-than and equality is true.
	static func ≽(lhs: Self, rhs: XSDValue) -> Bool {
		return (lhs ≻ rhs || lhs ≍ rhs) && !(lhs ≻ rhs && lhs ≍ rhs)
	}

	/// Identifies whether exactly one of (right-hand) greater-than and equality is true.
	static func ≽(lhs: XSDValue, rhs: Self) -> Bool {
		return (lhs ≻ rhs || lhs ≍ rhs) && !(lhs ≻ rhs && lhs ≍ rhs)
	}

	/// Inverses the result of the left-hand greater-than-or-equals relation.
	static func ⋡(lhs: Self, rhs: XSDValue) -> Bool {
		return !(lhs ≽ rhs)
	}

	/// Inverses the result of the right-hand greater-than-or-equals relation.
	static func ⋡(lhs: XSDValue, rhs: Self) -> Bool {
		return !(lhs ≽ rhs)
	}

	/// Identifies whether exactly one of (left-hand) less-than, equality, and greater-than is true.
	static func ⟡̸(lhs: Self, rhs: XSDValue) -> Bool {
		if !(lhs ≺ rhs) && !(lhs ≻ rhs) {
			return !(lhs ≍ rhs) // No relations are true
		} else if lhs ≺ rhs || lhs ≻ rhs {
			return lhs ≍ rhs // Both a strict ordering and equality are true
		} else {
			return lhs ≺ rhs && lhs ≻ rhs // Both strict orderings are true
		}
	}

	/// Identifies whether exactly one of (right-hand) less-than, equality, and greater-than is true.
	static func ⟡̸(lhs: XSDValue, rhs: Self) -> Bool {
		if !(lhs ≺ rhs) && !(lhs ≻ rhs) {
			return !(lhs ≍ rhs) // No relations are true
		} else if lhs ≺ rhs || lhs ≻ rhs {
			return lhs ≍ rhs // Both a strict ordering and equality are true
		} else {
			return lhs ≺ rhs && lhs ≻ rhs // Both strict orderings are true
		}
	}

	/// Inverses the result of the left-hand incomperable relation.
	static func ⟡(lhs: Self, rhs: XSDValue) -> Bool {
		return !(lhs ⟡̸ rhs)
	}

	/// Inverses the result of the right-hand incomperable relation.
	static func ⟡(lhs: XSDValue, rhs: Self) -> Bool {
		return !(lhs ⟡̸ rhs)
	}

}
