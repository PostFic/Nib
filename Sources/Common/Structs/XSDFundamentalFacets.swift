public typealias XSDFundamentalFacets = Set<XSDFundamentalFacet>

extension Set where Element == XSDFundamentalFacet {

	subscript(name: String) -> Element? {
		if let index = firstIndex(
			of: XSDFundamentalFacet(📛: name)
		) {
			return self[index]
		} else {
			return nil
		}
	}

}
