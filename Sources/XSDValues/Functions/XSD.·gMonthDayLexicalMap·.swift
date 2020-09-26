import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.gMonthDayLexicalRep` to a `XSD.GMonthDayValue`.
	///
	///  +  parameters:
	///      +  LEX:
	///         A `XSD.gMonthDayLexicalRep`.
	///
	///  +  returns:
	///     A `XSD.GMonthDayValue`.
	///
	/// `LEX` necessarily includes an instance `M` of `XSD.monthFrag`
	///   and an instance `D` of `XSD.dayFrag`, hyphen‐separated and
	///   optionally followed by an instance `T` of `XSD.timezoneFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gMonthDayLexRep>
	@inlinable
	static func ·gMonthDayLexicalMap· (
		_ LEX: XSD.gMonthDayLexicalRep
	) -> XSD.GMonthDayValue {
		let string = String(LEX)
		let Array·M，D，T = string.dropFirst(2).split(
			maxSplits: 2,
			omittingEmptySubsequences: false
		) { $0 == "-" || $0 == "Z" || $0 == "+" }
		let tz: XSD.Integer?
		if Array·M，D，T.count == 3
		{ tz = XSD.·timezoneFragValue·(XSD.timezoneFrag(string[Array·M，D，T[1].endIndex..<string.endIndex])!) }
		else
		{ tz = nil }
		let M = Array·M，D，T[0]
		let D = Array·M，D，T[1]
		return XSD.·newDateTime·(nil, XSD.·monthFragValue·(XSD.monthFrag(M)!), XSD.·dayFragValue·(XSD.dayFrag(D)!), nil, nil, nil, tz)
	}

}
