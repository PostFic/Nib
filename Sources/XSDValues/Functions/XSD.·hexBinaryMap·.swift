import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.hexBinaryRep` to a sequence of `XSD.BinaryOctet`s
	///   in the form of a `XSD.HexBinaryValue`.
	///
	///  +  parameters:
	///      +  LEX:
	///         A `XSD.hexBinaryRep`.
	///
	///  +  returns:
	///     A sequence of `XSD.BinaryOctet`s in the form of a
	///       `XSD.HexBinaryValue`.
	///
	/// `LEX` necessarily includes a sequence of zero or more
	///   matching the `XSD.hexOctet` production.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-hexBinaryMap>
	@inlinable
	static func ·hexBinaryMap·(
		_ LEX: XSD.hexBinaryRep
	) -> XSD.HexBinaryValue {
		let octets = String(describing: LEX)
		let o: UnfoldSequence<XSD.BinaryOctet, Substring> = sequence(
			state: octets[octets.startIndex..<octets.endIndex]
		) { state in
			let octet = octets.prefix(2)
			guard octet.count == 2 else { return nil }
			state = octets[octet.endIndex..<octets.endIndex]
			return XSD.·hexOctetMap·(octets.prefix(2)◊)
		}
		return XSD.HexBinaryValue(o)
	}

}
