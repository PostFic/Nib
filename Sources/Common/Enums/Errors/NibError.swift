/// Common errors which aren't directly related to XSD processing.
public enum NibError: Error {

	/// Only XML characters are allowed in `XSDRegularExpression`s.
	case invalidCharacterInRegularExpression

	/// The `.📛` case exists only for set access and cannot be used as an actual facet.
	case nametagUsedAsFacet

}
