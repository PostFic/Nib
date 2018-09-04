public struct XSDConstrainingFacets: Hashable {

	private var contents: Set<XSDConstrainingFacet>

	public var count: Int {
		return contents.count
	}

	public var isEmpty: Bool {
		return contents.isEmpty
	}

	public var members: XSDFacets {
		return contents
	}

	public var prelexical: XSDConstrainingFacets {
		return XSDConstrainingFacets(with: contents.filter { $0 is XSDPrelexicalFacet })
	}

	public var lexical: XSDConstrainingFacets {
		return XSDConstrainingFacets(with: contents.filter { $0 is XSDLexicalFacet })
	}

	public var valuebased: XSDConstrainingFacets {
		return XSDConstrainingFacets(with: contents.filter { $0 is XSDValuebasedFacet })
	}

	public init() {
		contents = []
	}

	public init(minimumCapacity: Int) {
		contents = Set<XSDConstrainingFacet>(minimumCapacity: minimumCapacity)
	}

	init?(filtering facets: XSDFacets) {
		let filtered = facets.filter { $0 is XSDConstrainingFacet }
		self.init(minimumCapacity: filtered.count)
		do {
			for constraint in filtered {
				try unsafeConstrain(with: constraint as! XSDConstrainingFacet)
			}
			try validate()
		} catch {
			return nil
		}
	}

	public init<Facets: Collection>(
		_ facets: Facets
	) throws where Facets.Element: XSDConstrainingFacet {
		contents = []
		try constrain(with: facets)
	}

	private init(with contents: Set<XSDConstrainingFacet>) {
		self.contents = contents
	}

	public subscript(_ 📛: String) -> XSDConstrainingFacet? {
		if let index = contents.firstIndex(
			of: XSDConstrainingFacet(📛: 📛)
		) {
			return contents[index]
		} else {
			return nil
		}
	}

	public subscript(_ name: XSD.ConstrainingFacet) -> XSDConstrainingFacet? {
		return self[name.rawValue]
	}

	public mutating func constrain(
		with constraint: XSDConstrainingFacet
	) throws {
		try unsafeConstrain(with: constraint)
		try validate()
	}

	public mutating func constrain<Facets: Collection>(
		with constraints: Facets
	) throws where Facets.Element: XSDConstrainingFacet {
		for constraint in constraints {
			try unsafeConstrain(with: constraint)
		}
		try validate()
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
		try result.constrain(with: constraints)
		return result
	}

	public mutating func reserveCapacity(_ cap: Int) {
		contents.reserveCapacity(cap)
	}

	private mutating func unsafeConstrain(
		with constraint: XSDConstrainingFacet
	) throws {
		try constraint.canConstrain(self)
		contents.update(with: constraint)
	}

	private func validate() throws {
		for constraint in self {
			try constraint.canConstrain(self)
		}
	}

}

extension XSDConstrainingFacets: Collection {

	public typealias Element = XSDConstrainingFacet

	public typealias Index = Set<XSDConstrainingFacet>.Index

	public var endIndex: Index {
		return contents.endIndex
	}

	public var startIndex: Index {
		return contents.startIndex
	}

	public subscript(index: Index) -> Element {
		return contents[index]
	}

	public func index(after index: Index) -> Index {
		return contents.index(after: index)
	}

}

extension XSDConstrainingFacets: ExpressibleByArrayLiteral {

	public init(arrayLiteral constraints: XSDConstrainingFacet?...) {
		let theConstraints = constraints.filter { $0 != nil }
		self.init(minimumCapacity: theConstraints.count)
		for constraint in theConstraints {
			try! constrain(with: constraint!)
		}
	}

}
