import XSD

public extension XSDNumberValue {

	func rounded(
		by powerOfTen: XSD.Integer = 0
	) -> Self {
		if let specialValue = self.specialValue
		{ return Self(truncating: specialValue) }
		else if let decimalNumber = self.decimalNumber
		{ return Self(truncating: XSD.·round·(decimalNumber, powerOfTen)) }
		else if let integer = self.integer
		{ return Self(truncating: XSD.·round·(XSD.DecimalNumber(integer), powerOfTen)) }
		else
		{ return Self(truncating: .notANumber) }
	}

}
