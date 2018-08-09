import Common

public extension XSD.ConstrainingFacet {

	class Pattern: XSDConstrainingFacet, Lexical {

		public let annotations: [XSDAnnotation] = []

		public let value: Set<XSDRegularExpression>

		public init(value: Set<XSDRegularExpression>) {
			self.value = value
			super.init(📛: "pattern")
		}

		public func canConstrain(_ facets: XSDConstrainingFacets) throws {
			guard let baseFacet = facets[name] else {
				return
			}
			guard let base = baseFacet as? Pattern else {
				throw NibError.facetConstraintMismatch
			}
			guard base.value.isSubset(of: value) else {
				throw XSD.SchemaComponentConstraintError.validRestrictionOfPattern
			}
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
