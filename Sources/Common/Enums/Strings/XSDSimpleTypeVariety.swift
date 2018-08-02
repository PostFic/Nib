/// Type variety.
public enum XSDSimpleTypeVariety: String {

	/// Atomic type variety.
	case atomic

	/// List type variety.
	///
	/// Should not be used for RDF types; use RDF list structures instead.
	///
	/// Included for completeness.
	case list

	/// Union type variety.
	case union

}
