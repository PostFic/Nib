/// Common errors which aren't directly related to XSD processing.
public enum NibError: Error {

	/// Only XML characters are allowed in `XSDRegularExpression`s.
	case invalidCharacterInRegularExpression

	/// The provided `representation` does not exist in the lexical space for the type.
	case notInLexicalSpace

}
