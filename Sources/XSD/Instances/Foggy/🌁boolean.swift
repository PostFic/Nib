/// An `xsd:boolean`.
///
/// This instance is a "foggy" approximation of `🌉boolean`, made to get around the fact that `xsd:anyURI`s are required inside of the definition for `🌉boolean` itself.=
let 🌁boolean = try! SimpleTypeDefinition.🌁🌟Ｓ<🌌Boolean>(
	approximating: .boolean,
	name: "boolean",
	base: .boolean,
	facets: [
		XSD.ConstrainingFacet.WhiteSpace(
			value: .collapse,
			fixed: true
		)
	],
	primitive: .boolean
)
