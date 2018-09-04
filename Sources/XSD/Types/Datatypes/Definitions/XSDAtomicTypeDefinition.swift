final class XSDAtomicTypeDefinition<ValueSpace: XSDAtomicValue>: XSDSimpleTypeDefinition {

	init(
		name: XSDValue,
		targetNamespace: XSDValue? = nil,
		final: Set<ConstructionMethod> = [],
		baseTypeDefinition: XSDSimpleTypeDefinition,
		facets: XSDConstrainingFacets = [],
		fundamentalFacets: XSDFundamentalFacets? = nil,
		isPrimitive: Bool = false,
		primitiveTypeDefinition: XSDSimpleTypeDefinition? = nil
	) {
		let derivedFacets: [XSDFacet]!
		if isPrimitive {
			derivedFacets = nil
		} else {
			derivedFacets = baseTypeDefinition.fundamentalFacets.members.compactMap {
				try? type(of: $0 as! XSDFundamentalFacet).init(
					baseTypeDefinition: baseTypeDefinition,
					facets: facets,
					primitiveTypeDefinition: primitiveTypeDefinition!
				)
			}
		}
		super.init(
			name: name,
			targetNamespace: targetNamespace,
			final: `final`,
			baseTypeDefinition: baseTypeDefinition,
			facets: facets,
			fundamentalFacets: fundamentalFacets ?? Set(derivedFacets).fundamental,
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
			baseTypeDefinition: 🌉anySimpleType,
			fundamentalFacets: []
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

	/// Creates an atomic type definition.
	convenience init(
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
			primitiveTypeDefinition: primitive
		)
	}

	override func makeRawValue<StringType: StringProtocol>(
		_ representation: StringType
	) throws -> XSDValue {
		return [try ValueSpace(representation)]
	}

}
