public protocol CrossConvertibleToXSDLiteral {

	static func ⤱<StringType: StringProtocol>(
		literal: StringType,
		datatype: Self
	) -> XSDLiteral

	static func ⤱?<StringType: StringProtocol>(
		literal: StringType,
		datatype: Self
	) -> XSDLiteral?

}

public extension CrossConvertibleToXSDLiteral {

	static func ⤱?<StringType: StringProtocol>(
		literal: StringType,
		datatype: Self
	) -> XSDLiteral? {
		let result = literal⤱datatype
		guard result.value != nil else {
			return nil
		}
		return result
	}

}
