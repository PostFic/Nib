/*
final class AtomicTypeDefinition<ValueSpace: XSDValue>: SimpleTypeDefinition {

	init(
		name: String?,
		targetNamespace: String?,
		`final`: Set<XSDDerivation> = [],
		context: XSDSimpleTypeDefinition?,
		baseTypeDefinition: XSDSimpleTypeDefinition,
		facets: Set<XSDConstrainingFacet> = [],
		fundamentalFacets: Set<XSDFundamentalFacet> = [],
		isPrimitive: Bool = false,
		primitive: XSDSimpleTypeDefinition?
	) throws {
		try super.init(
			name: name,
			targetNamespace: targetNamespace,
			`final`: final,
			context: context,
			baseTypeDefinition: baseTypeDefinition,
			facets: facets,
			fundamentalFacets: fundamentalFacets,
			variety: .atomic,
			isPrimitive: isPrimitive,
			primitive: primitive,
		)
	}

	/// Creates a primitive type definition.
	convenience init(
		name: String,
		targetNamespace: String = "http://www.w3.org/2001/XMLSchema",
		facets: Set<XSDConstrainingFacet> = [],
		fundamentalFacets: Set<XSDFundamentalFacet> = []
	) throws {
		try super.init(
			name: name,
			targetNamespace: targetNamespace,
			baseTypeDefinition: xsdAnyAtomicType,
			facets: facets,
			fundamentalFacets: fundamentalFacets,
			isPrimitive: true,
		)
		self✓
	}

	/// Creates an atomic type definition.
	convenience init(
		name: String?,
		targetNamespace: String?,
		`final`: Set<XSDDerivation> = [],
		context: XSDSimpleTypeDefinition?,
		baseTypeDefinition: XSDSimpleTypeDefinition,
		facets: Set<XSDConstrainingFacet> = []
	) throws {

		/// Generates our fundamental facets from our input params.
		func makeFundamentalFacets() -> Set<XSDFundamentalFacet> {

			/// A set of the four fundamental facets.
			var fundamentalFacets = Set<XSDFundamentalFacet>(minimumCapacity: 4)

			/*
			An ordinary atomic type is `ordered` exactly when its base type is `ordered`.
			*/
			fundamentalFacets.update(with: baseTypeDefinition.fundamentalFacets[.📛("ordered")])

			/*
			An ordinary atomic type is `bounded` exactly when it has a lower and upper bound.
			The lower bound may be specified by `minInclusive` *or* `minExclusive`.
			The upper bound may be specified by `maxInclusive` *or* `maxExclusive`.
			*/
			if
				(facets[.📛("minInclusive")] != nil || facets[.📛("minExclusive")] != nil) &&
				(facets[.📛("maxInclusive")] != nil || facets[.📛("maxExclusive")] != nil)
			{
				fundamentalFacets.update(with: .bounded(value: try! make🌁XSDBooleanLiteral(true)))
			} else {
				fundamentalFacets.update(with: .bounded(value: try! make🌁XSDBooleanLiteral(false)))
			}

			/*
			An ordinary atomic type is has `finite` cardinality exactly when:
			*/
			if

				/*
				The base type has `finite` cardinality, OR
				*/
				baseTypeDefinition.fundamentalFacets[.📛("cardinality")] == .finite ||

				/*
				At least one of `length`, `maxLength`, or `totalDigits` is set, OR
				*/
				facets[.📛("length")] != nil ||
				facets[.📛("maxLength")] != nil ||
				facets[.📛("totalDigits")] != nil ||

				/*
				The type has a lower and upper bound (see above), and either has `fractionDigits` set or is a date with no time component.
				*/
				(facets[.📛("minInclusive")] != nil || facets[.📛("minExclusive")] != nil) &&
				(facets[.📛("maxInclusive")] != nil || facets[.📛("maxExclusive")] != nil) &&
				(
					facets[.📛("fractionDigits")] != nil ||
					baseTypeDefinition.primitiveTypeDefinition === xsdDate ||
					baseTypeDefinition.primitiveTypeDefinition === xsdGYearMonth ||
					baseTypeDefinition.primitiveTypeDefinition === xsdGYear ||
					baseTypeDefinition.primitiveTypeDefinition === xsdGMonthDay ||
					baseTypeDefinition.primitiveTypeDefinition === xsdGDay ||
					baseTypeDefinition.primitiveTypeDefinition === xsdGMonth
				)

			{
				fundamentalFacets.update(with: .cardinality(value: .finite))
			} else {
				fundamentalFacets.update(with: .cardinality(value: .countablyInfinite))
			}

			/*
			An ordinary atomic type is `numeric` exactly when its base type is `numeric`.
			*/
			fundamentalFacets.update(with: baseTypeDefinition.fundamentalFacets[.📛("numeric")])

			/*
			We have now set all of our fundamental facets.
			*/
			return fundamentalFacets

		}

		/*
		Try to initialize.
		*/
		try super.init(
			name: name,
			targetNamespace: targetNamespace,
			`final`: `final`,
			context: context,
			baseTypeDefinition: baseTypeDefinition,
			facets: facets,
			fundamentalFacets: makeFundamentalFacets(),
			primitiveTypeDefinition: baseTypeDefinition.primitiveTypeDefinition,
		)

		self✓
	}

	override public func makeLiteral(_ representation: String) throws -> XSDLiteral {
		return try XSDLiteral(representation, type: self)
	}

	override public func makeValue(_ representation: String) throws -> XSDValueList {
		if let patterns = facets[.📛("pattern")]?.value as! Set<XSDRegularExpression>? {
			for pattern in patterns {
				guard // Validation Rule: pattern valid
					pattern.firstMatch(in: representation) != nil
				else {
					throw XSDValidationError.patternValid
				}
			}
		}
		return try [ValueSpace(representation, constrainedBy: facets)]
	}

	private static postfix func ✓(
		🈁: XSDAtomicTypeDefinition<ValueSpace>
	) throws -> XSDAtomicTypeDefinition<ValueSpace> {
		(🈁 as SimpleTypeDefinition)✓

		/*
		There is a special atomic type, `xsd:anyAtomicType`.
		We check for it first, becuase it has special constraints.
		*/
		if 🈁.targetNamespace == xsdNamespace && String(🈁.name) == "anyAtomicType" {

			/*
			`xsd:anyAtomicType` must not have a `primitiveTypeDefinition`.
			*/
			guard 🈁.primitiveTypeDefinition == nil else {
				throw XSDSchemaError.anyAtomicMustNotHavePrimitive
			}

			/*
			`xsd:anyAtomicType` must not have any facets.
			*/
			guard 🈁.facets.isEmpty else {
				throw XSDSchemaError.specialMustNotHaveFacets
			}

		} else {

			/*
			There must be a `primitiveTypeDefinition` for atomic types.
			*/
			guard let thePrimitive = 🈁.primitiveTypeDefinition else {
				throw XSDSchemaError.atomicMustHavePrimitive
			}

			/*
			Furthermore, the primitive type must be a primitive.
			*/
			guard thePrimitive == thePrimitive.primitiveTypeDefinition else {
				throw XSDSchemaError.primitiveMustBePrimitive
			}

		}

		/*
		`itemTypeDefinition` must be absent for atomic types.
		*/
		guard 🈁.itemTypeDefinition == nil else {
			throw XSDSchemaError.atomicMustNotHaveItem
		}

		/*
		`memberTypeDefinitions` must be absent for atomic types.
		*/
		guard 🈁.memberTypeDefinitions == nil else {
			throw XSDSchemaError.atomicMustNotHaveMembers
		}

		/*
		Constraints on facets.
		*/
		if let enumeration = facets[.📛("enumeration")]?.value as! Set<XSDValue>? {
			for `case` in enumeration {
				guard // Schema Component Constraint: enumeration valid restriction
					`case` is ValueSpace
				else {
					throw XSDValidationError.enumerationValidRestriction
				}
			}
		}

	}
}
*/
