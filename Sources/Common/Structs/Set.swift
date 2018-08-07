extension Set where Element == XSDFacet {

	subscript(name: String) -> Element? {
		if let index = firstIndex(
			of: XSDFacet(📛: name)
		) {
			return self[index]
		} else {
			return nil
		}
	}

}
