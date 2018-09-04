public protocol CrossConvertibleToXSDValue {

	static func ☆<StringType: StringProtocol>(
		representation: StringType,
		datatype: Self
	) throws -> XSDValue

}
