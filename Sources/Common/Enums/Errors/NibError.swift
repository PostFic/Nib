/// Common errors which aren't directly related to XSD processing.
public enum NibError: Error {

	/// Only XML characters are allowed in `XSDRegularExpression`s.
	case invalidCharacterInRegularExpression

	/// Undefined escape sequences are not allowed in XSD Regular Expressions.
	case invalidEscapeInRegularExpression

	/// The provided `representation` does not exist in the lexical space for the type.
	case notInLexicalSpace

}
