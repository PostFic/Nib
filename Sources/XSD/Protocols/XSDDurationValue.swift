public protocol XSDDurationValue:
	XSDValue
{

	var ·months·: XSD.Integer
	{ get }

	var ·seconds·: XSD.DecimalNumber
	{ get }

	init? (
		months: XSD.Integer,
		seconds: XSD.DecimalNumber
	)

	static func == <D> (
		lhs: Self,
		rhs: D
	) -> Bool
	where D: XSDDurationValue

	static func != <D> (
		lhs: Self,
		rhs: D
	) -> Bool
	where D: XSDDurationValue

}

public extension XSDDurationValue {

	func hash (
		into hasher: inout Hasher
	) {
		hasher.combine(·months·)
		hasher.combine(·seconds·)
	}

	@inlinable
	static func === (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ lhs == rhs }

	@inlinable
	static func == <D> (
		lhs: Self,
		rhs: D
	) -> Bool
	where D: XSDDurationValue
	{ lhs.·months· == rhs.·months· && lhs.·seconds· == rhs.·seconds· }

	@inlinable
	static func != <D> (
		lhs: Self,
		rhs: D
	) -> Bool
	where D: XSDDurationValue
	{ !(lhs == rhs) }

}
