public struct XSDFundamentalFacets: Hashable {

	private var contents: XSDFacets

	public var count: Int {
		return contents.count
	}

	public var isEmpty: Bool {
		return contents.isEmpty
	}

	public var members: XSDFacets {
		return contents
	}

	public init() {
		contents = []
	}

	public init(minimumCapacity: Int) {
		contents = XSDFacets(minimumCapacity: minimumCapacity)
	}

	init(filtering facets: XSDFacets) {
		let filtered = facets.filter { $0 is XSDFundamentalFacet }
		self.init(minimumCapacity: filtered.count)
		for facet in filtered {
			define(facet: facet as! XSDFundamentalFacet)
		}
	}

	public init<Facets: Collection>(
		_ facets: Facets
	) where Facets.Element: XSDFundamentalFacet {
		contents = []
		define(facets: facets)
	}

	private init(with contents: XSDFacets) {
		self.contents = contents
	}

	public subscript(_ 📛: String) -> XSDFundamentalFacet? {
		return contents[📛] as! XSDFundamentalFacet?
	}

	public subscript(_ name: XSD.FundamentalFacet) -> XSDFundamentalFacet? {
		return contents[name] as! XSDFundamentalFacet?
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

	public typealias Index = XSDFacets.Index

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
