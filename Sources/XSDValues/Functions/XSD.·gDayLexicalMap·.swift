import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.gDayLexicalRep` to a `XSD.GDayValue`.
	///
	///  +  parameters:
	///      +  LEX:
	///         A `XSD.gDayLexicalRep`.
	///
	///  +  returns:
	///     A `XSD.GDayValue`.
	///
	/// `LEX` necessarily includes an instance `D` of `XSD.dayFrag`,
	///   optionally followed by an instance `T` of `XSD.timezoneFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gDayLexRep>
	@inlinable
	static func ·gDayLexicalMap· (
		_ LEX: XSD.gDayLexicalRep
	) -> XSD.GDayValue {
		let string = String(LEX)
		let Array·D，T = string.dropFirst(3).split(
			maxSplits: 1,
			omittingEmptySubsequences: false
		) { $0 == "-" || $0 == "Z" || $0 == "+" }
		let tz: XSD.Integer?
		if Array·D，T.count == 2
		{ tz = XSD.·timezoneFragValue·(XSD.timezoneFrag(string[Array·D，T[0].endIndex..<string.endIndex])!) }
		else
		{ tz = nil }
		let D = Array·D，T[0]
		return XSD.·newDateTime·(nil, nil, XSD.·dayFragValue·(XSD.dayFrag(D)!), nil, nil, nil, tz)
	}

}
