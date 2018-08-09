public extension XSD {

	/// Errors which result from a failure to meet an XSD schema component constraint.
	enum SchemaComponentConstraintError: Error {

		/// Schema Component Constraint: Applicable Facets
		///
		/// Only certain facets are applicable depending on the `variety` of the datatype.
		case applicableFacets

		/// `whiteSpace` can only be constrained to be more restrictive.
		case whiteSpaceValidRestriction

		/// Pattern restrictions must be supersets of their bases.
		case validRestrictionOfPattern

	}

}
