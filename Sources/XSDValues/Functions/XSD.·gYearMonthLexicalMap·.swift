import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.gYearMonthLexicalRep` to a `XSD.GYearMonthValue`.
	///
	///  +  parameters:
	///      +  LEX:
	///         A `XSD.gYearMonthLexicalRep`.
	///
	///  +  returns:
	///     A `XSD.GYearMonthValue`.
	///
	/// `LEX` necessarily includes an instance `Y` of `XSD.yearFrag`
	///   and an instance `M` of `XSD.monthFrag`, hyphen‐separated and
	///   optionally followed by an instance `T` of `XSD.timezoneFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gYearMonthLexRep>
	@inlinable
	static func ·gYearMonthLexicalMap· (
		_ LEX: XSD.gYearMonthLexicalRep
	) -> XSD.GYearMonthValue {
		let string = String(LEX)
		let Array·Y，M，T = string.dropFirst().split(
			maxSplits: 2,
			omittingEmptySubsequences: false
		) { $0 == "-" || $0 == "Z" || $0 == "+" }
		let tz: XSD.Integer?
		if Array·Y，M，T.count == 3
		{ tz = XSD.·timezoneFragValue·(XSD.timezoneFrag(string[Array·Y，M，T[1].endIndex..<string.endIndex])!) }
		else
		{ tz = nil }
		let Y = string[string.startIndex..<Array·Y，M，T[0].endIndex]
		let M = Array·Y，M，T[1]
		return XSD.·newDateTime·(XSD.·yearFragValue·(XSD.yearFrag(Y)!), XSD.·monthFragValue·(XSD.monthFrag(M)!), nil, nil, nil, nil, tz)
	}

}
