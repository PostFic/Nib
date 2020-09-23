import XSD

public extension XSD {

	/// Normalizes minute, hour, month, and year values to values that
	///   obey the appropriate constraints.
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
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dt-normMi>
	///
	///  +  note:
	///     The XSD specification incorrectly fails to normalize
	///       negative values.
	///     Nib provides the correct implementation.
	@inlinable
	static func ·normalizeMinute·(
		_ yr: inout XSD.Integer,
		_ mo: inout XSD.Integer,
		_ da: inout XSD.Integer,
		_ hr: inout XSD.Integer,
		_ mi: inout XSD.Integer
	) {
		hr += XSD.·div·(mi, 60)
		mi = XSD.·mod·(mi, 60)
		if mi < 0 {
			hr -= 1
			mi += 60
		}
		da += XSD.·div·(hr, 24)
		hr = XSD.·mod·(hr, 24)
		if hr < 0 {
			da -= 1
			hr += 24
		}
		XSD.·normalizeDay·(&yr, &mo, &da)
	}

}
