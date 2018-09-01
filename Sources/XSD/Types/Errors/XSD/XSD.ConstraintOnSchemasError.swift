public extension XSD {

	/// Errors which result from a failure to meet an XSD constraint on schemas.
	///
	/// Does *not* include those constraints labeled as "Schema Component Constraint"; these are covered by `XSDSchemaComponentConstraintError`.
	enum ConstraintOnSchemasError: Error {

		/// The `baseTypeDefinition` must have the given facet.
		case baseTypeMustHaveFacet(_: String)

		/// If a constraint is `fixed`, its value must not change.
		case fixedConstraintMustNotChange

		/// One of the properties of the schema object is not valid for its type.
		case incorrectType(forProperty: String)

		/// The `itemTypeDefinition` must have the given facet.
		case itemTypeMustHaveFacet(_: String)

		/// A type in the `memberTypeDefinitions` did not have the given facet.
		case memberTypeMustHaveFacet(_: String)

		/// The base type of an ordinary type must also be ordinary
		case ordinaryBaseTypeMustBeOrdinary

		/// Primitives must have a `whiteSpace` facet.
		case primitiveMustHaveWhiteSpaceFacet

	}

}
