public protocol XSDDuration:
	XSDValue
{

	var ·months·: XSD.Integer { get }

	var ·seconds·: XSD.DecimalNumber { get }

	init?(
		months: XSD.Integer,
		seconds: XSD.DecimalNumber
	)

	static func ==<D: XSDDuration>(
		lhs: Self,
		rhs: D
	) -> Bool

	static func !=<D: XSDDuration>(
		lhs: Self,
		rhs: D
	) -> Bool

}

public extension XSDDuration {

	func hash(
		into hasher: inout Hasher
	) {
		hasher.combine(·months·)
		hasher.combine(·seconds·)
	}

	@inlinable
	static func ===(
		lhs: Self,
		rhs: Self
	) -> Bool { lhs == rhs }

	@inlinable
	static func ==<D: XSDDuration>(
		lhs: Self,
		rhs: D
	) -> Bool {
		return lhs.·months· == rhs.·months·
			&& lhs.·seconds· == rhs.·seconds·
	}

	@inlinable
	static func !=<D: XSDDuration>(
		lhs: Self,
		rhs: D
	) -> Bool { !(lhs == rhs) }

}
