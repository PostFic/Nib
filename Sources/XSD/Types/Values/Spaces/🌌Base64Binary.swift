import Foundation

class 🌌Base64Binary: 🌌Value, CustomStringConvertible {

	override var data: Data? {
		return value
	}

	let description: String

	let value: Data

	override var string: String? {
		return description
	}

	/// Creates a new instance from the given `representation`.
	required init<StringType: StringProtocol>(
		_ representation: StringType
	) throws {
		let stringRepresentation = String(representation)
		guard
			try! XSDRegularExpression(
				"((([A-Za-z0-9+/] ?){4})*(([A-Za-z0-9+/] ?){3}[A-Za-z0-9+/]|([A-Za-z0-9+/] ?){2}[AEIMQUYcgkosw048] ?=|[A-Za-z0-9+/] ?[AQgw] ?= ?=))?"
			).test(stringRepresentation)
		else {
			throw XSD.ValidationRuleError.datatypeValid
		}
		description = stringRepresentation.replacingOccurrences(of: " ", with: "")
		guard let value = Data(base64Encoded: description) else {
			throw XSD.ValidationRuleError.datatypeValid
		}
		self.value = value
		super.init()
	}

	override func equal(to other: XSDAtomicValue) -> Bool {
		return identical(to: other)
	}

	override func identical(to other: XSDAtomicValue) -> Bool {
		if let otherValue = (other as? 🌌Base64Binary)?.value {
			return value == otherValue
		} else {
			return false
		}
	}

}
