import XSD

fileprivate let value1 = XSD.DateTimeValue(mapping: "1696-09-01T00:00:00Z"◊)
fileprivate let value2 = XSD.DateTimeValue(mapping: "1697-02-01T00:00:00Z"◊)
fileprivate let value3 = XSD.DateTimeValue(mapping: "1903-03-01T00:00:00Z"◊)
fileprivate let value4 = XSD.DateTimeValue(mapping: "1903-07-01T00:00:00Z"◊)

public extension XSDDuration {

	static func »(
		lhs: Self,
		rhs: Self
	) -> Bool {
		return (value1 + lhs) » (value1 + rhs)
			&& (value2 + lhs) » (value2 + rhs)
			&& (value3 + lhs) » (value3 + rhs)
			&& (value4 + lhs) » (value4 + rhs)
	}

	static func «(
		lhs: Self,
		rhs: Self
	) -> Bool {
		return (value1 + lhs) « (value1 + rhs)
			&& (value2 + lhs) « (value2 + rhs)
			&& (value3 + lhs) « (value3 + rhs)
			&& (value4 + lhs) « (value4 + rhs)
	}

}
