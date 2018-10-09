public protocol XSDRegularExpression: XSDAtomicValue {

	func test<Literal: XSDLiteral>(_ literal: Literal) -> Bool

}
