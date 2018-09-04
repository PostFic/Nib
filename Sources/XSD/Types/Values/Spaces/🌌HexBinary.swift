import Foundation

class 🌌HexBinary: 🌌Value, CustomStringConvertible {

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
		description = String(representation)
		guard
			try! XSDRegularExpression("([0-9a-fA-F]{2})*").test(description)
		else {
			throw XSD.ValidationRuleError.datatypeValid
		}
		var value = Data(capacity: description.count / 2)
		var rest = Substring(description)
		while rest.count > 0 {
			let byteHex = rest.prefix(2)
			guard let byte = UInt8(byteHex, radix: 16) else {
				throw XSD.ValidationRuleError.datatypeValid
			}
			value.append(byte)
			rest = rest.suffix(from: byteHex.endIndex)
		}
		self.value = value
		super.init()
	}

	override func equal(to other: XSDAtomicValue) -> Bool {
		return identical(to: other)
	}

	override func identical(to other: XSDAtomicValue) -> Bool {
		if let otherValue = (other as? 🌌HexBinary)?.value {
			return value == otherValue
		} else {
			return false
		}
	}

}
