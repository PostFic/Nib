/// An abstracted XSD datatype.
public protocol XSDDatatype {

	/// The Simple Type Definition for the datatype.
	var definition: XSDSimpleTypeDefinition { get }

	/// Creates an `XSDLiteral` from the given string.
	func makeLiteral(_: String) -> XSDLiteral

	/// Creates an `XSDValueList` from the given string.
	///
	/// Throws if the given string is not in the value space for the datatype.
	func makeValue(_: String) throws -> XSDValue

}

public extension XSDDatatype {

	/// Defaults to just make a literal using the `definition`.
	func makeLiteral(_ literal: String) -> XSDLiteral {
		return XSDLiteral(literal, type: self)
	}

	/// Defaults to just make a value using the `definition`.
	func makeValue(_ representation: String) throws -> XSDValue {
		return try definition.makeValue(representation)
	}

	/// A default implementation of the `⤱` operator.
	///
	/// `XSDDatatype` is not `CrossConvertibleToLiteral` by default, but this implementation means that protocol conformance comes free to any type that implements both.
	static func ⤱(literal: String, datatype: Self) -> XSDLiteral {
		return datatype.makeLiteral(literal)
	}

	/// A default implementation of the `☆` operator.
	///
	/// `XSDDatatype` is not `CrossConvertibleToValue` by default, but this implementation means that protocol conformance comes free to any type that implements both.
	static func ☆(literal: String, datatype: Self) throws -> XSDValue {
		return try datatype.makeValue(literal)
	}

}
