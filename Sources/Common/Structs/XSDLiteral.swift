/// A typed XSD literal.
public struct XSDLiteral: BasicTypesConvertible, CustomStringConvertible, Hashable, Relatable {

	/// Returns the literal's `value` as a `Bool`, if possible.
	public var bool: Bool? {
		return value.bool
	}

	/// The `XSDDatatype` for the literal.
	public let datatype: XSDDatatype

	/// The lexical representation of the literal.
	///
	/// Calling `String(describing:)` is the preferred means of accessing this representation.
	public let description: String

	/// Returns the literal's `value` as a `Double`, if possible.
	public var double: Double? {
		return value.double
	}

	/// Returns the literal's `value` as a `Float`, if possible.
	public var float: Float? {
		return value.float
	}

	/// Returns the literal's `value` as a `Float80`, if possible.
	public var float80: Float80? {
		return value.float80
	}

	/// Returns the literal's `value` as an `Int`, if possible.
	public var int: Int? {
		return value.int
	}

	/// Returns the literal's `value` as an `Int8`, if possible.
	public var int8: Int8? {
		return value.int8
	}

	/// Returns the literal's `value` as an `Int16`, if possible.
	public var int16: Int16? {
		return value.int16
	}

	/// Returns the literal's `value` as an `Int32`, if possible.
	public var int32: Int32? {
		return value.int32
	}

	/// Returns the literal's `value` as an `Int64`, if possible.
	public var int64: Int64? {
		return value.int64
	}

	/// Returns the literal's `value` as a `String`, if possible.
	public var string: String? {
		return value.string
	}

	/// Returns the literal's `value` as a `UInt`, if possible.
	public var uInt: UInt? {
		return value.uInt
	}

	/// Returns the literal's `value` as a `UInt8`, if possible.
	public var uInt8: UInt8? {
		return value.uInt8
	}

	/// Returns the literal's `value` as a `UInt16`, if possible.
	public var uInt16: UInt16? {
		return value.uInt16
	}

	/// Returns the literal's `value` as a `UInt32`, if possible.
	public var uInt32: UInt32? {
		return value.uInt32
	}

	/// Returns the literal's `value` as a `UInt64`, if possible.
	public var uInt64: UInt64? {
		return value.uInt64
	}

	/// The value of the literal.
	public let value: XSDValueList

	/// Creates a new instance.
	///
	/// Throws if `representation` is not a valid lexical representation for `type`.
	public init(_ representation: String, type: XSDDatatype) throws {
		datatype = type
		description = try type.prelexicalTransform(representation)
		value = try type.makeValue(representation)
	}

	/// Hashes the literal.
	///
	/// Literals are hashed by their lexical representation.
	public func hash(into hasher: inout Hasher) {
		hasher.combine(description)
	}

	/// Checks for literal equality.
	///
	/// Literals are equal if they have the same lexical representation and equivalent `datatype`s.
	public static func ==(lhs: XSDLiteral, rhs: XSDLiteral) -> Bool {
		return
			lhs.datatype.definition === rhs.datatype.definition &&
			lhs.description == rhs.description
	}

	/// Compares the values of literals using an identity relation.
	///
	/// + Note: This is just a shorthand for `lhs.value ≡ rhs.value`.
	public static func ≡(lhs: XSDLiteral, rhs: XSDLiteral) -> Bool {
		return lhs.value ≡ rhs.value
	}

	/// Compares the values of literals using an equality relation.
	///
	/// + Note: This is just a shorthand for `lhs.value ≍ rhs.value`.
	public static func ≍(lhs: XSDLiteral, rhs: XSDLiteral) -> Bool {
		return lhs.value ≍ rhs.value
	}

	/// Compares the values of literals using a less-than relation.
	///
	/// + Note: This is just a shorthand for `lhs.value ≺ rhs.value`.
	public static func ≺(lhs: XSDLiteral, rhs: XSDLiteral) -> Bool {
		return lhs.value ≺ rhs.value
	}

	/// Compares the values of literals using a greater-than relation.
	///
	/// + Note: This is just a shorthand for `lhs.value ≻ rhs.value`.
	public static func ≻(lhs: XSDLiteral, rhs: XSDLiteral) -> Bool {
		return lhs.value ≻ rhs.value
	}

}
