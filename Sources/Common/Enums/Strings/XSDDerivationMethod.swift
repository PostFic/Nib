/// Means of type derivation.
public enum XSDDerivationMethod: String {

	/// Derivation by restriction.
	case restriction

	/// Derivation by extension.
	case `extension`

	/// List derivation.
	case list

	/// Union derivation.
	case union

}
