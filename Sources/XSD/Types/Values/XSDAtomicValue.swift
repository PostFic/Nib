import Foundation

/// An *untyped* XSD atomic value.
///
/// `XSDAtomicValue`s are "untyped" in the sense that they are not associated with any particular XSD datatype, but rather represent the set of value spaces, lexical spaces, functions, relations, and procedures which typed literals draw upon.
///
/// You shouldn't create instances of this class directly; it exists for subclassing to create new value spaces.
open class XSDAtomicValue: BasicTypesConvertible, Hashable, Relatable {

	/// Converts the value to a `Bool`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	open var bool: Bool? {
		return nil
	}

	/// Converts the value to `Data`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	open var data: Data? {
		return nil
	}

	/// Converts the value to a `Decimal`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	open var decimal: Decimal? {
		return nil
	}

	/// Converts the value to a `Double`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	open var double: Double? {
		return nil
	}

	/// Converts the value to a `Float`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	open var float: Float? {
		return nil
	}

	/// Converts the value to a `Float80`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	open var float80: Float80? {
		return nil
	}

	/// Converts the value to a `Int`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	open var int: Int? {
		return nil
	}

	/// Converts the value to a `Int8`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	open var int8: Int8? {
		return nil
	}

	/// Converts the value to a `Int16`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	open var int16: Int16? {
		return nil
	}

	/// Converts the value to a `Int32`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	open var int32: Int32? {
		return nil
	}

	/// Converts the value to a `Int64`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	open var int64: Int64? {
		return nil
	}

	/// Converts the value to a `String`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	open var string: String? {
		return nil
	}

	/// Converts the value to a `UInt`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	open var uInt: UInt? {
		return nil
	}

	/// Converts the value to a `UInt8`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	open var uInt8: UInt8? {
		return nil
	}

	/// Converts the value to a `UInt16`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	open var uInt16: UInt16? {
		return nil
	}

	/// Converts the value to a `UInt32`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	open var uInt32: UInt32? {
		return nil
	}

	/// Converts the value to a `UInt64`, if possible.
	///
	/// Needs to be overridden by subclasses for a non-`nil` result.
	open var uInt64: UInt64? {
		return nil
	}

	/// Creates a new instance.
	public init() {}

	/// Creates a new instance from the given `representation`.
	public required convenience init(_ literal: String) throws {
		self.init()
	}

	/// Hashes the instance.
	///
	/// Needs to be overridden by subclasses for a hash other than `Float.nan`.
	open func hash(into hasher: inout Hasher) {
		hasher.combine(Float.nan)
	}

	/// The equality relation, in the XSD sense.
	///
	/// Needs to be overridden by subclasses for a non-`false` value.
	open func equal(to other: XSDAtomicValue) -> Bool {
		return false
	}

	/// The greater-than relation, in the XSD sense.
	///
	/// Needs to be overridden by subclasses for a non-`false` value.
	open func greater(than other: XSDAtomicValue) -> Bool {
		return false
	}

	/// The identity relation, in the XSD sense.
	///
	/// Defaults to `===`; needs to be overridden by subclasses for any other value.
	open func identical(to other: XSDAtomicValue) -> Bool {
		return self === other
	}

	/// The less-than relation, in the XSD sense.
	///
	/// Needs to be overridden by subclasses for a non-`false` value.
	open func lesser(than other: XSDAtomicValue) -> Bool {
		return false
	}

	/// The Swift less-than comparison.
	///
	/// This is defined so that implementations which are `Comparable` can simply declare the protocol without having to do any extra work.
	/// However, it does not on its own imply a strict ordering.
	public static func <(lhs: XSDAtomicValue, rhs: XSDAtomicValue) -> Bool {
		return lhs ≺ rhs
	}

	/// The Swift equality comparison.
	///
	/// For `XSDValue`s, this is the same as the XSD equality relation.
	public static func ==(lhs: XSDAtomicValue, rhs: XSDAtomicValue) -> Bool {
		return lhs ≍ rhs
	}

	/// The XSD identity relation.
	///
	/// `true` when both sides are `identical(to:)` each other.
	public static func ≡(lhs: XSDAtomicValue, rhs: XSDAtomicValue) -> Bool {
		return lhs.identical(to: rhs) && rhs.identical(to: lhs)
	}

	/// The XSD identity relation.
	///
	/// `true` when both sides are `equal(to:)` each other.
	public static func ≍(lhs: XSDAtomicValue, rhs: XSDAtomicValue) -> Bool {
		return lhs.equal(to: rhs) && rhs.equal(to: lhs)
	}

	/// The XSD less-than relation.
	///
	/// `true` when the left-hand side is `lesser(than:)` the right, and the right-hand side is `greater(than:)` the left.
	public static func ≺(lhs: XSDAtomicValue, rhs: XSDAtomicValue) -> Bool {
		return lhs.lesser(than: rhs) && rhs.greater(than: lhs)
	}

	/// The XSD greater-than relation.
	///
	/// `true` when the left-hand side is `greater(than:)` the right, and the right-hand side is `lesser(than:)` the left.
	public static func ≻(lhs: XSDAtomicValue, rhs: XSDAtomicValue) -> Bool {
		return lhs.greater(than: rhs) && rhs.lesser(than: lhs)
	}

}
