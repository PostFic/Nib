public protocol CrossConvertibleToValue {

	static func ☆(literal: String, datatype: Self) throws -> XSDValue

}
