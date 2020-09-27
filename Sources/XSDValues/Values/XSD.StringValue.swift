import XSD

fileprivate let XMLChar = XSD.RegularExpression("[\u{1}-\u{D7FF}|\u{E000}-\u{FFFD}|\u{10000}-\u{10FFFF}]*")!

extension XSD {

	public struct StringValue:
		XSDStringValue
	{

		public let description: String

		public init? (
			_ description: String
		) {
			guard XMLChar.·matches·(description)
			else
			{ return nil }
			self.description = description
		}


	}

}
