import XSD

public extension XSD {

	/// If month (`mo`) is out of range, adjust month and year (`yr`) accordingly; otherwise, make no change.
	///
	///  +  parameters:
	///      +  yr:
	///         An `XSD.Integer`.
	///      +  mo:
	///         An `XSD.Integer`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dt-normMo>
	///
	///  +  note:
	///     The XSD specification incorrectly fails to normalize nonpositive values.
	///     Nib provides the correct implementation.
	@inlinable
	static func ·normalizeMonth· (
		_ yr: inout XSD.Integer,
		_ mo: inout XSD.Integer
	) {
		yr += XSD.·div·(mo - 1, 12)
		mo = XSD.·mod·(mo - 1, 12) + 1
		if mo <= 0 {
			yr -= 1
			mo += 12
		}
	}

}
