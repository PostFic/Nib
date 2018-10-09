public protocol XSDSequence:
	Sequence,
	XSDValue
where Element: XSDAtomicValue {}

public extension XSDSequence {

	var stringValue: String {
		return self.reduce(into: "") { $0 += " , " + $1.stringValue }
	}

}
