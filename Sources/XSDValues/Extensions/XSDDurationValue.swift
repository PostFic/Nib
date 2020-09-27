import XSD

fileprivate let value1 = XSD.DateTimeValue(1696, 9, 1, 0, 0, 0, 0)
fileprivate let value2 = XSD.DateTimeValue(1697, 2, 1, 0, 0, 0, 0)
fileprivate let value3 = XSD.DateTimeValue(1903, 3, 1, 0, 0, 0, 0)
fileprivate let value4 = XSD.DateTimeValue(1903, 7, 1, 0, 0, 0, 0)

public extension XSDDurationValue {

	static func » (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ (value1 + lhs) » (value1 + rhs) && (value2 + lhs) » (value2 + rhs) && (value3 + lhs) » (value3 + rhs) && (value4 + lhs) » (value4 + rhs) }

	static func « (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ (value1 + lhs) « (value1 + rhs) && (value2 + lhs) « (value2 + rhs) && (value3 + lhs) « (value3 + rhs) && (value4 + lhs) « (value4 + rhs) }

}
