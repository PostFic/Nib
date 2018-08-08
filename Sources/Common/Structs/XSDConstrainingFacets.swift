public struct XSDConstrainingFacets: Hashable {

	var contents: Set<XSDFacet>

	public var count: Int {
		return contents.count
	}

	public var isEmpty: Bool {
		return contents.isEmpty
	}

	public var members: Set<XSDFacet> {
		return contents
	}

	public init() {
		contents = []
	}

	public init(minimumCapacity: Int) {
		contents = Set<XSDFacet>(minimumCapacity: minimumCapacity)
	}

	public init<Facet: XSDConstrainingFacet>(
		_ facets: Set<Facet>
	) throws {
		contents = []
		try constrain(with: facets)
	}

	private init(with contents: Set<XSDFacet>) {
		self.contents = contents
	}

	public subscript(name: String) -> XSDConstrainingFacet? {
		if let index = contents.firstIndex(
			of: XSDFacet(📛: name)
		) {
			return (contents[index] as! XSDConstrainingFacet)
		} else {
			return nil
		}
	}

	public mutating func constrain(
		with constraint: XSDConstrainingFacet
	) throws {
		try constraint.canConstrain(self)
		contents.update(with: constraint as XSDFacet)
	}

	public mutating func constrain<Facets: Collection>(
		with constraints: Facets
	) throws where Facets.Element: XSDConstrainingFacet {
		for constraint in constraints {
			try constrain(with: constraint)
		}
	}

	public func constrained(
		with constraint: XSDConstrainingFacet
	) throws -> XSDConstrainingFacets {
		var result = XSDConstrainingFacets.init(with: contents)
		try result.constrain(with: constraint)
		return result
	}

	public func constrained<Facets: Collection>(
		with constraints: Facets
	) throws -> XSDConstrainingFacets where Facets.Element: XSDConstrainingFacet {
		var result = XSDConstrainingFacets.init(with: contents)
		for constraint in constraints {
			try result.constrain(with: constraint)
		}
		return result
	}

	public mutating func reserveCapacity(_ cap: Int) {
		contents.reserveCapacity(cap)
	}

}

extension XSDConstrainingFacets: Collection {

	public typealias Element = XSDConstrainingFacet

	public typealias Index = Set<XSDFacet>.Index

	public var endIndex: Index {
		return contents.endIndex
	}

	public var startIndex: Index {
		return contents.startIndex
	}

	public subscript(index: Index) -> Element {
		return contents[index] as! Element
	}

	public func index(after index: Index) -> Index {
		return contents.index(after: index)
	}

}

extension XSDConstrainingFacets: ExpressibleByArrayLiteral {

	public init(arrayLiteral facets: XSDConstrainingFacet...) {
		self.init(minimumCapacity: facets.count)
		for facet in facets {
			try! constrain(with: facet)
		}
	}

}
