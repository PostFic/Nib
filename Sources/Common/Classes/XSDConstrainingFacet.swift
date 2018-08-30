open class XSDConstrainingFacet: XSDFacet, Equatable {

	public init(📛: String) {
		super.init(📛)
	}

	open func canConstrain(_ facets: XSDConstrainingFacets) throws {
		guard let baseFacet = facets[name] else {
			return
		}
		guard (baseFacet as? type(of: self)) != nil else {
			throw NibError.facetConstraintMismatch
		}
	}

	open func equals(_ other: XSDConstrainingFacet) -> Bool {
		return self === other
	}

	public static func ==(lhs: XSDConstrainingFacet, rhs: XSDConstrainingFacet) -> Bool {
		return lhs.equals(rhs) && rhs.equals(lhs)
	}

}
