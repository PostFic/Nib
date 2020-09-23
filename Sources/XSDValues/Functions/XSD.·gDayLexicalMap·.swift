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
	static func ·gDayLexicalMap·(
		_ LEX: XSD.gDayLexicalRep
	) -> XSD.GDayValue {
		let string = String(describing: LEX)
		let Array·D，T = string.split(
			maxSplits: 1,
			omittingEmptySubsequences: false
		) { (char: Character) -> Bool in
			char == "-" || char == "T" || char == "Z" || char == "+"
		}
		let tz: XSD.Integer?
		if Array·D，T.count == 2 {
			tz = XSD.·timezoneFragValue·(
				string[
					Array·D，T[0].endIndex..<string.endIndex
				]◊
			)
		} else { tz = nil }
		let D = Array·D，T[0]
		return XSD.·newDateTime·(
			nil,
			nil,
			XSD.·dayFragValue·(D◊),
			nil,
			nil,
			nil,
			tz
		)
	}

}
