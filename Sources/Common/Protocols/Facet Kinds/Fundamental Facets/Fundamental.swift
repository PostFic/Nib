public protocol Fundamental {

	init(
		baseTypeDefinition: XSDSimpleTypeDefinition,
		facets: XSDConstrainingFacets,
		primitiveTypeDefinition: XSDSimpleTypeDefinition?,
		itemTypeDefinition: XSDSimpleTypeDefinition?,
		memberTypeDefinitions: [XSDSimpleTypeDefinition]?
	) throws

}
