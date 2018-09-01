import Foundation

class 🌌String: 🌌Value, CustomStringConvertible {

	let description: String

	override var string: String? {
		return description
	}

	/// Creates a new instance from the given `representation`.
	required init(_ representation: String) throws {
		guard
			try! NSRegularExpression(
				pattern: "[^\\x{1}-\\x{D7FF}\\x{E000}-\\x{FFFD}\\x{10FFFF}]"
			).firstMatch(
				in: representation,
				range: NSMakeRange(0, representation.count)
			) == nil
		else {
			throw XSD.ValidationRuleError.datatypeValid
		}
		description = representation
		super.init()
	}

	override func equal(to other: XSDAtomicValue) -> Bool {
		return identical(to: other)
	}

	override func identical(to other: XSDAtomicValue) -> Bool {
		if let otherDescription = (other as? 🌌String)?.description {
			return description == otherDescription
		} else {
			return false
		}
	}

}
