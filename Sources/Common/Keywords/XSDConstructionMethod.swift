/// Means of type derivation.
public enum XSDConstructionMethod: String {

	/// Facet-based restriction.
	case restriction

	/// Complex type extension.
	case `extension`

	/// Construction by list.
	case list

	/// Construction by union.
	case union

}
