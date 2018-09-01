public protocol CrossConvertibleToXSDValue {

	static func ☆(literal: String, datatype: Self) throws -> XSDValue

	static func ?☆(literal: String?, datatype: Self) throws -> XSDValue?

}

public extension CrossConvertibleToXSDValue {

	static func ?☆(literal: String?, datatype: Self) throws -> XSDValue? {
		guard let theLiteral = literal else {
			return nil
		}
		return try theLiteral☆datatype
	}

}
