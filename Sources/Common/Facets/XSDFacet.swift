open class XSDFacet {

	public let name: String

	public init(📛: String) {
		name = 📛
	}

}

extension XSDFacet: Hashable {

	public static func ==(lhs: XSDFacet, rhs: XSDFacet) -> Bool {
		return lhs.name == rhs.name
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(name)
	}

}
