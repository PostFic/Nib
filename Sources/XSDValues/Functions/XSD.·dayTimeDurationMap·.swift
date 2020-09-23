import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.dayTimeDurationLexicalRep` to a
	///   `XSD.DurationValue`.
	///
	///  +  parameters:
	///      +  DT:
	///         A `XSD.dayTimeDurationLexicalRep`.
	///
	///  +  returns:
	///     A `XSD.DurationValue`.
	///
	/// `DT` necessarily consists of an optional leading `"-"`,
	///   followed by `"P"` and then an instance of
	///   `XSD.duDayTimeFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dayTimeDurationMap>
	///
	///  +  note:
	///     The XSD Specification incorrectly identifies `DT` as a
	///       value, rather than a literal.
	///     Nib provides the correct implementation.
	@inlinable
	static func ·dayTimeDurationMap·(
		_ DT: XSD.dayTimeDurationLexicalRep
	) -> XSD.DurationValue {
		let first = String(describing: DT).first
		let P = String(describing: DT).dropFirst(first == "-" ? 2 : 1)
		let s = XSD.·duDayTimeFragmentMap·(P◊)
		return XSD.DurationValue(
			months: 0,
			seconds: first == "-" ? -s : s
		)!
	}

}
