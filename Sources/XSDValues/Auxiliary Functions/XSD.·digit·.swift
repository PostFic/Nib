import XSD
import XSDLiterals

public extension XSD {

	/// Maps an `XSD.Integer` between 0 and 9 to the corresponding
	///   `XSD.digit`.
	///
	///  +  parameters:
	///      +  i:
	///         An `XSD.Integer` between 0 and 9 inclusive.
	///
	///  +  returns:
	///     A `XSD.digit`.
	///
	///  It is a runtime error if `i` is not between 0 and 9 inclusive.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-digit>
	@inlinable
	static func ·digit·(
		_ i: XSD.Integer
	) -> XSD.digit {
		switch i {
		case 0:
			return "0"◊
		case 1:
			return "1"◊
		case 2:
			return "2"◊
		case 3:
			return "3"◊
		case 4:
			return "4"◊
		case 5:
			return "5"◊
		case 6:
			return "6"◊
		case 7:
			return "7"◊
		case 8:
			return "8"◊
		case 9:
			return "9"◊
		default:
			fatalError("""
				Expected an integer between 0 and 9 inclusive, but \
				got \(i).
				""")
		}
	}

}
