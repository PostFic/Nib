import XSD

public extension XSD {

	/// If month (`mo`) is out of range, or day (`da`) is out of range
	///   for the appropriate month, then adjust values accordingly,
	///   otherwise, make no change.
	///
	///  +  parameters:
	///      +  yr:
	///         An `XSD.Integer`.
	///      +  mo:
	///         An `XSD.Integer`.
	///      +  da:
	///         An `XSD.Integer`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dt-normDa>
	@inlinable
	static func ·normalizeDay· (
		_ yr: inout XSD.Integer,
		_ mo: inout XSD.Integer,
		_ da: inout XSD.Integer
	) {
		XSD.·normalizeMonth·(&yr, &mo)
		let ·daysInMonth·yr，mo = XSD.·daysInMonth·(yr, mo)
		while da < 0 || da > ·daysInMonth·yr，mo {
			if da > ·daysInMonth·yr，mo {
				da -= ·daysInMonth·yr，mo
				mo += 1
				XSD.·normalizeMonth·(&yr, &mo)
			}
			if da <= 0 {
				mo -= 1
				XSD.·normalizeMonth·(&yr, &mo)
				da += XSD.·daysInMonth·(yr, mo)
			}
		}
	}

}
