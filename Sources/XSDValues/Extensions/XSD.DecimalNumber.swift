import Foundation
import XSD

extension XSD.DecimalNumber: XSDNumberConvertible {

	@inlinable
	public static func ◊<N: XSDNumber>(
		lhs: XSD.DecimalNumber,
		rhs: N.Type
	) -> N { N(exactly: lhs)! }

	@inlinable
	public static func ¿◊?<N: XSDNumber>(
		lhs: XSD.DecimalNumber,
		rhs: N.Type
	)-> N? { N(exactly: lhs) }

	@inlinable
	public static postfix func ◊<N: XSDNumber>(
		operand: XSD.DecimalNumber
	) -> N { N(exactly: operand)! }

	@inlinable
	public static postfix func ◊?<N: XSDNumber>(
		operand: XSD.DecimalNumber
	) -> N? { N(exactly: operand) }

}
