import Common

public extension XSDFundamentalFacets {

	subscript(_ name: XSD.FundamentalFacet) -> XSDFundamentalFacet? {
		return self[name.rawValue]
	}

}
