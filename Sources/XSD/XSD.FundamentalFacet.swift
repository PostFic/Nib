public extension XSD {

	/// An enumeration representing the XSD‐defined fundamental facets.
	enum FundamentalFacet: String {

		/// [xsd:ordered](http://www.w3.org/2001/XMLSchema#ordered).
		case ordered

		/// [xsd:bounded](http://www.w3.org/2001/XMLSchema#bounded).
		case bounded

		/// [xsd:cardinality](http://www.w3.org/2001/XMLSchema#cardinality).
		case cardinality

		/// [xsd:numeric](http://www.w3.org/2001/XMLSchema#numeric).
		case numeric

	}

}
