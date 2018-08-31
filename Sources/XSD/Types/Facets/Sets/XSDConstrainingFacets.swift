import Common

public extension XSDConstrainingFacets {

	subscript(_ name: XSD.ConstrainingFacet) -> XSDConstrainingFacet? {
		return self[name.rawValue]
	}

}
