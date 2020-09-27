import Foundation
import XSD
import XSDLiterals
import XSDValues

extension XSD.Base64BinaryValue:
	XSDCanonicalMappable
{

	public typealias LexicalRepresentation = XSD.Base64Binary

	public var ·canonicalMapping·: XSD.Base64BinaryValue.LexicalRepresentation
	{ XSD.Base64BinaryValue.LexicalRepresentation(data.base64EncodedString())! }

	public init (
		mapping literal: XSD.Base64BinaryValue.LexicalRepresentation
	) {
		self.init(
			Data(
				base64Encoded: String(literal),
				options: .ignoreUnknownCharacters
			)!
		)
	}

}
