import Common
import Foundation

public extension XSD.ConstrainingFacet {

	final class WhiteSpace: XSDFixedPrelexicalFacet, XSDAnnotated {

		public enum Keyword: String {

			case preserve

			case replace

			case collapse

		}

		public let value: Keyword

		public init(value: Keyword, fixed: Bool = false) {
			self.value = value
			super.init(📛: "whiteSpace", fixed: fixed)
		}

		public override func canConstrain(_ facets: XSDConstrainingFacets) throws {
			try super.canConstrain(facets)
			if
				let whiteSpace = facets[.whiteSpace] as? WhiteSpace,
				whiteSpace.value == .collapse && (
					value == .replace ||
					value == .preserve
				) ||
				whiteSpace.value == .replace && value == .preserve
			{
				throw XSD.SchemaComponentConstraintError.whiteSpaceValidRestriction
			}
		}

		public override func equivalent(to other: XSDFacet) -> Bool {
			guard let otherValue = (other as? WhiteSpace)?.value else {
				return false
			}
			return value == otherValue
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
