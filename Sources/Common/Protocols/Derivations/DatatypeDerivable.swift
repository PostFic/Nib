public protocol DatatypeDerivable {

	init(
		baseTypeDefinition: XSDSimpleTypeDefinition,
		facets: XSDConstrainingFacets,
		primitiveTypeDefinition: XSDSimpleTypeDefinition?,
		itemTypeDefinition: XSDSimpleTypeDefinition?,
		memberTypeDefinitions: [XSDSimpleTypeDefinition]?
	) throws

}
