import Common

class 🌌Value: XSDAtomicValue {

	override init() throws {
		try super.init()
	}

	/// Creates a new instance from the given `representation`.
	required convenience init(
		_ literal: String
	) throws {
		try self.init()
	}

}
