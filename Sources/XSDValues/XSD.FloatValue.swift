import Foundation
import XSD
import XSDLiterals

extension XSD {

	public struct FloatValue:
		XSDCanonicalMappable,
		XSDNumber
	{

		public typealias LexicalRepresentation = XSD.floatRep

		public var ·canonicalMapping·:
			XSD.FloatValue.LexicalRepresentation
		{ return XSD.·floatCanonicalMap·(self) }

		public var decimalNumber: XSD.DecimalNumber? {
			guard specialValue == nil else { return nil }
			return (value as NSNumber).decimalValue
		}

		public var specialValue: XSD.SpecialValue? {
			if value.isNaN { return .notANumber }
			else {
				switch value.floatingPointClass {
				case .negativeInfinity:
					return .negativeInfinity
				case .negativeZero:
					return .negativeZero
				case .positiveInfinity:
					return .positiveInfinity
				case .positiveZero:
					return .positiveZero
				default:
					return nil
				}
			}
		}

		let value: Float

		public init?(
			exactly value: XSD.DecimalNumber
		) {
			if let float = Float(exactly: value as NSNumber) {
				self.value = float
			} else { return nil }
		}

		public init?(
			exactly value: XSD.SpecialValue
		) { self.init(truncating: value) }

		public init(
			mapping literal: XSD.FloatValue.LexicalRepresentation
		) {
			self = XSD.·floatLexicalMap·(literal)
		}

		public init(
			truncating value: XSD.DecimalNumber
		) { self.value = Float(truncating: value as NSNumber) }

		public init(
			truncating value: XSD.SpecialValue
		) {
			switch value {
			case .negativeInfinity:
				self.value = -.infinity
			case .negativeZero:
				self.value = -0.0
			case .notANumber:
				self.value = .nan
			case .positiveInfinity:
				self.value = .infinity
			case .positiveZero:
				self.value = 0.0
			}
		}

	}

}
