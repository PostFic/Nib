import Foundation
import XSD
import XSDLiterals

extension XSD {

	public struct DoubleValue:
		XSDCanonicalMappable,
		XSDNumberValue
	{

		public typealias LexicalRepresentation = XSD.doubleRep

		public var ·canonicalMapping·:
			XSD.DoubleValue.LexicalRepresentation
		{ return XSD.·doubleCanonicalMap·(self) }

		public var decimalNumber: XSD.DecimalNumber? {
			guard specialValue == nil else { return nil }
			return XSD.DecimalNumber(value)
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

		let value: Double

		public init?(
			exactly value: XSD.DecimalNumber
		) {
			if let double = Double(exactly: value as NSNumber) {
				self.value = double
			} else { return nil }
		}

		public init?(
			exactly value: XSD.SpecialValue
		) { self.init(truncating: value) }

		public init(floatLiteral value: Double) { self.value = value }

		public init(
			mapping literal: XSD.DoubleValue.LexicalRepresentation
		) { self = XSD.·doubleLexicalMap·(literal) }

		public init(
			truncating value: XSD.DecimalNumber
		) { self.value = Double(truncating: value as NSNumber) }

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
