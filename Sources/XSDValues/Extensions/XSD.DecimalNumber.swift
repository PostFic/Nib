import Foundation
import XSD

extension XSD.DecimalNumber: XSDNumberConvertible {

	@inlinable
	public static postfix func ◊?<N: XSDNumber>(
		operand: XSD.DecimalNumber
	) -> N? { N(exactly: operand) }

}
