class 🌌Value: XSDAtomicValue {

	override init() {
		super.init()
	}

	/// Creates a new instance from the given `representation`.
	required convenience init(_ literal: String) throws {
		self.init()
	}

}
