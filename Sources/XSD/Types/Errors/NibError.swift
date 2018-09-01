/// Common errors which aren't directly related to XSD processing.
public enum NibError: Error {

	/// For use when attempting to constrain a facet with another, non-applicable facet.
	///
	/// This error will only occur if two different facet types have the same `name`.
	case facetConstraintMismatch

	/// Only XML characters are allowed in `XSDRegularExpression`s.
	case invalidCharacterInRegularExpression

	/// Undefined escape sequences are not allowed in XSD Regular Expressions.
	case invalidEscapeInRegularExpression

}
