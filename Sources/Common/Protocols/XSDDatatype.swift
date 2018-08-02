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
