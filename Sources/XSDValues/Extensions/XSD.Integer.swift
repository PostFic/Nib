import XSD

public extension XSD.Integer {

	init?<N: XSDNumber>(
		_ value: N
	) {
		guard let integer = value.integer else { return nil }
		self = integer
	}

}

extension XSD.Integer: XSDNumberConvertible {}
