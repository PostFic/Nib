public protocol XSDSet:
	Collection,
	SetAlgebra,
	XSDValue
where Element: XSDAtomicValue {}

public extension XSDSet {

	var stringValue: String {
		return self.reduce(into: "") { $0 += " " + $1.stringValue }
	}

}
