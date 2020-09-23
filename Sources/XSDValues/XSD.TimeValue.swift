import XSD
import XSDLiterals

extension XSD {

	/// A structure representing the XSD Date/time Seven‐property
	///   Model.
	public struct TimeValue:
		XSDDate·timeSevenPropertyModel,
		XSDCanonicalMappable
	{
		
		public typealias LexicalRepresentation = XSD.timeLexicalRep

		public var canonicalMapping:
			XSD.TimeValue.LexicalRepresentation
		{ return XSD.·timeCanonicalMap·(self) }

		public let ·day·: XSD.Integer? = nil

		public let ·hour·: XSD.Integer?

		public let ·minute·: XSD.Integer?

		public let ·month·: XSD.Integer? = nil

		public let ·second·: XSD.DecimalNumber?

		public let ·timezoneOffset·: XSD.Integer?

		public let ·year·: XSD.Integer? = nil

		public init(
			mapping literal: XSD.TimeValue.LexicalRepresentation
		) {
			let T = XSD.·timeLexicalMap·(literal)
			·hour· = T.·hour·
			·minute· = T.·minute·
			·second· = T.·second·
			·timezoneOffset· = T.·timezoneOffset·
		}
		
		public init?(
			year: XSD.Integer? = nil,
			month: XSD.Integer? = nil,
			day: XSD.Integer? = nil,
			hour: XSD.Integer?,
			minute: XSD.Integer?,
			second: XSD.DecimalNumber?,
			timezoneOffset: XSD.Integer?
		) {
			guard
				year == nil,
				month == nil,
				day == nil,
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
			·hour· = d7m.·hour·
			·minute· = d7m.·minute·
			·second· = d7m.·second·
			·timezoneOffset· = d7m.·timezoneOffset·
		}

	}

}
