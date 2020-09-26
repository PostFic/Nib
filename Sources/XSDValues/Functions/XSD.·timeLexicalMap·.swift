import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.timeLexicalRep` to a `XSD.TimeValue`.
	///
	///  +  parameters:
	///      +  LEX:
	///         A `XSD.timeLexicalRep`.
	///
	///  +  returns:
	///     A `XSD.TimeValue`.
	///
	/// `LEX` necessarily includes either substrings that are instances
	///   of `XSD.hourFrag`, `XSD.minuteFrag`, and `XSD.secondFrag`
	///   (`H`, `MI`, and `S`), or else an instance of
	///   `XSD.endOfDayFrag`; finally, it may optionally contain an
	///   instance of `XSD.timezoneFrag` (`T`).
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-timeLexRep>
	@inlinable
	static func ·timeLexicalMap· (
		_ LEX: XSD.timeLexicalRep
	) -> XSD.TimeValue {
		let string = String(LEX)
		let Array·H，M，S，T = string.split(
			maxSplits: 3,
			omittingEmptySubsequences: false
		) { char in
			switch char {
			case "-", ":", "Z", "+":
				return true
			default:
				return false
			}
		}
		let tz: XSD.Integer?
		if Array·H，M，S，T.count == 4
		{ tz = XSD.·timezoneFragValue·(XSD.timezoneFrag(string[Array·H，M，S，T[2].endIndex..<string.endIndex])!) }
		else
		{ tz = nil }
		if Array·H，M，S，T[0] == "24"
		{ return XSD.·newDateTime·(nil, nil, nil, 24, 0, 0, tz) }
		else {
			let H = Array·H，M，S，T[0]
			let M = Array·H，M，S，T[1]
			let S = Array·H，M，S，T[2]
			return XSD.·newDateTime·(nil, nil, nil, XSD.·hourFragValue·(XSD.hourFrag(H)!), XSD.·minuteFragValue·(XSD.minuteFrag(M)!), XSD.·secondFragValue·(XSD.secondFrag(S)!), tz)
		}
	}

}
