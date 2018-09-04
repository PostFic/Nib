import Foundation

class 🌌AnyURI: 🌌Value, CustomStringConvertible {

	let description: String

	override var string: String? {
		return description
	}

	/// Creates a new instance from the given `representation`..
	required init<StringType: StringProtocol>(
		_ representation: StringType
	) throws {
		description = String(representation)
		guard
			try! NSRegularExpression(
				pattern: "[^\\x{1}-\\x{D7FF}\\x{E000}-\\x{FFFD}\\x{10FFFF}]"
			).firstMatch(
				in: description,
				range: NSMakeRange(0, description.count)
			) == nil
		else {
			throw XSD.ValidationRuleError.datatypeValid
		}
		super.init()
	}

	override func equal(to other: XSDAtomicValue) -> Bool {
		return identical(to: other)
	}

	override func identical(to other: XSDAtomicValue) -> Bool {
		if let otherDescription = (other as? 🌌AnyURI)?.description {
			return description == otherDescription
		} else {
			return false
		}
	}

}
