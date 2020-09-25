import XSD

/// A generic `XSDDate·timeSevenPropertyModel` used internally to
///   handle date/time construction and normalization.
@usableFromInline
internal struct Date·timeSevenPropertyModel:
	XSDDate·timeSevenPropertyModelValue
{

	@usableFromInline
	internal let ·day·: XSD.Integer?

	@usableFromInline
	internal let ·hour·: XSD.Integer?

	@usableFromInline
	internal let ·minute·: XSD.Integer?

	@usableFromInline
	internal let ·month·: XSD.Integer?

	@usableFromInline
	internal let ·second·: XSD.DecimalNumber?

	@usableFromInline
	internal let ·timezoneOffset·: XSD.Integer?

	@usableFromInline
	internal let ·year·: XSD.Integer?

	@usableFromInline
	internal init(
		mapping literal: Date·timeSevenPropertyModel.LexicalRepresentation
	) { self.init(XSD.·dateTimeLexicalMap·(literal◊))! }

	@usableFromInline
	internal init(
		_ Yr: XSD.Integer?,
		_ Mo: XSD.Integer?,
		_ Da: XSD.Integer?,
		_ Hr: XSD.Integer?,
		_ Mi: XSD.Integer?,
		_ Se: XSD.DecimalNumber?,
		_ Tz: XSD.Integer?
	) {
		var yr = Yr ?? 1
		var mo = Mo ?? 1
		var da = Da ?? 1
		var hr = Hr ?? 0
		var mi = Mi ?? 0
		var se = Se ?? 0
		let tz = Tz ?? 0
		guard mo >= 1 && mo <= 12 else {
			fatalError(
				"""
				Expected an integer between 1 and 12 inclusive\
				, but got \(mo).
				"""
			)
		}
		guard da >= 1 && da <= 31 else {
			fatalError(
				"""
				Expected an integer between 1 and 31 inclusive\
				, but got \(da).
				"""
			)
		}
		guard hr >= 0 && hr <= 24 else {
			fatalError(
				"""
				Expected an integer between 0 and 24 inclusive\
				, but got \(hr).
				"""
			)
		}
		guard mi >= 0 && mi <= 59 else {
			fatalError(
				"""
				Expected an integer between 0 and 59 inclusive\
				, but got \(mi).
				"""
			)
		}
		guard se >= 0 && se < 60 else {
			fatalError(
				"""
				Expected a decimal number greater than or equal \
				to 0 and less than 60, but got \(se).
				"""
			)
		}
		guard tz >= -840 && tz <= 840 else {
			fatalError(
				"""
				Expected an integer between -840 and 840 inclusive\
				, but got \(tz).
				"""
			)
		}
		XSD.·normalizeSecond·(&yr, &mo, &da, &hr, &mi, &se)
		·year· = Yr == nil ? nil : yr
		·month· = Mo == nil ? nil : mo
		·day· = Da == nil ? nil : da
		·hour· = Hr == nil ? nil : hr
		·minute· = Mi == nil ? nil : mi
		·second· = Se == nil ? nil : se
		·timezoneOffset· = Tz == nil ? nil : tz
	}

	@usableFromInline
	internal init?(
		year: XSD.Integer?,
		month: XSD.Integer?,
		day: XSD.Integer?,
		hour: XSD.Integer?,
		minute: XSD.Integer?,
		second: XSD.DecimalNumber?,
		timezoneOffset: XSD.Integer?
	) {
		if
			let mo = month,
			!(mo >= 1 && mo <= 12)
		{ return nil }
		if
			let da = day,
			!(da >= 1 && da <= 31)
		{ return nil }
		if
			let hr = hour,
			!(hr >= 0 && hr <= 24)
		{ return nil }
		if
			let mi = minute,
			!(mi >= 0 && mi <= 59)
		{ return nil }
		if
			let se = second,
			!(se >= 0 && se < 60)
		{ return nil }
		if
			let tz = timezoneOffset,
			!(tz >= -840 && tz <= 840)
		{ return nil }
		self.init(
			year,
			month,
			day,
			hour,
			minute,
			second,
			timezoneOffset
		)
	}

	@usableFromInline
	internal class LexicalRepresentation:
		XSD.Literal,
		XSDLexicalRepresentation
	{

		@usableFromInline
		internal typealias Value = Date·timeSevenPropertyModel

	}

}
