class 🌌Boolean: 🌌Value, CustomStringConvertible {

	override var bool: Bool? {
		return value
	}

	let description: String

	override var string: String? {
		return description
	}

	let value: Bool

	/// Creates a new instance from the given `representation`.
	required init<StringType: StringProtocol>(
		_ representation: StringType
	) throws {
		switch representation {
		case
			"0",
			"false"
		:
			description = "false"
			value = false
		case
			"1",
			"true"
		:
			description = "true"
			value = true
		default:
			throw XSD.ValidationRuleError.datatypeValid
		}
		super.init()
	}

	init(_ value: Bool) {
		self.description = value ? "true" : "false"
		self.value = value
		super.init()
	}

	override func equal(to other: XSDAtomicValue) -> Bool {
		return identical(to: other)
	}

	override func identical(to other: XSDAtomicValue) -> Bool {
		if let otherValue = (other as? 🌌Boolean)?.value {
			return value == otherValue
		} else {
			return false
		}
	}

}
