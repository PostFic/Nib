/// Common errors which aren't directly related to XSD processing.
public enum NibError: Error {

	/// Only XML characters are allowed in `XSDRegularExpression`s.
	case invalidCharacterInRegularExpression

}
