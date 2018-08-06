open class XSDFundamentalFacet {

	public let name: String

	public required init(📛: String) {
		name = 📛
	}

}

extension XSDFundamentalFacet: Hashable {

	public static func ==(lhs: XSDFundamentalFacet, rhs: XSDFundamentalFacet) -> Bool {
		return lhs.name == rhs.name
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(name)
	}

}
