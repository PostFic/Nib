import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.duYearMonthFrag` into an `XSD.Integer`, to be used
	///   when calculating the `·months·` of a `XSD.DurationValue`.
	///
	///  +  parameters:
	///      +  YM:
	///         A `XSD.duYearMonthFrag`.
	///
	///  +  returns:
	///     A nonnegative `XSD.Integer`.
	///
	/// `YM` necessarily consists of an instance of `XSD.duYearFrag`
	///   and/or an instance of `XSD.duMonthFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duYMMap>
	@inlinable
	static func ·duYearMonthFragmentMap·(
		_ YM: XSD.duYearMonthFrag
	) -> XSD.Integer {
		let y: XSD.Integer
		let m: XSD.Integer
		let Array·Y，M = String(describing: YM).split(
			separator: "Y",
			maxSplits: 1,
			omittingEmptySubsequences: false
		)
		if Array·Y，M.count == 2 {
			y = XSD.·duYearFragmentMap·((Array·Y，M[0] + "Y")◊)
			m = Array·Y，M[1] == "" ? 0
				: XSD.·duMonthFragmentMap·(Array·Y，M[1]◊)
		} else {
			y = 0
			m = XSD.·duMonthFragmentMap·(YM◊)
		}
		return 12 * y + m
	}

}
