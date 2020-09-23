import XSD
import XSDLiterals

extension XSD {

	public struct DurationValue:
		XSDCanonicalMappable,
		XSDDuration
	{
		
		public typealias LexicalRepresentation = XSD.durationLexicalRep

		public var ·canonicalMapping·:
			XSD.DurationValue.LexicalRepresentation
		{ return XSD.·durationCanonicalMap·(self) }

		public let ·months·: XSD.Integer

		public let ·seconds·: XSD.DecimalNumber

		public init(
			mapping literal: XSD.DurationValue.LexicalRepresentation
		) { self = XSD.·durationMap·(literal) }
		
		public init(_ mo: XSD.Integer, _ se: XSD.DecimalNumber) {
			guard
				mo == 0
				|| se == 0
				|| XSD.DecimalNumber(mo).sign == se.sign
			else {
				fatalError(
					"""
					Expected the sign of \(mo) to match that of \(se).
					"""
				)
			}
			self.·months· = mo
			self.·seconds· = se
		}

		public init?(months: XSD.Integer, seconds: XSD.DecimalNumber) {
			guard
				months == 0
					|| seconds == 0
					|| XSD.DecimalNumber(months).sign == seconds.sign
			else {
				return nil
			}
			self.·months· = months
			self.·seconds· = seconds
		}

	}

}
