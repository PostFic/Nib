public protocol DatatypeDerivable {

	init(
		baseTypeDefinition: XSDSimpleTypeDefinition,
		facets: XSDConstrainingFacets,
		primitiveTypeDefinition: XSDSimpleTypeDefinition
	) throws

	init(
		baseTypeDefinition: XSDSimpleTypeDefinition,
		facets: XSDConstrainingFacets,
		itemTypeDefinition: XSDSimpleTypeDefinition
	) throws

	init(
		baseTypeDefinition: XSDSimpleTypeDefinition,
		facets: XSDConstrainingFacets,
		memberTypeDefinitions: [XSDSimpleTypeDefinition]
	) throws

}
