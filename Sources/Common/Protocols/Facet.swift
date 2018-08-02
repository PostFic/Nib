public protocol Facet: Hashable {

	var name: String { get }

}

public extension Facet {

	func hash(into hasher: inout Hasher) {
		hasher.combine(name)
	}

	static func ==(lhs: Self, rhs: Self) -> Bool {
		return lhs.name == rhs.name
	}

}
