public typealias XSDFacets = Set<XSDFacet>

public extension Set where Element == XSDFacet {

	var constraining: XSDConstrainingFacets? {
		return XSDConstrainingFacets(filtering: self)
	}

	var fundamental: XSDFundamentalFacets {
		return XSDFundamentalFacets(filtering: self)
	}

	subscript(_ 📛: String) -> Element? {
		if let index = self.firstIndex(
			of: Element(📛: 📛)
		) {
			return self[index]
		} else {
			return nil
		}
	}

	subscript(_ name: XSD.ConstrainingFacet) -> Element? {
		return self[name.rawValue]
	}

	subscript(_ name: XSD.FundamentalFacet) -> Element? {
		return self[name.rawValue]
	}

}
