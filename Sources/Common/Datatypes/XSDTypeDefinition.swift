public protocol XSDTypeDefinition: AnyObject {

	/// `annotations` is not supported by Nib.
	var annotations: [XSDAnnotation] { get }

	/// The type's name.
	var name: XSDValue? { get }

	/// The type's target namespace.
	var targetNamespace: XSDValue? { get }

	/// Prevents XSD derivations in the given ways.
	var `final`: Set<XSDConstructionMethod> { get }

	/// For unnamed datatypes, parent datatype in relation to which the type was declared.
	var context: XSDTypeDefinition? { get }

}
