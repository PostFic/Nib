import Common

/// The intersection of the type definitions for simple and complex datatypes.
class TypeDefinition: XSDTypeDefinition {

	/// `annotations` is not supported and will always return `[]`.
	var annotations: [XSDAnnotation] {
		return []
	}

	/// The type's name.
	let name: XSDValue?

	/// The type's target namespace.
	let targetNamespace: XSDValue?

	/// Prevents XSD constructions in the given ways.
	let `final`: Set<XSDConstructionMethod>

	/// For unnamed datatypes, parent datatype in relation to which the type was declared.
	let context: XSDTypeDefinition?

	/// Creates a new datatype.
	init(
		name: String? = nil,
		targetNamespace: String? = nil,
		final: Set<XSDConstructionMethod> = [],
		context: XSDTypeDefinition? = nil
	) throws {
		if let theName = name {
			do {
				self.name = try theName☆XSD.🌁.NCName
			} catch {
				throw XSD.ConstraintOnSchemasError.incorrectType(forProperty: "name")
			}
		} else {
			self.name = nil
		}
		if let theNamespace = targetNamespace {
			do {
				self.targetNamespace = try theNamespace☆XSD.🌁.anyURI
			} catch {
				throw XSD.ConstraintOnSchemasError.incorrectType(forProperty: "targetNamespace")
			}
		} else {
			self.targetNamespace = nil
		}
		self.final = `final`
		self.context = context
		if name == nil && context == nil {
			throw XSD.ConstraintOnSchemasError.contextRequiredIfNameAbsent
		} else if name != nil && context != nil {
			throw XSD.ConstraintOnSchemasError.contextMustBeAbsentWhenName
		}
	}

}
