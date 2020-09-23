import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.dateLexicalRep` to a `XSD.DateValue`.
	///
	///  +  parameters:
	///      +  LEX:
	///         A `XSD.dateLexicalRep`.
	///
	///  +  returns:
	///     A `XSD.DateValue`.
	///
	/// `LEX` necessarily includes an instance `Y` of `XSD.yearFrag`,
	///   an instance `M` of `XSD.monthFrag`, and an instance `D` of
	///   `XSD.dayFrag`, hyphen‐separated and optionally followed by
	///   an instance `T` of `XSD.timezoneFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-dateLexRep>
	@inlinable
	static func ·dateLexicalMap·(
		_ LEX: XSD.dateLexicalRep
	) -> XSD.DateValue {
		let string = String(describing: LEX)
		let Array·Y，M，D，T = string.split(
			maxSplits: 3,
			omittingEmptySubsequences: false
		) { (char: Character) -> Bool in
			char == "-" || char == "T" || char == "Z" || char == "+"
		}
		let tz: XSD.Integer?
		if Array·Y，M，D，T.count == 4 {
			tz = XSD.·timezoneFragValue·(
				string[
					Array·Y，M，D，T[2].endIndex..<string.endIndex
				]◊
			)
		} else { tz = nil }
		let Y = Array·Y，M，D，T[0]
		let M = Array·Y，M，D，T[1]
		let D = Array·Y，M，D，T[2]
		return XSD.·newDateTime·(
			XSD.·yearFragValue·(Y◊),
			XSD.·monthFragValue·(M◊),
			XSD.·dayFragValue·(D◊),
			nil,
			nil,
			nil,
			tz
		)
	}

}
