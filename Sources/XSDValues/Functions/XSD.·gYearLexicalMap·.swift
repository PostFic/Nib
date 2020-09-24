import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.gYearLexicalRep` to a `XSD.GYearValue`.
	///
	///  +  parameters:
	///      +  LEX:
	///         A `XSD.gYearLexicalRep`.
	///
	///  +  returns:
	///     A `XSD.GYearMonthValue`.
	///
	/// `LEX` necessarily includes an instance `Y` of `XSD.yearFrag`,
	///   optionally followed by an instance `T` of `XSD.timezoneFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gYearLexRep>
	@inlinable
	static func ·gYearLexicalMap·(
		_ LEX: XSD.gYearLexicalRep
	) -> XSD.GYearValue {
		let string = String(describing: LEX)
		let Array·Y，T = string.split(
			maxSplits: 1,
			omittingEmptySubsequences: false
		) { $0 == "-" || $0 == "Z" || $0 == "+" }
		let tz: XSD.Integer?
		if Array·Y，T.count == 2 {
			tz = XSD.·timezoneFragValue·(
				string[
					Array·Y，T[0].endIndex..<string.endIndex
				]◊
			)
		} else { tz = nil }
		let Y = Array·Y，T[0]
		return XSD.·newDateTime·(
			XSD.·yearFragValue·(Y◊),
			nil,
			nil,
			nil,
			nil,
			nil,
			tz
		)
	}

}
