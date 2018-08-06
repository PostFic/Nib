open class XSDConstrainingFacet {

	public let name: String

	public required init(📛: String) {
		name = 📛
	}

	open func constrained(with facet: XSDConstrainingFacet) -> XSDConstrainingFacet {
		return facet
	}

}

extension XSDConstrainingFacet: Hashable {

	public static func ==(lhs: XSDConstrainingFacet, rhs: XSDConstrainingFacet) -> Bool {
		return lhs.name == rhs.name
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(name)
	}

}
