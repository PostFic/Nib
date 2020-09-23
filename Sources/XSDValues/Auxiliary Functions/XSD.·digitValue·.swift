import XSD
import XSDLiterals

public extension XSD {

	/// Maps each `XSD.digit` to its numerical value.
	///
	///  +  parameters:
	///      +  d:
	///         An `XSD.digit`.
	///
	///  +  returns:
	///     A nonnegative `XSD.Integer` less than 10.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-digitVal>
	@inlinable
	static func ·digitValue·(
		_ d: XSD.digit
	) -> XSD.Integer {
		switch String(describing: d) {
		case "0":
			return 0
		case "1":
			return 1
		case "2":
			return 2
		case "3":
			return 3
		case "4":
			return 4
		case "5":
			return 5
		case "6":
			return 6
		case "7":
			return 7
		case "8":
			return 8
		case "9":
			return 9
		default:
			fatalError(#"Expected a digit but received "\(d)"."#)
		}
	}

}
