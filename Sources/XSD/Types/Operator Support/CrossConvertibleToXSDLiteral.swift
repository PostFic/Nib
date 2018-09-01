public protocol CrossConvertibleToXSDLiteral {

	static func ⤱(literal: String, datatype: Self) -> XSDLiteral

	static func ?⤱(literal: String?, datatype: Self) -> XSDLiteral?

}

public extension CrossConvertibleToXSDLiteral {

	static func ?⤱(literal: String?, datatype: Self) -> XSDLiteral? {
		guard let theLiteral = literal else {
			return nil
		}
		return theLiteral⤱datatype
	}

}
