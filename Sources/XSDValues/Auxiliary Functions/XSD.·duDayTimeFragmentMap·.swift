import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.duDayTimeFrag` into a `XSD.DecimalNumber`, which is
	///   a potential value for the `·seconds·` of a
	///   `XSD.DurationValue`.
	///
	///  +  parameters:
	///      +  DT:
	///         A `XSD.duDayTimeFrag`.
	///
	///  +  returns:
	///     A nonnegative `XSD.DecimalNumber`.
	///
	/// `DT` necessarily consists of an instance of `XSD.duDayFrag`
	///   and/or an instance of `XSD.duTimeFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duDTMap>
	@inlinable
	static func ·duDayTimeFragmentMap·(
		_ DT: XSD.duDayTimeFrag
	) -> XSD.DecimalNumber {
		let d: XSD.Integer
		let t: XSD.DecimalNumber
		let Array·D，T = String(describing: DT).split(
			separator: "D",
			maxSplits: 1,
			omittingEmptySubsequences: false
		)
		if Array·D，T.count == 2 {
			d = XSD.·duDayFragmentMap·(
				XSD.duDayFrag(Array·D，T[0] + "D")!
			)
			t = Array·D，T[1] == "" ? 0
				: XSD.·duTimeFragmentMap·(Array·D，T[1]◊)
		} else {
			d = 0
			t = XSD.·duTimeFragmentMap·(DT◊)
		}
		return 86400 * XSD.DecimalNumber(d) + t
	}

}
