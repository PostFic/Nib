final class XSDListTypeDefinition: XSDSimpleTypeDefinition {

	/// Creates a list type definition.
	init(
		name: XSDValue,
		targetNamespace: XSDValue? = nil,
		`final`: Set<ConstructionMethod> = [],
		baseTypeDefinition: XSDSimpleTypeDefinition = 🌉anySimpleType,
		facets: XSDConstrainingFacets = [],
		itemTypeDefinition: XSDSimpleTypeDefinition
	) {
		let derivedFacets = baseTypeDefinition.fundamentalFacets.members.compactMap {
			try? type(of: $0 as! XSDFundamentalFacet).init(
				baseTypeDefinition: baseTypeDefinition,
				facets: facets,
				itemTypeDefinition: itemTypeDefinition
			)
		}
		super.init(
			name: name,
			targetNamespace: targetNamespace,
			final: `final`,
			baseTypeDefinition: baseTypeDefinition,
			facets: facets,
			fundamentalFacets: Set(derivedFacets).fundamental,
			variety: .list,
			itemTypeDefinition: itemTypeDefinition
		)
	}

	convenience init(
		_ name: String,
		_ itemTypeDefinition: XSDSimpleTypeDefinition,
		_ facets: XSDConstrainingFacets
	) {
		self.init(
			name: [try! 🌌String(name)],
			targetNamespace: [try! 🌌AnyURI(XSD.targetNamespace)],
			facets: facets,
			itemTypeDefinition: itemTypeDefinition
		)
	}

	override func makeRawValue<StringType: StringProtocol>(
		_ representation: StringType
	) throws -> XSDValue {
		let representations = representation.split(separator: " ")
		var result = XSDValue()
		result.reserveCapacity(representations.count)
		return try representations.reduce(into: result) { $0 += try $1☆itemTypeDefinition! }
	}

}
