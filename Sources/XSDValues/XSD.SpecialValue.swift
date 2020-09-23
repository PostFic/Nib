import XSD
import XSDLiterals

extension XSD {

	/// A named value which is distinct from, and unequal to, all other
	///   values.
	public enum SpecialValue: String {

		/// A `positiveInfinity` value.
		case positiveInfinity

		/// A `positiveZero` value.
		case positiveZero

		/// A `negativeInfinity` value.
		case negativeInfinity

		/// A `negativeZero` value.
		case negativeZero

		/// A `notANumber` value.
		case notANumber

	}

}

extension XSD.SpecialValue: XSDNumberConvertible {

	public static func ◊<N: XSDNumber>(
		lhs: XSD.SpecialValue,
		rhs: N.Type
	) -> N { N(exactly: lhs)! }

	public static func ¿◊?<N: XSDNumber>(
		lhs: XSD.SpecialValue,
		rhs: N.Type
	)-> N? { N(exactly: lhs) }

	public static postfix func ◊<N: XSDNumber>(
		operand: XSD.SpecialValue
	) -> N { N(exactly: operand)! }

	public static postfix func ◊?<N: XSDNumber>(
		operand: XSD.SpecialValue
	) -> N? { N(exactly: operand) }

}
