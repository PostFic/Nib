public protocol StringCrossConvertible {

	static func ⤱(literal: String, datatype: Self) throws -> XSDLiteral

}
