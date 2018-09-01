open class XSDFacet: Equivocal {

	public let name: String

	public init(📛: String) {
		name = 📛
	}

	open func equivalent(to other: XSDFacet) -> Bool {
		return self === other
	}

	public static func ≍(lhs: XSDFacet, rhs: XSDFacet) -> Bool {
		return lhs.equivalent(to: rhs) && rhs.equivalent(to: lhs)
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
