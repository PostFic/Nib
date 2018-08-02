/// An *untyped* XSD value.
///
/// `XSDValue`s are "untyped" in the sense that they are not associated with any particular XSD datatype, but rather represent the set of value spaces, lexical spaces, functions, relations, and procedures which typed literals draw upon.
///
/// You shouldn't create instances of this class directly; it exists for subclassing to create new value spaces.
open class XSDValue: BasicTypesConvertible, Hashable, Relatable {

	/// Converts the value to a `Double`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	public var double: Double? {
		return nil
	}

	/// Converts the value to a `Float`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	public var float: Float? {
		return nil
	}

	/// Converts the value to a `Int`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	public var int: Int? {
		return nil
	}

	/// Converts the value to a `String`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	public var string: String? {
		return nil
	}

	/// Converts the value to a `UInt`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	public var uInt: UInt? {
		return nil
	}

	/// Simply returns `self`, as this is already an `XSDValue`.
	public var value: XSDValue? {
		return self
	}

	/// Creates a new instance.
	///
	/// This simply validates the instance with `` and throws any errors which result.
	public init() throws {
		try self✓
	}

	/// Hashes the instance.
	///
	/// Needs to be overridden by subclasses for a hash other than `Float.nan`.
	public func hash(into hasher: inout Hasher) {
		hasher.combine(Float.nan)
	}

	/// The equality relation, in the XSD sense.
	///
	/// Needs to be overridden by subclasses for a non-`false` value.
	public func equal(to other: XSDValue) -> Bool {
		return false
	}

	/// The greater-than relation, in the XSD sense.
	///
	/// Needs to be overridden by subclasses for a non-`false` value.
	public func greater(than other: XSDValue) -> Bool {
		return false
	}

	/// The identity relation, in the XSD sense.
	///
	/// Defaults to `===`; needs to be overridden by subclasses for any other value.
	public func identical(to other: XSDValue) -> Bool {
		return self === other
	}

	/// The less-than relation, in the XSD sense.
	///
	/// Needs to be overridden by subclasses for a non-`false` value.
	public func lesser(than other: XSDValue) -> Bool {
		return false
	}

	/// The Swift less-than comparison.
	///
	/// This is defined so that implementations which are `Comparable` can simply declare the protocol without having to do any extra work.
	/// However, it does not on its own imply a strict ordering.
	public static func <(lhs: XSDValue, rhs: XSDValue) -> Bool {
		return lhs ≺ rhs
	}

	/// The Swift equality comparison.
	///
	/// For `XSDValue`s, this is the same as the XSD equality relation.
	public static func ==(lhs: XSDValue, rhs: XSDValue) -> Bool {
		return lhs ≍ rhs
	}

	/// The Swift greater-than comparison.
	///
	/// This is defined so that implementations which are `Comparable` can simply declare the protocol without having to do any extra work.
	/// However, it does not on its own imply a strict ordering.
	public static func >(lhs: XSDValue, rhs: XSDValue) -> Bool {
		return lhs ≻ rhs
	}

	/// The XSD identity relation.
	///
	/// `true` when both sides are `identical(to:)` each other.
	public static func ≡(lhs: XSDValue, rhs: XSDValue) -> Bool {
		return lhs.identical(to: rhs) && rhs.identical(to: lhs)
	}

	/// The XSD identity relation.
	///
	/// `true` when both sides are `equal(to:)` each other.
	public static func ≍(lhs: XSDValue, rhs: XSDValue) -> Bool {
		return lhs.equal(to: rhs) && rhs.equal(to: lhs)
	}

	/// The XSD less-than relation.
	///
	/// `true` when the left-hand side is `lesser(than:)` the right, and the right-hand side is `greater(than:)` the left.
	public static func ≺(lhs: XSDValue, rhs: XSDValue) -> Bool {
		return lhs.lesser(than: rhs) && rhs.greater(than: lhs)
	}

	/// The XSD greater-than relation.
	///
	/// `true` when the left-hand side is `greater(than:)` the right, and the right-hand side is `lesser(than:)` the left.
	public static func ≻(lhs: XSDValue, rhs: XSDValue) -> Bool {
		return lhs.greater(than: rhs) && rhs.lesser(than: lhs)
	}

	/// Validates and returns `self`.
	///
	/// Does nothing (always returns) for the base class, but should be overridden with validation constraints by subclasses.
	/// Called during initialization—you shouldn't ever need to call this yourself.
	@discardableResult
	public static postfix func ✓(x: XSDValue) throws -> XSDValue {
		return x
	}

}
