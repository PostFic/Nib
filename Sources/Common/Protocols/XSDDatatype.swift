/// An abstracted XSD datatype.
public protocol XSDDatatype {

	/// The `XSDSimpleTypeDefinition` for the datatype.
	var definition: XSDSimpleTypeDefinition { get }

	/// Creates an `XSDLiteral` from the given string.
	///
	/// Throws if the given string is not in the lexical space for the datatype.
	func makeLiteral(_: String) throws -> XSDLiteral

	/// Creates an `XSDValueList` from the given string.
	///
	/// Throws if the given string is not in the lexical space for the datatype.
	func makeValue(_: String) throws -> XSDValueList

	/// Performs pre-lexical transformations on the given string.
	///
	/// Throws if the string is for some reason invalid.
	func prelexicalTransform(_: String) throws -> String

}

extension XSDDatatype {

	/// Defaults to just an alias for `definition.makeLiteral()`.
	func makeLiteral(_ representation: String) throws -> XSDLiteral {
		return try definition.makeLiteral(representation)
	}

	/// Defaults to just an alias for `definition.makeValue()`.
	func makeValue(_ representation: String) throws -> XSDValueList {
		return try definition.makeValue(representation)
	}

	/// Defaults to just an alias for `definition.prelexicalTransform()`.
	func prelexicalTransform(_ representation: String) throws -> String {
		return try definition.prelexicalTransform(representation)
	}

}
