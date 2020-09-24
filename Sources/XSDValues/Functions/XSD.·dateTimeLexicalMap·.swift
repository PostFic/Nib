import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.dateTimeLexicalRep` to a `XSD.DateTimeValue`.
	///
	///  +  parameters:
	///      +  LEX:
	///         A `XSD.dateTimeLexicalRep`.
	///
	///  +  returns:
	///     A `XSD.DateTimeValue`.
	///
	/// `LEX` necessarily includes substrings that are instances of
	///   `XSD.yearFrag`, `XSD.monthFrag`, and `XSD.dayFrag` (`Y`,
	///   `MO`, and `D`); it also contains either instances of
	///   `XSD.hourFrag`, `XSD.minuteFrag`, and `XSD.secondFrag` (`H`,
	///   `MI`, and `S`), or else an instance of `XSD.endOfDayFrag`;
	///   finally, it may optionally contain an instance of
	///   `XSD.timezoneFrag` (`T`).
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-dateTimeLexRep>
	///
	///  +  note:
	///     The XSD Specification incorrectly names the `XSD.hourFrag`
	///       as `Y` instead of `H`.
	///     Nib provides the correct implementation.
	@inlinable
	static func ·dateTimeLexicalMap·(
		_ LEX: XSD.dateTimeLexicalRep
	) -> XSD.DateTimeValue {
		let string = String(describing: LEX)
		let Array·Y，MO，D，H，MI，S，T = string.dropFirst().split(
			maxSplits: 6,
			omittingEmptySubsequences: false
		) { (char: Character) -> Bool in
			char == "-"
				|| char == "T"
				|| char == ":"
				|| char == "Z"
				|| char == "+"
		}
		let tz: XSD.Integer?
		if Array·Y，MO，D，H，MI，S，T.count == 7 {
			tz = XSD.·timezoneFragValue·(
				string[
					Array·Y，MO，D，H，MI，S，T[
						5
					].endIndex..<string.endIndex
				]◊
			)
		} else { tz = nil }
		let Y = string[
			string.startIndex..<Array·Y，MO，D，H，MI，S，T[0].endIndex
		]
		let MO = Array·Y，MO，D，H，MI，S，T[1]
		let D = Array·Y，MO，D，H，MI，S，T[2]
		if Array·Y，MO，D，H，MI，S，T[3] == "24" {
			return XSD.·newDateTime·(
				XSD.·yearFragValue·(Y◊),
				XSD.·monthFragValue·(MO◊),
				XSD.·dayFragValue·(D◊),
				24,
				0,
				0,
				tz
			)
		} else {
			let H = Array·Y，MO，D，H，MI，S，T[3]
			let MI = Array·Y，MO，D，H，MI，S，T[4]
			let S = Array·Y，MO，D，H，MI，S，T[5]
			return XSD.·newDateTime·(
				XSD.·yearFragValue·(Y◊),
				XSD.·monthFragValue·(MO◊),
				XSD.·dayFragValue·(D◊),
				XSD.·hourFragValue·(H◊),
				XSD.·minuteFragValue·(MI◊),
				XSD.·secondFragValue·(S◊),
				tz
			)
		}
	}

}
