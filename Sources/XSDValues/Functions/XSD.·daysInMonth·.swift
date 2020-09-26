import XSD

public extension XSD {

	/// Returns the number of the last day of the month for any
	///   combination of year and month.
	///
	///  +  parameters:
	///      +  yr:
	///         An `XSD.Integer`, or `nil`.
	///      +  mo:
	///         An `XSD.Integer` between 1 and 12 inclusive.
	///
	///  +  returns:
	///     An `XSD.Integer` between 28 or 31 inclusive.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-daysInMonth>
	@inlinable
	static func ·daysInMonth· (
		_ y: XSD.Integer?,
		_ m: XSD.Integer
	) -> XSD.Integer {
		guard m >= 1 && m <= 12
		else
		{ fatalError("Expected an integer between 1 and 12, but got \(m).") }
		switch m {
		case 2:
			guard let year = y
			else
			{ return 28 }
			if year % 4 == 0 {
				if year % 100 == 0 {
					if year % 400 == 0
					{ return 29 }
					else
					{ return 28 }
				} else
				{ return 29 }
			} else
			{ return 28 }
		case 4, 6, 9, 11:
			return 30
		default:
			return 31
		}
	}

}
