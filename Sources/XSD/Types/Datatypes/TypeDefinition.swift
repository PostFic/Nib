import Common

/// The intersection of the type definitions for simple and complex datatypes.
class TypeDefinition: XSDTypeDefinition, XSDAnnotated {

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
		if var theName = name {
			do {
				try XSD.ConstrainingFacet.WhiteSpace(value: .collapse).🆗(&theName)
				guard try! XSDRegularExpression("[\\i-[:]][\\c-[:]]*").test(theName) else {
					throw XSD.ValidationRuleError.patternValid
				}
				self.name = [try 🌌String(theName)]
			} catch {
				throw XSD.ConstraintOnSchemasError.incorrectType(forProperty: "name")
			}
		} else {
			self.name = nil
		}
		if var theNamespace = targetNamespace {
			do {
				try XSD.ConstrainingFacet.WhiteSpace(value: .collapse).🆗(&theNamespace)
				self.targetNamespace = [try 🌌AnyURI(theNamespace)]
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
