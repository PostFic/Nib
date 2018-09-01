public final class XSDAtomicTypeDefinition<ValueSpace: XSDAtomicValue>:
	XSDSimpleTypeDefinition
{

	private init(
		name: XSDValue,
		targetNamespace: XSDValue? = nil,
		final: Set<ConstructionMethod> = [],
		baseTypeDefinition: XSDSimpleTypeDefinition,
		facets: XSDConstrainingFacets = [],
		fundamentalFacets: XSDFundamentalFacets = [],
		isPrimitive: Bool = false,
		primitiveTypeDefinition: XSDSimpleTypeDefinition? = nil
	) {
		super.init(
			name: name,
			targetNamespace: targetNamespace,
			final: `final`,
			baseTypeDefinition: baseTypeDefinition,
			facets: facets,
			fundamentalFacets: fundamentalFacets,
			variety: .atomic,
			isPrimitive: isPrimitive,
			primitiveTypeDefinition: primitiveTypeDefinition
		)
	}

	/// Creates `xsd:anyAtomicType`.
	override convenience init() {
		self.init(
			name: [try! 🌌String("anyAtomicType")],
			targetNamespace: [try! 🌌AnyURI(XSD.targetNamespace)],
			baseTypeDefinition: 🌉anySimpleType
		)
	}

	/// Creates a primitive type definition.
	convenience init(
		_ name: String,
		_ allFacets: XSDFacets
	) {
		self.init(
			name: [try! 🌌String(name)],
			targetNamespace: [try! 🌌AnyURI(XSD.targetNamespace)],
			baseTypeDefinition: 🌉anyAtomicType,
			facets: allFacets.constraining!,
			fundamentalFacets: allFacets.fundamental,
			isPrimitive: true
		)
	}

	/// Creates a primitive type definition.
	public convenience init(
		name: String,
		targetNamespace: String? = XSD.targetNamespace,
		facets: XSDConstrainingFacets,
		fundamentalFacets: XSDFundamentalFacets
	) throws {
		guard facets[.whiteSpace] != nil else {
			throw XSD.ConstraintOnSchemasError.primitiveMustHaveWhiteSpaceFacet
		}
		self.init(
			name: try name☆XSD.NCName,
			targetNamespace: try targetNamespace ?☆ XSD.anyURI,
			baseTypeDefinition: 🌉anyAtomicType,
			facets: facets,
			fundamentalFacets: fundamentalFacets,
			isPrimitive: true
		)
	}

	/// Creates an atomic type definition.
	public convenience init(
		_ name: String,
		_ baseTypeDefinition: XSDAtomicTypeDefinition,
		_ facets: XSDConstrainingFacets = []
	) {
		let primitive = baseTypeDefinition.primitiveTypeDefinition!
		self.init(
			name: [try! 🌌String(name)],
			targetNamespace: [try! 🌌AnyURI(XSD.targetNamespace)],
			baseTypeDefinition: baseTypeDefinition,
			facets: facets,
			fundamentalFacets: try! XSDAtomicTypeDefinition.makeFacets(
				baseTypeDefinition: baseTypeDefinition,
				facets: facets,
				primitiveTypeDefinition: primitive
			),
			primitiveTypeDefinition: primitive
		)
	}

	/// Creates an atomic type definition.
	public convenience init(
		targetNamespace: String? = nil,
		final: Set<ConstructionMethod> = [],
		name: String,
		base: XSDDatatype,
		_ additionalFacets: XSDConstrainingFacet...
	) throws {
		guard base.definition !== 🌉anyAtomicType else {
			throw XSD.ConstraintOnSchemasError.ordinaryBaseTypeMustBeOrdinary
		}
		let primitive = base.definition.primitiveTypeDefinition!
		let facets = try base.definition.facets.constrained(with: additionalFacets)
		self.init(
			name: try name☆XSD.NCName,
			targetNamespace: try targetNamespace ?☆ XSD.anyURI,
			final: `final`,
			baseTypeDefinition: base.definition,
			facets: facets,
			fundamentalFacets: try XSDAtomicTypeDefinition.makeFacets(
				baseTypeDefinition: base.definition,
				facets: facets,
				primitiveTypeDefinition: primitive
			),
			primitiveTypeDefinition: primitive
		)
	}

	override func makeRawValue(_ representation: String) throws -> XSDValue {
		return [try ValueSpace(representation)]
	}

	fileprivate static func makeFacets(
		baseTypeDefinition: XSDSimpleTypeDefinition,
		facets: XSDConstrainingFacets,
		primitiveTypeDefinition: XSDSimpleTypeDefinition
	) throws -> XSDFundamentalFacets {
		return [
			try XSD.FundamentalFacet.Ordered(
				baseTypeDefinition: baseTypeDefinition,
				facets: facets,
				primitiveTypeDefinition: primitiveTypeDefinition
			),
			try XSD.FundamentalFacet.Bounded(
				baseTypeDefinition: baseTypeDefinition,
				facets: facets,
				primitiveTypeDefinition: primitiveTypeDefinition
			),
			try XSD.FundamentalFacet.Cardinality(
				baseTypeDefinition: baseTypeDefinition,
				facets: facets,
				primitiveTypeDefinition: primitiveTypeDefinition
			),
			try XSD.FundamentalFacet.Numeric(
				baseTypeDefinition: baseTypeDefinition,
				facets: facets,
				primitiveTypeDefinition: primitiveTypeDefinition
			)
		]
	}

}
