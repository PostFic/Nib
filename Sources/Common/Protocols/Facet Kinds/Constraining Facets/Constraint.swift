public protocol Constraint {

	func constrained(with facet: XSDConstrainingFacet) throws -> XSDConstrainingFacet

}
