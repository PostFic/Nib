import Common

public extension XSD.ConstrainingFacet {

	final class MaxExclusive: XSDFixedValuebasedFacet, XSDAnnotated {

		public let value: XSDValue

		public init(value: XSDValue, fixed: Bool = false) {
			self.value = value
			super.init(📛: "maxExclusive", fixed: fixed)
		}

		public override func canConstrain(_ facets: XSDConstrainingFacets) throws {
			try super.canConstrain(facets)
			if
				let minInclusive = facets[.minInclusive] as? MinInclusive,
				value ≺ minInclusive.value
			{
				throw XSD.SchemaComponentConstraintError.maxExclusiveValidRestriction
			}
			if
				let maxInclusive = facets[.maxInclusive] as? MaxInclusive,
				value ≻ maxInclusive.value
			{
				throw XSD.SchemaComponentConstraintError.maxExclusiveValidRestriction
			}
			if
				let minExclusive = facets[.minExclusive] as? MinExclusive,
				value ≼ minExclusive.value
			{
				throw XSD.SchemaComponentConstraintError.maxExclusiveValidRestriction
			}
			if
				let maxExclusive = facets[.maxExclusive] as? MaxExclusive,
				value ≽ maxExclusive.value
			{
				throw XSD.SchemaComponentConstraintError.maxExclusiveValidRestriction
			}
		}

		public override func equivalent(to other: XSDFacet) -> Bool {
			guard let otherValue = (other as? MaxExclusive)?.value else {
				return false
			}
			return value ≍ otherValue
		}

		public func 🆗(_ value: XSDValue, as type: XSDDatatype) throws {
			if
				let ordered = (
					type.definition.fundamentalFacets[.ordered] as? XSD.FundamentalFacet.Ordered
				)?.value,
				ordered != .false
			{
				guard value ≺ self.value else {
					throw XSD.ValidationRuleError.maxExclusiveValid
				}
			}
		}

	}

}
