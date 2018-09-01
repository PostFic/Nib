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

	func makeRawValue(_ representation: String) throws -> XSDValue {
		return [try 🌌Value(representation)]
	}

	public func makeValue(_ representation: String) throws -> XSDValue {
		var normalizedRepresentation = representation
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

}
