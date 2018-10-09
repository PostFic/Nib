import Foundation
import XSD

public protocol XSDDecimalNumber:
	XSDNumber,
	ExpressibleByFloatLiteral
{

	var fraction: Self { get }

	init?<
		DecimalNumber: XSDDecimalNumber,
		Integer: XSDInteger
	>(
		sign: FloatingPointSign,
		exponent: Integer,
		decimal significand: DecimalNumber
	)

}

public extension XSDDecimalNumber {

	var fraction: Self {
		return self - Self(rounding: integer)
	}

	init?<
		DecimalNumber: XSDDecimalNumber,
		Integer: XSDInteger
	>(
		sign: FloatingPointSign,
		exponent: Integer,
		decimal significand: DecimalNumber
	) {
		self.init(
			exactly: NSDecimalNumber(
				decimal: Decimal(
					sign: sign,
					exponent: exponent.intValue,
					significand: significand.decimalValue
				)
			)
		)
	}

}
