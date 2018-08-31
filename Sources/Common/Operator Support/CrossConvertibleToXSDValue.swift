public protocol CrossConvertibleToXSDValue {

	static func ☆(literal: String, datatype: Self) throws -> XSDValue

}
