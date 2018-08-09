import Common

/// An `xsd:NCName`.
///
/// This instance is a "foggy" approximation of `🌉NCName`, made to get around the fact that `xsd:NCName`s are required inside of the definition for `🌉NCName` itself.
let 🌁NCName = try! SimpleTypeDefinition.🌁🌟Ｓ<🌌String>(
	approximating: .NCName,
	name: "NCName",
	base: .Name,
	facets: [
		XSD.ConstrainingFacet.Pattern(
			value: [
				XSDRegularExpression("\\i\\c*"),
				XSDRegularExpression("[\\i-[:]][\\c-[:]]*")
			]
		),
		XSD.ConstrainingFacet.WhiteSpace(
			value: .collapse
		)
	],
	primitive: .string
)
