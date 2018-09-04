class 🌌Value: XSDAtomicValue {

	override init() {
		super.init()
	}

	/// Creates a new instance from the given `representation`.
	required convenience init<StringType: StringProtocol>(
		_ representation: StringType
	) throws {
		self.init()
	}

}
