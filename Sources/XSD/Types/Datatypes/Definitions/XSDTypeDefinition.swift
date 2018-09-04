/// The intersection of the type definitions for simple and complex datatypes.
open class XSDTypeDefinition: XSDAnnotated {

	public enum ConstructionMethod: String {

		/// Facet-based restriction.
		case restriction

		/// Complex type extension.
		case `extension`

		/// Construction by list.
		case list

		/// Construction by union.
		case union

	}
	/// The type's name.
	public let name: XSDValue!

	/// The type's target namespace.
	public let targetNamespace: XSDValue?

	/// Prevents XSD constructions in the given ways.
	public let `final`: Set<ConstructionMethod>

	/// For unnamed datatypes, parent datatype in relation to which the type was declared.
	public let context: XSDTypeDefinition? = nil

	/// Creates a new datatype.
	init(
		name: XSDValue,
		targetNamespace: XSDValue? = nil,
		final: Set<ConstructionMethod> = []
	) {
		self.name = name
		self.targetNamespace = targetNamespace
		self.final = `final`
	}

	public init(
		name: String,
		targetNamespace: String? = nil,
		final: Set<ConstructionMethod> = []
	) throws {
		self.name = try name☆XSD.NCName
		self.targetNamespace = try targetNamespace?☆XSD.anyURI
		self.final = `final`
	}

	/// Creates `xsd:anyType`.
	convenience init() {
		self.init(
			name: [try! 🌌String("anyType")],
			targetNamespace: [try! 🌌AnyURI(XSD.targetNamespace)]
		)
	}

}
