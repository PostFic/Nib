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
	static func ·gYearMonthLexicalMap·(
		_ LEX: XSD.gYearMonthLexicalRep
	) -> XSD.GYearMonthValue {
		let string = String(describing: LEX)
		let Array·Y，M，T = string.split(
			maxSplits: 2,
			omittingEmptySubsequences: false
		) { (char: Character) -> Bool in
			char == "-" || char == "T" || char == "Z" || char == "+"
		}
		let tz: XSD.Integer?
		if Array·Y，M，T.count == 3 {
			tz = XSD.·timezoneFragValue·(
				string[
					Array·Y，M，T[1].endIndex..<string.endIndex
				]◊
			)
		} else { tz = nil }
		let Y = Array·Y，M，T[0]
		let M = Array·Y，M，T[1]
		return XSD.·newDateTime·(
			XSD.·yearFragValue·(Y◊),
			XSD.·monthFragValue·(M◊),
			nil,
			nil,
			nil,
			nil,
			tz
		)
	}

}
