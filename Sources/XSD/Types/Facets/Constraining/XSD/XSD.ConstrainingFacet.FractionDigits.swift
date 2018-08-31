import Common

public extension XSD.ConstrainingFacet {

	final class FractionDigits: XSDFixedValuebasedFacet, XSDAnnotated {

		public let value: XSDValue

		public init(value: UInt, fixed: Bool = false) {
			self.value = [🌌Decimal(value)!]
			super.init(📛: "fractionDigits", fixed: fixed)
		}

		public override func canConstrain(_ facets: XSDConstrainingFacets) throws {
			try super.canConstrain(facets)
			if
				let totalDigits = facets[.totalDigits] as? TotalDigits,
				value ≻ totalDigits.value
			{
				throw XSD.SchemaComponentConstraintError.fractionDigitsLessThanOrEqualToTotalDigits
			}
			if
				let fractionDigits = facets[.fractionDigits] as? FractionDigits,
				value ≻ fractionDigits.value
			{
				throw XSD.SchemaComponentConstraintError.fractionDigitsValidRestriction
			}
		}

		public override func equivalent(to other: XSDFacet) -> Bool {
			guard let otherValue = (other as? FractionDigits)?.value else {
				return false
			}
			return value ≍ otherValue
		}

		public func 🆗(_ value: XSDValue, as type: XSDDatatype) throws {
			guard
				let decimal = value.decimal,
				-decimal.exponent <= self.value.uInt!
			else {
				throw XSD.ValidationRuleError.fractionDigitsValid
			}
		}

	}

}
