import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.hexOctet` to a single `XSD.BinaryOctet`.
	///
	///  +  parameters:
	///      +  LEX:
	///         A `XSD.hexOctet`.
	///
	///  +  returns:
	///     A single `XSD.BinaryOctet`.
	///
	/// `LEX` necessarily consists of exactly two `XSD.hexDigit`s.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-hexOctetMap>
	@inlinable
	static func ·hexOctetMap·(
		_ LEX: XSD.hexOctet
	) -> XSD.BinaryOctet {
		let d1 = String(String(describing: LEX).first!)
		let d2 = String(String(describing: LEX).last!)
		return XSD.·hexDigitMap·(d2◊).enumerated().reduce(
			into: XSD.·hexDigitMap·(d1◊).enumerated().reduce(
				into: 0
			) { $0 |= $1.1.rawValue << UInt8(7 - $1.0) }
		) { $0 |= $1.1.rawValue << UInt8(3 - $1.0) }
	}

}
