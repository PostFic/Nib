import Common

open class XSDFixedConstrainingFacet: XSDConstrainingFacet {

	public let fixed: XSDValue

	public init(📛: String, fixed: Bool) {
		self.fixed = [🌌Boolean(fixed)]
		super.init(📛: 📛)
	}

	open override func canConstrain(_ facets: XSDConstrainingFacets) throws {
		try super.canConstrain(facets)
		if
			let base = facets[name] as? XSDFixedConstrainingFacet,
			base.fixed.bool!,
			!fixed.bool! || base ≭ self
		{
			throw XSD.ConstraintOnSchemasError.fixedConstraintMustNotChange
		}
	}

}
