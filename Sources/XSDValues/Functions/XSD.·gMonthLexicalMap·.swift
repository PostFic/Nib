import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.gMonthLexicalRep` to a `XSD.GMonthValue`.
	///
	///  +  parameters:
	///      +  LEX:
	///         A `XSD.gMonthLexicalRep`.
	///
	///  +  returns:
	///     A `XSD.GMonthValue`.
	///
	/// `LEX` necessarily includes an instance `M` of `XSD.monthFrag`,
	///   optionally followed by an instance `T` of `XSD.timezoneFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gMonthLexRep>
	@inlinable
	static func ·gMonthLexicalMap· (
		_ LEX: XSD.gMonthLexicalRep
	) -> XSD.GMonthValue {
		let string = String(LEX)
		let Array·M，T = string.dropFirst(2).split(
			maxSplits: 1,
			omittingEmptySubsequences: false
		) { $0 == "-" || $0 == "Z" || $0 == "+" }
		let tz: XSD.Integer?
		if Array·M，T.count == 2
		{ tz = XSD.·timezoneFragValue·(XSD.timezoneFrag(string[Array·M，T[0].endIndex..<string.endIndex])!) }
		else
		{ tz = nil }
		let M = Array·M，T[0]
		return XSD.·newDateTime·(nil, XSD.·monthFragValue·(XSD.monthFrag(M)!), nil, nil, nil, nil, tz)
	}

}
