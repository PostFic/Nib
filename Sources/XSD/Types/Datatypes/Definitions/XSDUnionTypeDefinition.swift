class XSDUnionTypeDefinition: XSDSimpleTypeDefinition {

	/// Creates a union type definition.
	init(
		name: XSDValue,
		targetNamespace: XSDValue? = nil,
		final: Set<ConstructionMethod> = [],
		baseTypeDefinition: XSDSimpleTypeDefinition = 🌉anySimpleType,
		facets: XSDConstrainingFacets = [],
		memberTypeDefinitions: [XSDSimpleTypeDefinition] = []
	) {
		let derivedFacets = baseTypeDefinition.fundamentalFacets.members.compactMap {
			try? type(of: $0 as! XSDFundamentalFacet).init(
				baseTypeDefinition: baseTypeDefinition,
				facets: facets,
				memberTypeDefinitions: memberTypeDefinitions
			)
		}
		super.init(
			name: name,
			targetNamespace: targetNamespace,
			final: `final`,
			baseTypeDefinition: baseTypeDefinition,
			facets: facets,
			fundamentalFacets: Set(derivedFacets).fundamental,
			variety: .union,
			memberTypeDefinitions: memberTypeDefinitions
		)
	}

	override func makeRawValue<StringType: StringProtocol>(
		_ representation: StringType
	) throws -> XSDValue {
		for member in memberTypeDefinitions! {
			if let result = try? member.makeValue(representation) {
				return result
			}
		}
		throw XSD.ValidationRuleError.datatypeValid
	}

}
