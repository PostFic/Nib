public typealias XSDConstrainingFacets = Set<XSDConstrainingFacet>

extension Set where Element == XSDConstrainingFacet {

	subscript(name: String) -> Element? {
		if let index = firstIndex(
			of: XSDConstrainingFacet(📛: name)
		) {
			return self[index]
		} else {
			return nil
		}
	}

}
