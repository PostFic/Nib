public extension XSD.ConstrainingFacet {

	final class TotalDigits: XSDFixedValuebasedFacet, XSDAnnotated {

		public let value: XSDValue

		public init?(value: UInt, fixed: Bool = false) {
			guard value > 0 else {
				return nil
			}
			self.value = [🌌Decimal(value)!]
			super.init(📛: "totalDigits", fixed: fixed)
		}

		public override func canConstrain(_ facets: XSDConstrainingFacets) throws {
			try super.canConstrain(facets)
			if
				let totalDigits = facets[.totalDigits] as? TotalDigits,
				value ≻ totalDigits.value
			{
				throw XSD.SchemaComponentConstraintError.totalDigitsValidRestriction
			}
		}

		public override func equivalent(to other: XSDFacet) -> Bool {
			guard let otherValue = (other as? TotalDigits)?.value else {
				return false
			}
			return value ≍ otherValue
		}

		public func 🆗(_ value: XSDValue, as type: XSDDatatype) throws {
			guard
				let decimal = value.decimal,
				String(describing: decimal.significand).count <= self.value.uInt!
			else {
				throw XSD.ValidationRuleError.fractionDigitsValid
			}
		}

	}

}
