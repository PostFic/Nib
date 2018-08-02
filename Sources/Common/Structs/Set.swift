extension Set where Element: Facet {

	subscript(facet: Element) -> Element? {
		if let index = firstIndex(of: facet) {
			return self[index]
		} else {
			return nil
		}
	}

}
