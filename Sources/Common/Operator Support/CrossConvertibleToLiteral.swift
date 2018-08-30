public protocol CrossConvertibleToLiteral {

	static func ⤱(literal: String, datatype: Self) -> XSDLiteral

}
