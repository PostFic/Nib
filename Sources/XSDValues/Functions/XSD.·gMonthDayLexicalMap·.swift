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
	static func ·gMonthDayLexicalMap·(
		_ LEX: XSD.gMonthDayLexicalRep
	) -> XSD.GMonthDayValue {
		let string = String(describing: LEX)
		let Array·M，D，T = string.split(
			maxSplits: 2,
			omittingEmptySubsequences: false
		) { (char: Character) -> Bool in
			char == "-" || char == "T" || char == "Z" || char == "+"
		}
		let tz: XSD.Integer?
		if Array·M，D，T.count == 3 {
			tz = XSD.·timezoneFragValue·(
				string[
					Array·M，D，T[1].endIndex..<string.endIndex
				]◊
			)
		} else { tz = nil }
		let M = Array·M，D，T[0]
		let D = Array·M，D，T[1]
		return XSD.·newDateTime·(
			nil,
			XSD.·monthFragValue·(M◊),
			XSD.·dayFragValue·(D◊),
			nil,
			nil,
			nil,
			tz
		)
	}

}
