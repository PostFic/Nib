open class XSDConstrainingFacet: XSDFacet {

	override public init(📛: String) {
		super.init(📛: 📛)
	}

	open func canConstrain(_ facets: XSDConstrainingFacets) throws {
		guard let baseFacet = facets[name] else {
			return
		}
		guard type(of: baseFacet) == type(of: self) else {
			throw NibError.facetConstraintMismatch
		}
	}

}
