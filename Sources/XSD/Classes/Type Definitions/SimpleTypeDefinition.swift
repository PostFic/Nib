import Common

/// Instances represent the XSD datatypes themselves, *not* typed literals.
class SimpleTypeDefinition: TypeDefinition, XSDSimpleTypeDefinition {

	/// The base type which this type was derived from.
	let baseTypeDefinition: XSDTypeDefinition

	/// The constraining facets for the type.
	let facets: XSDConstrainingFacets

	/// The fundamental facets for the type.
	let fundamentalFacets: XSDFundamentalFacets

	/// The type variety.
	let variety: XSDSimpleTypeVariety?

	/// Whether the type is primitive.
	///
	/// If `true`, then `primitiveTypeDefinition` will return `self`.
	let isPrimitive: Bool

	/// The primitive of this type, if different than `self`.
	let ？primitiveTypeDefinition: XSDSimpleTypeDefinition?

	/// The primitive type for an atomic type.
	///
	/// Will return `self` if the type is itself primitive.
	final var primitiveTypeDefinition: XSDSimpleTypeDefinition? {
		if isPrimitive {
			return self
		}
		return ？primitiveTypeDefinition
	}

	/// The item type for a list.
	let itemTypeDefinition: XSDSimpleTypeDefinition?

	/// The member types for a union.
	let memberTypeDefinitions: [XSDSimpleTypeDefinition]?

	/// The Simple Type Definition itself.
	final var definition: XSDSimpleTypeDefinition {
		return self
	}

	/// Creates a new datatype.
	init(
		name: String? = nil,
		targetNamespace: String? = nil,
		final: Set<XSDConstructionMethod> = [],
		context: XSDSimpleTypeDefinition? = nil,
		baseTypeDefinition: XSDTypeDefinition,
		facets: XSDConstrainingFacets = [],
		fundamentalFacets: XSDFundamentalFacets = [],
		variety: XSDSimpleTypeVariety? = nil,
		isPrimitive: Bool = false,
		primitiveTypeDefinition: XSDSimpleTypeDefinition? = nil,
		itemTypeDefinition: XSDSimpleTypeDefinition? = nil,
		memberTypeDefinitions: [XSDSimpleTypeDefinition]? = nil
	) throws {
		self.baseTypeDefinition = baseTypeDefinition
		self.facets = facets
		self.fundamentalFacets = fundamentalFacets
		self.variety = variety
		self.isPrimitive = isPrimitive
		？primitiveTypeDefinition = primitiveTypeDefinition
		self.itemTypeDefinition = itemTypeDefinition
		self.memberTypeDefinitions = memberTypeDefinitions
		try super.init(
			name: name,
			targetNamespace: targetNamespace,
			final: `final`,
			context: context
		)

		/*
		Some setups are in error if the datatype isn't `xsd:anySimpleType`.
		Others are required.
		*/
		if
			let theName = self.name?.string,
			let theNamespace = self.targetNamespace?.string,
			theNamespace == xsdTargetNamespace &&
			theName == "anySimpleType"
		{

			/*
			The `baseTypeDefinition` must be `xsdAnyType` for `xsd:anySimpleType`.
			*/
			guard baseTypeDefinition === 🌉anyType else {
				throw XSD.ConstraintOnSchemasError.baseTypeOfAnySimpleMustBeAny
			}

			/*
			The `variety` of `xsd:anySimpleType` must be absent.
			*/
			guard variety == nil else {
				throw XSD.ConstraintOnSchemasError.varietyOfAnySimpleMustBeNil
			}

			/*
			`xsd:anySimpleType` must not have any facets.
			*/
			guard facets.isEmpty else {
				throw XSD.SchemaComponentConstraintError.applicableFacets
			}

		} else {

			/*
			The `baseTypeDefinition` must be an `XSDSimpleTypeDefinition`.
			*/
			guard baseTypeDefinition is XSDSimpleTypeDefinition else {
				throw XSD.ConstraintOnSchemasError.baseTypeMustBeSimple
			}

			/*
			The `variety` must be present.
			*/
			guard variety != nil else {
				throw XSD.ConstraintOnSchemasError.varietyMustBePresent
			}

		}
	}

	func makeRawValue(_ representation: String) throws -> XSDValue {
		return try [🌌Value(representation)]
	}

	func makeValue(_ representation: String) throws -> XSDValue {
		var normalizedRepresentation = representation
		for facet in facets.prelexical {
			try (facet as! XSDPrelexicalFacet).🆗(&normalizedRepresentation)
		}
		for facet in facets.lexical {
			try (facet as! XSDLexicalFacet).🆗(normalizedRepresentation)
		}
		let value = try makeRawValue(normalizedRepresentation)
		for facet in facets.valuebased {
			try (facet as! XSDValuebasedFacet).🆗(value)
		}
		return value
	}

}
