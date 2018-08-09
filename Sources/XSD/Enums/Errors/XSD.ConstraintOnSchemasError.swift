public extension XSD {

	/// Errors which result from a failure to meet an XSD constraint on schemas.
	///
	/// Does *not* include those constraints labeled as "Schema Component Constraints"; these are covered by `XSDSchemaComponentConstraintError`.
	enum ConstraintOnSchemasError: Error {

		/// With the exception of `xsd:anySimpleType`, the `baseTypeDefinition` must be an `XSDSimpleTypeDefinition`.
		case baseTypeMustBeSimple

		/// The `baseTypeDefinition` of `xsd:anySimpleType` must be the package-provided one for `xsd:anyType`.
		case baseTypeOfAnySimpleMustBeAny

		/// `name` and `context` cannot both be defined.
		case contextMustBeAbsentWhenName

		/// One of `name` or `context` must be provided for all datatypes.
		case contextRequiredIfNameAbsent

		/// If a constraint is `fixed`, its value must not change.
		case fixedConstraintMustNotChange

		/// One of the properties of the schema object is not valid for its type.
		case incorrectType(forProperty: String)

		/// The value of `primitiveTypeDefinition` must be a primitive.
		case primitiveMustBePrimitive

		/// With the exception of `xsd:anySimpleType`, there must be a non-nil value for `variety`.
		case varietyMustBePresent

		/// The `variety` of `xsd:anySimpleType` must be `nil`.
		case varietyOfAnySimpleMustBeNil

	}

}
