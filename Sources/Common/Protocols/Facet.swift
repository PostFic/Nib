public protocol Facet: Hashable {

	var name: String { get }

	var value: Any? { get }

}

public extension Facet {

	static func ==(lhs: Self, rhs: Self) -> Bool {
		return lhs.name == rhs.name
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(name)
	}

}
