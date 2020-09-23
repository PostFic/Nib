import XSD
import XSDLiterals

extension XSD {

	/// A structure representing the XSD Date/time Seven‐property
	///   Model.
	public struct DateTimeValue:
		XSDDate·timeSevenPropertyModel,
		XSDCanonicalMappable
	{
		
		public typealias LexicalRepresentation = XSD.dateTimeLexicalRep

		public var ·canonicalMapping·:
			XSD.DateTimeValue.LexicalRepresentation
		{ return XSD.·dateTimeCanonicalMap·(self) }

		public let ·day·: XSD.Integer?

		public let ·hour·: XSD.Integer?

		public let ·minute·: XSD.Integer?

		public let ·month·: XSD.Integer?

		public let ·second·: XSD.DecimalNumber?

		public let ·timezoneOffset·: XSD.Integer?

		public let ·year·: XSD.Integer?

		public init(
			mapping literal: XSD.DateTimeValue.LexicalRepresentation
		) { self = XSD.·dateTimeLexicalMap·(literal) }
		
		public init?(
			year: XSD.Integer?,
			month: XSD.Integer?,
			day: XSD.Integer?,
			hour: XSD.Integer?,
			minute: XSD.Integer?,
			second: XSD.DecimalNumber?,
			timezoneOffset: XSD.Integer?
		) {
			guard
				year != nil,
				month != nil,
				day != nil,
				hour != nil,
				minute != nil,
				second != nil,
				let d7m = Date·timeSevenPropertyModel(
					year: year,
					month: month,
					day: day,
					hour: hour,
					minute: minute,
					second: second,
					timezoneOffset: timezoneOffset
				)
			else { return nil }
			·year· = d7m.·year·
			·month· = d7m.·month·
			·day· = d7m.·day·
			·hour· = d7m.·hour·
			·minute· = d7m.·minute·
			·second· = d7m.·second·
			·timezoneOffset· = d7m.·timezoneOffset·
		}

	}

}
