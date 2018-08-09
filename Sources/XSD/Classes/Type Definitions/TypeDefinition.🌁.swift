import Common

extension TypeDefinition {

	/// A "foggy" XSD Type Definition.
	///
	/// This is used as the base type which our "foggy" `SimpleTypeDefinition` class inherits from.
	/// It approximates the behaviours of `TypeDefinition` for purposes of validation but is otherwise lacking in many respects.
	/// Instances of this class are used in places where builtin types are needed in order to avoid recursive type definition.
	class 🌁: XSDTypeDefinition {

		/// `annotations` is not supported and will always return `[]`.
		var annotations: [XSDAnnotation] {
			return []
		}

		private let nameStr: String

		/// The type's name.
		var name: XSDValue? {
			return try! nameStr☆XSD.🌁.NCName
		}

		/// The type's target namespace.
		var targetNamespace: XSDValue? {
			return try! xsdTargetNamespace☆XSD.🌁.anyURI
		}

		/// Prevents XSD constructions in the given ways.
		let `final`: Set<XSDConstructionMethod> = []

		/// For unnamed datatypes, parent datatype in relation to which the type was declared.
		let context: XSDTypeDefinition? = nil

		/// Creates a new datatype.
		init(_ name: String) {
			nameStr = name
		}

	}

}
