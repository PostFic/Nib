import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.durationLexicalRep` to a `XSD.DurationValue`.
	///
	///  +  parameters:
	///      +  DUR:
	///         A `XSD.durationLexicalRep`.
	///
	///  +  returns:
	///     A `XSD.DurationValue`.
	///
	/// `DUR` necessarily consists of possibly a leading `"-"`,
	///   followed by `"P"` and then an instance of
	///   `XSD.duYearMonthFrag` and/or an instance of
	///   `XSD.duDayTimeFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-durationMap>
	@inlinable
	static func ·durationMap·(
		_ DUR: XSD.durationLexicalRep
	) -> XSD.DurationValue {
		let first = String(describing: DUR).first
		let P = String(describing: DUR).dropFirst(first == "-" ? 2 : 1)
		let m: XSD.Integer
		let s: XSD.DecimalNumber
		let Array·Y，M，D = P.split(
			maxSplits: 2,
			omittingEmptySubsequences: false
		) { $0 == "Y" || $0 == "M" }
		if Array·Y，M，D.count > 1 {
			m = XSD.·duYearMonthFragmentMap·(
				P[
					P.startIndex...Array·Y，M，D[
						Array·Y，M，D.count - 2
					].endIndex
				]◊
			)
			s = Array·Y，M，D.last == "" ? 0
				: XSD.·duDayTimeFragmentMap·(Array·Y，M，D.last!◊)
		} else {
			m = 0
			s = XSD.·duDayTimeFragmentMap·(P◊)
		}
		if first == "-" {
			return XSD.DurationValue(months: -m, seconds: -s)!
		} else { return XSD.DurationValue(months: m, seconds: s)! }
	}

}
