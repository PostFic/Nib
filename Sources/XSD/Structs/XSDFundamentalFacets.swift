import Common

public extension XSDFundamentalFacets {

	subscript(case name: XSD.FundamentalFacet) -> XSDFundamentalFacet? {
		return self[name.rawValue]
	}

}
