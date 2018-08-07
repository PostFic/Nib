public protocol XSDSimpleTypeDefinition: XSDDatatype, XSDTypeDefinition {

	/// The base type which this type was derived from.
	var baseTypeDefinition: XSDTypeDefinition { get }

	/// The constraining facets for the type.
	var facets: XSDConstrainingFacets { get }

	/// The fundamental facets for the type.
	var fundamentalFacets: XSDFundamentalFacets { get }

	/// The type variety.
	var variety: XSDSimpleTypeVariety? { get }

	/// The primitive type for an atomic type.
	var primitiveTypeDefinition: XSDSimpleTypeDefinition? { get }

	/// The item type for a list.
	var itemTypeDefinition: XSDSimpleTypeDefinition? { get }

	/// The member types for a union.
	var memberTypeDefinitions: [XSDSimpleTypeDefinition]? { get }

}
