import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.duTimeFrag` into a `XSD.DecimalNumber`, to be used
	///   when calculating the `·seconds·` of a `XSD.DurationValue`.
	///
	///  +  parameters:
	///      +  YM:
	///         A `XSD.duTimeFrag`.
	///
	///  +  returns:
	///     A nonnegative `XSD.DecimalNumber`.
	///
	/// `T` necessarily consists of an instance of `XSD.duHourFrag`
	///   and/or an instance of `XSD.duMinuteFrag` and/or an instance
	///   of `XSD.duSecondFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duTMap>
	@inlinable
	static func ·duTimeFragmentMap·(
		_ T: XSD.duTimeFrag
	) -> XSD.DecimalNumber {
		let MS: String.SubSequence
		let h: XSD.Integer
		let m: XSD.Integer
		let s: XSD.DecimalNumber
		let Array·H，MS = String(describing: T).dropFirst().split(
			separator: "H",
			maxSplits: 1,
			omittingEmptySubsequences: false
		)
		if Array·H，MS.count == 2 {
			h = XSD.·duHourFragmentMap·((Array·H，MS[0] + "H")◊)
			MS = Array·H，MS[1]
		} else {
			h = 0
			MS = Array·H，MS[0]
		}
		let Array·M，S = MS.split(
			separator: "M",
			maxSplits: 1,
			omittingEmptySubsequences: false
		)
		if Array·M，S.count == 2 {
			m = XSD.·duMinuteFragmentMap·((Array·M，S[0] + "M")◊)
			s = Array·M，S[1] == "" ? 0
				: XSD.·duSecondFragmentMap·(Array·M，S[1]◊)
		} else {
			m = 0
			s = MS == "" ? 0 : XSD.·duSecondFragmentMap·(MS◊)
		}
		return 3600 * XSD.DecimalNumber(h)
			+ 60 * XSD.DecimalNumber(m)
			+ s
	}

}
