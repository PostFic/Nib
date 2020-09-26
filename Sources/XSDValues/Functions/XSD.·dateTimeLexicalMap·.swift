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
	static func ·dateTimeLexicalMap· (
		_ LEX: XSD.dateTimeLexicalRep
	) -> XSD.DateTimeValue {
		let string = String(LEX)
		let Array·Y，MO，D，H，MI，S，T = string.dropFirst().split(
			maxSplits: 6,
			omittingEmptySubsequences: false
		) { char in
			switch char {
			case "-", "T", ":", "Z", "+":
				return true
			default:
				return false
			}
		}
		let tz: XSD.Integer?
		if Array·Y，MO，D，H，MI，S，T.count == 7
		{ tz = XSD.·timezoneFragValue·(XSD.timezoneFrag(string[Array·Y，MO，D，H，MI，S，T[5].endIndex..<string.endIndex])!) }
		else
		{ tz = nil }
		let Y = string[string.startIndex..<Array·Y，MO，D，H，MI，S，T[0].endIndex]
		let MO = Array·Y，MO，D，H，MI，S，T[1]
		let D = Array·Y，MO，D，H，MI，S，T[2]
		if Array·Y，MO，D，H，MI，S，T[3] == "24"
		{ return XSD.·newDateTime·(XSD.·yearFragValue·(XSD.yearFrag(Y)!), XSD.·monthFragValue·(XSD.monthFrag(MO)!), XSD.·dayFragValue·(XSD.dayFrag(D)!), 24, 0, 0, tz) }
		else {
			let H = Array·Y，MO，D，H，MI，S，T[3]
			let MI = Array·Y，MO，D，H，MI，S，T[4]
			let S = Array·Y，MO，D，H，MI，S，T[5]
			return XSD.·newDateTime·(XSD.·yearFragValue·(XSD.yearFrag(Y)!), XSD.·monthFragValue·(XSD.monthFrag(MO)!), XSD.·dayFragValue·(XSD.dayFrag(D)!), XSD.·hourFragValue·(XSD.hourFrag(H)!), XSD.·minuteFragValue·(XSD.minuteFrag(MI)!), XSD.·secondFragValue·(XSD.secondFrag(S)!), tz)
		}
	}

}
