/// Instances represent the XSD datatypes themselves, *not* typed literals.
public class XSDSimpleTypeDefinition:
	XSDTypeDefinition,
	XSDDatatype
{

	/// XSD varieties for simple types.
	public enum Variety: String {

		/// Atomic type variety.
		case atomic

		/// List type variety.
		case list

		/// Union type variety.
		case union

	}

	/// The base type which this type was derived from.
	public let baseTypeDefinition: XSDTypeDefinition

	/// The constraining facets for the type.
	public let facets: XSDConstrainingFacets

	/// The fundamental facets for the type.
	public let fundamentalFacets: XSDFundamentalFacets

	/// The type variety.
	public let variety: Variety?

	/// Whether the type is primitive.
	///
	/// If `true`, then `primitiveTypeDefinition` will return `self`.
	let isPrimitive: Bool

	/// The primitive of this type, if different than `self`.
	let ？primitiveTypeDefinition: XSDSimpleTypeDefinition?

	/// The primitive type for an atomic type.
	///
	/// Will return `self` if the type is itself primitive.
	public final var primitiveTypeDefinition: XSDSimpleTypeDefinition? {
		if isPrimitive {
			return self
		}
		return ？primitiveTypeDefinition
	}

	/// The item type for a list.
	public let itemTypeDefinition: XSDSimpleTypeDefinition?

	/// The member types for a union.
	public let memberTypeDefinitions: [XSDSimpleTypeDefinition]?

	public final var definition: XSDSimpleTypeDefinition {
		return self
	}

	/// Creates `xsd:anySimpleType`.
	init() {
		baseTypeDefinition = 🌉anyType
		facets = []
		fundamentalFacets = []
		variety = nil
		isPrimitive = false
		？primitiveTypeDefinition = nil
		itemTypeDefinition = nil
		memberTypeDefinitions = nil
		super.init(
			name: [try! 🌌String("anySimpleType")],
			targetNamespace: [try! 🌌AnyURI(XSD.targetNamespace)]
		)
	}

	/// Creates a new datatype.
	init(
		name: XSDValue,
		targetNamespace: XSDValue? = nil,
		final: Set<ConstructionMethod> = [],
		baseTypeDefinition: XSDSimpleTypeDefinition,
		facets: XSDConstrainingFacets = [],
		fundamentalFacets: XSDFundamentalFacets = [],
		variety: Variety,
		isPrimitive: Bool = false,
		primitiveTypeDefinition: XSDSimpleTypeDefinition? = nil,
		itemTypeDefinition: XSDSimpleTypeDefinition? = nil,
		memberTypeDefinitions: [XSDSimpleTypeDefinition]? = nil
	) {
		self.baseTypeDefinition = baseTypeDefinition
		self.facets = facets
		self.fundamentalFacets = fundamentalFacets
		self.variety = variety
		self.isPrimitive = isPrimitive
		？primitiveTypeDefinition = primitiveTypeDefinition
		self.itemTypeDefinition = itemTypeDefinition
		self.memberTypeDefinitions = memberTypeDefinitions
		super.init(
			name: name,
			targetNamespace: targetNamespace,
			final: `final`
		)
	}

	func makeRawValue<StringType: StringProtocol>(
		_ representation: StringType
	) throws -> XSDValue {
		return [try 🌌Value(representation)]
	}

	public func makeValue<StringType: StringProtocol>(
		_ representation: StringType
	) throws -> XSDValue {
		var normalizedRepresentation = String(representation)
		for facet in facets.prelexical {
			try (facet as! XSDPrelexicalFacet).🆗(&normalizedRepresentation)
		}
		for facet in facets.lexical {
			try (facet as! XSDLexicalFacet).🆗(normalizedRepresentation)
		}
		let value = try makeRawValue(normalizedRepresentation)
		for facet in facets.valuebased {
			try (facet as! XSDValuebasedFacet).🆗(value, as: self)
		}
		return value
	}

	public static func makeList(
		targetNamespace: String? = nil,
		final: Set<ConstructionMethod> = [],
		name: String,
		itemType: XSDDatatype
	) throws -> XSDSimpleTypeDefinition {
		guard
			itemType.definition !== 🌉anySimpleType,
			itemType.definition !== 🌉anyAtomicType
		else {
			throw XSD.ConstraintOnSchemasError.listItemMustNotBeSpecial
		}
		return XSDListTypeDefinition(
			name: try name☆XSD.NCName,
			targetNamespace: try targetNamespace?☆XSD.anyURI,
			final: `final`,
			itemTypeDefinition: itemType.definition
		)
	}

	public static func makePrimitive<ValueSpace: XSDAtomicValue>(
		name: String,
		targetNamespace: String? = XSD.targetNamespace,
		facets: XSDConstrainingFacets,
		fundamentalFacets: XSDFundamentalFacets = [],
		valueSpace: ValueSpace.Type
	) throws -> XSDSimpleTypeDefinition {
		guard facets[.whiteSpace] != nil else {
			throw XSD.ConstraintOnSchemasError.primitiveMustHaveWhiteSpaceFacet
		}
		return XSDAtomicTypeDefinition<ValueSpace>(
			name: try name☆XSD.NCName,
			targetNamespace: try targetNamespace?☆XSD.anyURI,
			baseTypeDefinition: 🌉anyAtomicType,
			facets: facets,
			fundamentalFacets: fundamentalFacets,
			isPrimitive: true
		)
	}

	public static func makeRestriction(
		targetNamespace: String? = nil,
		final: Set<ConstructionMethod> = [],
		name: String,
		base: XSDDatatype,
		_ additionalFacets: XSDConstrainingFacet...
	) throws -> XSDSimpleTypeDefinition {
		guard
			base.definition !== 🌉anySimpleType,
			base.definition !== 🌉anyAtomicType
		else {
			throw XSD.ConstraintOnSchemasError.ordinaryBaseTypeMustBeOrdinary
		}
		let facets = try base.definition.facets.constrained(with: additionalFacets)
		switch base.definition.variety! {
		case .atomic:
			let primitive = base.definition.primitiveTypeDefinition!
			return type(of: base as! XSDAtomicTypeDefinition).init(
				name: try name☆XSD.NCName,
				targetNamespace: try targetNamespace?☆XSD.anyURI,
				final: `final`,
				baseTypeDefinition: base.definition,
				facets: facets,
				primitiveTypeDefinition: primitive
			)
		case .list:
			let item = base.definition.itemTypeDefinition!
			return XSDListTypeDefinition(
				name: try name☆XSD.NCName,
				targetNamespace: try targetNamespace?☆XSD.anyURI,
				final: `final`,
				baseTypeDefinition: base.definition,
				facets: facets,
				itemTypeDefinition: item
			)
		case .union:
			let members = base.definition.memberTypeDefinitions!
			return XSDUnionTypeDefinition(
				name: try name☆XSD.NCName,
				targetNamespace: try targetNamespace?☆XSD.anyURI,
				final: `final`,
				baseTypeDefinition: base.definition,
				facets: facets,
				memberTypeDefinitions: members
			)
		}
	}

	public static func makeUnion(
		targetNamespace: String? = nil,
		final: Set<ConstructionMethod> = [],
		name: String,
		memberTypes: [XSDDatatype]
	) throws -> XSDSimpleTypeDefinition {
		let members = try memberTypes.map { memberType -> XSDSimpleTypeDefinition in
			guard
				memberType.definition !== 🌉anySimpleType,
				memberType.definition !== 🌉anyAtomicType
			else {
				throw XSD.ConstraintOnSchemasError.unionMembersMustNotBeSpecial
			}
			return memberType.definition
		}
		return XSDUnionTypeDefinition(
			name: try name☆XSD.NCName,
			targetNamespace: try targetNamespace?☆XSD.anyURI,
			final: `final`,
			memberTypeDefinitions: members
		)
	}

}
