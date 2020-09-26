import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.HexBinaryValue` to a `XSD.hexBinaryRep`.
	///
	///  +  parameters:
	///      +  o:
	///         A `XSD.HexBinaryValue`.
	///
	///  +  returns:
	///     A `XSD.hexBinaryRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-hexBinaryCanonical>
	@inlinable
	static func ·hexBinaryCanonical· (
		_ o: XSD.HexBinaryValue
	) -> XSD.hexBinaryRep {
		let h = o.octets.map
		{ String(XSD.·hexOctetCanonical·($0)) }
		return XSD.hexBinaryRep(h.joined())!
	}

}
