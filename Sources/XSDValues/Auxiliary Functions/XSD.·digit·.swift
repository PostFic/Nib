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
	static func ·digit· (
		_ i: XSD.Integer
	) -> XSD.digit {
		switch i {
		case 0:
			return XSD.digit("0")!
		case 1:
			return XSD.digit("1")!
		case 2:
			return XSD.digit("2")!
		case 3:
			return XSD.digit("3")!
		case 4:
			return XSD.digit("4")!
		case 5:
			return XSD.digit("5")!
		case 6:
			return XSD.digit("6")!
		case 7:
			return XSD.digit("7")!
		case 8:
			return XSD.digit("8")!
		case 9:
			return XSD.digit("9")!
		default:
			fatalError("Expected an integer between 0 and 9 inclusive, but got \(i).")
		}
	}

}
