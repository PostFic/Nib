/// An array of `XSDValue`s.
///
/// `XSDValueList`s are `XSDValueLike`, which means that they can be treated like `XSDValue`s in many situations.
public typealias XSDValueList = [XSDValue]

/*
Extends `XSDValueList` to be `BasicTypeConvertible` and defines the methods needed for `XSDValueLike` conformance.

The actual `XSDValueLike` extension comes later because otherwise the compiler will warn us about having multiple very similar definitions for `≡`.
*/
extension Array: BasicTypesConvertible where Element == XSDValue {

	/// The `Bool` representation, if possible.
	///
	/// + Returns: The `bool` property of the contained `XSDValue` if this is a singleton `Array`; otherwise, `nil`.
	public var bool: Bool? {
		if count == 1 {
			return self[0].bool
		} else {
			return nil
		}
	}


	/// The `Double` representation, if possible.
	///
	/// + Returns: The `double` property of the contained `XSDValue` if this is a singleton `Array`; otherwise, `nil`.
	public var double: Double? {
		if count == 1 {
			return self[0].double
		} else {
			return nil
		}
	}

	/// The `Float` representation, if possible.
	///
	/// + Returns: The `float` property of the contained `XSDValue` if this is a singleton `Array`; otherwise, `nil`.
	public var float: Float? {
		if count == 1 {
			return self[0].float
		} else {
			return nil
		}
	}

	/// The `Int` representation, if possible.
	///
	/// + Returns: The `int` property of the contained `XSDValue` if this is a singleton `Array`; otherwise, `nil`.
	public var int: Int? {
		if count == 1 {
			return self[0].int
		} else {
			return nil
		}
	}

	/// The `String` representation, if possible.
	///
	/// + Returns: The `string` properties of all contained `XSDValue`s, joined by spaces, if possible; otherwise, `nil`.
	public var string: String? {
		if count == 1 {
			return self[0].string
		} else {
			var result = ""
			for value in self {
				if let string = value.string {
					result += " \(string)"
				} else {
					return nil
				}
			}
			return result
		}
	}

	/// The `UInt` representation, if possible.
	///
	/// + Returns: The `uInt` property of the contained `XSDValue` if this is a singleton `Array`; otherwise, `nil`.
	public var uInt: UInt? {
		if count == 1 {
			return self[0].uInt
		} else {
			return nil
		}
	}

	/// The contained `XSDValue`, if there is only one.
	public var value: XSDValue? {
		if count == 1 {
			return self[0]
		} else {
			return nil
		}
	}

	/// XSD identity across two value lists.
	///
	/// XSD defines two lists to be identical if all values in the list are pairwise identical.
	public static func ≡(lhs: Array<Element>, rhs: Array<Element>) -> Bool {
		guard lhs.count == rhs.count else {
			return false
		}
		for index in 0..<lhs.count {
			guard lhs[index] ≡ rhs[index] else {
				return false
			}
		}
		return true
	}

	/// XSD equality across two value lists.
	///
	/// XSD defines two lists to be equal if all values in the list are pairwise equal.
	public static func ≍(lhs: Array<Element>, rhs: Array<Element>) -> Bool {
		guard lhs.count == rhs.count else {
			return false
		}
		for index in 0..<lhs.count {
			guard lhs[index] ≍ rhs[index] else {
				return false
			}
		}
		return true
	}

}

/*
Extends `XSDValueList` to be `XSDValueLike`.
*/
extension Array:
	Relatable,
	XSDValueLike
where Element == XSDValue {}
