public struct XSDFundamentalFacets: Hashable {

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

	public init<Facet: XSDFundamentalFacet>(
		_ facets: Set<Facet>
	) {
		contents = []
		define(facets: facets)
	}

	private init(with contents: Set<XSDFacet>) {
		self.contents = contents
	}

	public subscript(_ 📛: String) -> XSDFundamentalFacet? {
		if let index = contents.firstIndex(
			of: XSDFacet(📛: 📛)
		) {
			return (contents[index] as! XSDFundamentalFacet)
		} else {
			return nil
		}
	}

	public mutating func define(facet: XSDFundamentalFacet) {
		contents.update(with: facet as XSDFacet)
	}

	public mutating func define<Facets: Collection>(
		facets: Facets
	) where Facets.Element: XSDFundamentalFacet {
		for facet in facets {
			define(facet: facet)
		}
	}

	public func defining(facet: XSDFundamentalFacet) -> XSDFundamentalFacets {
		var result = XSDFundamentalFacets.init(with: contents)
		result.define(facet: facet)
		return result
	}

	public func defining<Facets: Collection>(
		facets: Facets
	) -> XSDFundamentalFacets where Facets.Element: XSDFundamentalFacet {
		var result = XSDFundamentalFacets.init(with: contents)
		for facet in facets {
			result.define(facet: facet)
		}
		return result
	}

	public mutating func reserveCapacity(_ cap: Int) {
		contents.reserveCapacity(cap)
	}

}

extension XSDFundamentalFacets: Collection {

	public typealias Element = XSDFundamentalFacet

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

extension XSDFundamentalFacets: ExpressibleByArrayLiteral {

	public init(arrayLiteral facets: XSDFundamentalFacet...) {
		self.init(minimumCapacity: facets.count)
		for facet in facets {
			define(facet: facet)
		}
	}

}
