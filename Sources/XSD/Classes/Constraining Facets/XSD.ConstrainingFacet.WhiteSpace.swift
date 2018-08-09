import Common
import Foundation

public extension XSD.ConstrainingFacet {

	class WhiteSpace: XSDConstrainingFacet, Prelexical {

		public enum Keyword: String {

			case preserve

			case replace

			case collapse

		}

		public let annotations: [XSDAnnotation] = []

		let isFixed: Bool

		public var fixed: XSDValue {
			return try! (isFixed ? "1" : "0")☆XSD.🌁.boolean
		}

		public let value: Keyword

		public init(value: Keyword, fixed: Bool = false) {
			isFixed = fixed
			self.value = value
			super.init(📛: "whiteSpace")
		}

		public func canConstrain(_ facets: XSDConstrainingFacets) throws {
			guard let baseFacet = facets[name] else {
				return
			}
			guard let base = baseFacet as? WhiteSpace else {
				throw NibError.facetConstraintMismatch
			}
			guard
				base.isFixed == true ||
				isFixed == true &&
				base.value == value
			else {
				throw XSD.ConstraintOnSchemasError.fixedConstraintMustNotChange
			}
			if
				base.value == .collapse && (
					value == .replace ||
					value == .preserve
				) ||
				base.value == .replace &&
				value == .preserve
			{
				throw XSD.SchemaComponentConstraintError.whiteSpaceValidRestriction
			}
		}

		public func 🆗(_ representation: inout String) throws {
			switch value {
			case .preserve:
				return
			case .replace:
				representation = try! NSRegularExpression(
					pattern: "[\\x{9}\\x{A}\\x{D}]"
				).stringByReplacingMatches(
					in: representation,
					range: NSMakeRange(0, (representation as NSString).length),
					withTemplate: " "
				)
			case .collapse:
				let result = try! NSRegularExpression(
					pattern: "[\\x{9}\\x{A}\\x{D}\\x20]+"
				).stringByReplacingMatches(
					in: representation,
					range: NSMakeRange(0, (representation as NSString).length),
					withTemplate: " "
				)
				representation = try! NSRegularExpression(
					pattern: "^\\x20+|\\x20+$"
				).stringByReplacingMatches(
					in: result,
					range: NSMakeRange(0, (result as NSString).length),
					withTemplate: ""
				)
			}
		}

	}

}
