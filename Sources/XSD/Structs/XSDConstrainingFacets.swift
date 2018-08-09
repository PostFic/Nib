import Common

public extension XSDConstrainingFacets {

	subscript(case name: XSD.ConstrainingFacet) -> XSDConstrainingFacet? {
		return self[name.rawValue]
	}

}
