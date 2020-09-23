import XSD

public protocol XSDDuration {

	var ·months·: XSD.Integer { get }

	var ·seconds·: XSD.DecimalNumber { get }

	init?(
		months: XSD.Integer,
		seconds: XSD.DecimalNumber
	)

}
