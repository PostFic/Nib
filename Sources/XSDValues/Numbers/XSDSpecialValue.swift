import Foundation

public protocol XSDSpecialValue:
	XSDNumber,
	SignedNumeric
{

	var isInfinite: Bool { get }

	var isNaN: Bool { get }

	func signum() -> Integer

}

public extension XSDSpecialValue {

	func signum() -> Integer {
		guard !isNaN && self != 0 else {
			return 0
		}
		return self < 0 ? -1 : 1
	}

}
