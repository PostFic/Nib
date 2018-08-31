public protocol CrossConvertibleToXSDLiteral {

	static func ⤱(literal: String, datatype: Self) -> XSDLiteral

}
