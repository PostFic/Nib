import XSD

public extension XSD {

	/// Normalizes second, minute, hour, month, and year values to
	///   values that obey the appropriate constraints.
	///
	///  +  parameters:
	///      +  yr:
	///         An `XSD.Integer`.
	///      +  mo:
	///         An `XSD.Integer`.
	///      +  da:
	///         An `XSD.Integer`.
	///      +  hr:
	///         An `XSD.Integer`.
	///      +  mi:
	///         An `XSD.Integer`.
	///      +  se:
	///         A `XSD.DecimalNumber`.
	///
	/// This algorithm ignores leap seconds.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dt-normSe>
	///
	///  +  note:
	///     The XSD specification incorrectly fails to normalize
	///       negative values.
	///     Nib provides the correct implementation.       
	@inlinable
	static func ·normalizeSecond· (
		_ yr: inout XSD.Integer,
		_ mo: inout XSD.Integer,
		_ da: inout XSD.Integer,
		_ hr: inout XSD.Integer,
		_ mi: inout XSD.Integer,
		_ se: inout XSD.DecimalNumber
	) {
		mi += XSD.·div·(se, 60)
		se = XSD.·mod·(se, 60)
		if se < 0 {
			mi -= 1
			se += 60
		}
		XSD.·normalizeMinute·(&yr, &mo, &da, &hr, &mi)
	}

}
