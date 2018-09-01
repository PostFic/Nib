public extension XSD.ConstrainingFacet {

	final class Pattern: XSDLexicalFacet, XSDAnnotated {

		public let value: Set<XSDRegularExpression>

		public init(value: Set<XSDRegularExpression>) {
			self.value = value
			super.init(📛: "pattern")
		}

		public override func canConstrain(_ facets: XSDConstrainingFacets) throws {
			try super.canConstrain(facets)
			if
				let pattern = facets[.pattern] as? Pattern,
				!pattern.value.isSubset(of: value)
			{
				throw XSD.SchemaComponentConstraintError.validRestrictionOfPattern
			}
		}

		public override func equivalent(to other: XSDFacet) -> Bool {
			guard let otherValue = (other as? Pattern)?.value else {
				return false
			}
			return value == otherValue
		}

		public func 🆗(_ representation: String) throws {
			for pattern in value {
				guard pattern.test(representation) else {
					throw XSD.ValidationRuleError.patternValid
				}
			}
		}

	}

}
