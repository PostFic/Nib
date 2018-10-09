import Foundation

public protocol XSDDecimalNumberOrSpecialValue:
	XSDDecimalNumber,
	XSDSpecialValue
{

	var isFinite: Bool { get }

}

public extension XSDDecimalNumberOrSpecialValue {

	var isFinite: Bool {
		return !isInfinite && !isNaN
	}

}
