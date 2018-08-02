/// A typed XSD literal.
public struct XSDLiteral: CustomStringConvertible, Hashable, Relatable {

	/// The `XSDDatatype` for the literal.
	public let datatype: XSDDatatype

	/// The lexical representation of the literal.
	///
	/// Calling `String(describing:)` is the preferred means of accessing this representation.
	public let description: String

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

	/// "Unsafely" creates a new instance.
	///
	/// Does not validate the `value` against the `type` or apply pre-lexical transformations to the `representation`.
	/// This initializer is strictly for `internal` use with "foggy" literals, particularly when `type.datatype` is not yet available.
	init(unsafe representation: String, type: XSDDatatype, value: XSDValueList) {
		datatype = type
		description = representation
		self.value = value
	}

	/// Hashes the literal.
	///
	/// Literals are hashed by their lexical representation.
	public func hash(into hasher: inout Hasher) {
		hasher.combine(description)
	}

	/// Checks for literal equality.
	///
	/// Literals are equal if they have the same lexical representation and equivalent values.
	public static func ==(lhs: XSDLiteral, rhs: XSDLiteral) -> Bool {
		return lhs ≍ rhs && lhs.description == rhs.description
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
