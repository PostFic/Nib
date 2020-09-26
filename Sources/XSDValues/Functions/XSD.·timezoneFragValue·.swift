import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.timezoneFrag`, part of a
	///   `XSDDate·timeSevenPropertyModel`’s lexical representation,
	///   onto an `XSD.Integer`, presumably the `·timezoneOffset·`
	///   property of a `XSDDate·timeSevenPropertyModel`.
	///
	///  +  parameters:
	///      +  TZ:
	///         A `XSD.timezoneFrag`.
	///
	///  +  returns:
	///     An `XSD.Integer`.
	///
	/// `TZ` necessarily consists of either just `"Z"`, or a sign
	///   (`"+"` or `"-"`) followed by an instance `H` of
	///   `XSD.hourFrag`, a colon, and an instance `M` of
	///   `XSD.minuteFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dt-tzMap>
	///
	///  +  note:
	///     The XSD Specification incorrectly specifies using
	///       `XSD.·unsignedDecimalPtMap·` to get the values of `H` and
	///       `M`, instead of `XSD.·unsignedNoDecimalMap·`.
	///     Nib provides the correct implementation.
	@inlinable
	static func ·timezoneFragValue· (
		_ TZ: XSD.timezoneFrag
	) -> XSD.Integer {
		if String(TZ) == "Z"
		{ return 0 }
		else {
			let sign = String(TZ).first
			let Array·H，M = String(TZ).dropFirst().split(
				separator: ":",
				maxSplits: 1,
				omittingEmptySubsequences: false
			)
			let H = Array·H，M[0]
			let M = Array·H，M[1]
			return sign == "-" ? -(XSD.·unsignedNoDecimalMap·(XSD.unsignedNoDecimalPtNumeral(H)!) * 60 + XSD.·unsignedNoDecimalMap·(XSD.unsignedNoDecimalPtNumeral(M)!)) : XSD.·unsignedNoDecimalMap·(XSD.unsignedNoDecimalPtNumeral(H)!) * 60 + XSD.·unsignedNoDecimalMap·(XSD.unsignedNoDecimalPtNumeral(M)!)
		}
	}

}
