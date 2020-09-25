import XSD

public extension XSD {

	/// Maps a `XSDDate·timeSevenPropertyModel` to the decimal number
	///   representing
	///   its position on the timeline.
	///
	///  +  parameters:
	///      +  dt:
	///         A `XSDDate·timeSevenPropertyModel`.
	///
	///  +  returns:
	///     A `XSD.DecimalNumber`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-dt-timeOnTimeline>
	@inlinable
	static func ·timeOnTimeline·<D7M: XSDDate·timeSevenPropertyModelValue>(
		_ dt: D7M
	) -> XSD.DecimalNumber {
		let yr = (dt.·year· ?? 1972) - 1
		let mo = dt.·month· ?? 12
		let da = (dt.·day· ?? XSD.·daysInMonth·(yr + 1, mo)) - 1
		let hr = dt.·hour· ?? 0
		let mi: XSD.Integer
		let se = dt.·second· ?? 0
		if let timezoneOffset = dt.·timezoneOffset· {
			mi = (dt.·minute· ?? 0) - timezoneOffset
		} else { mi = dt.·minute· ?? 0 }
		var ToTI: XSD.DecimalNumber = 31536000 * XSD.DecimalNumber(yr)
		ToTI += 86400 * XSD.DecimalNumber(
			XSD.·div·(yr, 400) - XSD.·div·(yr, 100) + XSD.·div·(yr, 4)
		)
		if mo > 1 {
			ToTI += 86400 * XSD.DecimalNumber(
				(1..<mo).reduce(into: 0) { Sum, m in
					Sum += XSD.·daysInMonth·(yr + 1, m)
				}
			)
		}
		ToTI += 86400 * XSD.DecimalNumber(da)
		ToTI += 3600 * XSD.DecimalNumber(hr) +
			60 * XSD.DecimalNumber(mi) + se
		return ToTI
	}

}
