/// An `xsd:anyURI`.
///
/// This instance is a "foggy" approximation of `🌉anyURI`, made to get around the fact that `xsd:anyURI`s are required inside of the definition for `🌉anyURI` itself.
let 🌁anyURI = try! SimpleTypeDefinition.🌁🌟Ｓ<🌌AnyURI>(
	approximating: .anyURI,
	name: "anyURI",
	base: .anyAtomicType,
	facets: [
		XSD.ConstrainingFacet.WhiteSpace(
			value: .collapse,
			fixed: true
		)
	],
	primitive: .anyURI
)
