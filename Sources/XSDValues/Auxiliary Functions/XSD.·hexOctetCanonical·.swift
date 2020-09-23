import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.BinaryOctet` to a `XSD.hexOctet`.
	///
	///  +  parameters:
	///      +  o:
	///         A `XSD.BinaryOctet`.
	///
	///  +  returns:
	///     A `XSD.hexOctet`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-hexOctetCanonical>
	@inlinable
	static func ·hexOctetCanonical·(
		_ o: XSD.BinaryOctet
	) -> XSD.hexOctet {
		let lo: XSD.Sequence<XSD.BinaryDigit> = sequence(
			state: 0 as UInt8
		) { state in
			let nextState = state as! UInt8 + 1
			guard nextState < 5 else { return nil }
			return (1 << 4 - nextState) & o == 0 ? .０ : .１
		}
		let hi: XSD.Sequence<XSD.BinaryDigit> = sequence(
			state: 0 as UInt8
		) { state in
			let nextState = state as! UInt8 + 1
			guard nextState < 5 else { return nil }
			return (1 << 8 - nextState) & o == 0 ? .０ : .１
		}
		return (
			XSD.·hexDigitCanonical·(hi) + XSD.·hexDigitCanonical·(lo)
		)◊
	}

}
