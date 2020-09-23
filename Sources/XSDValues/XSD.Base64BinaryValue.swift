import Foundation
import XSD
import XSDLiterals

extension XSD {

	public struct Base64BinaryValue:
		XSDBinaryData,
		XSDCanonicalMappable
	{

		public typealias LexicalRepresentation = XSD.Base64Binary

		public var ·canonicalMapping·:
			XSD.Base64BinaryValue.LexicalRepresentation
		{ data.base64EncodedString()◊ }

		public let octets: XSD.Sequence<XSD.BinaryOctet>

		public init<S: Swift.Sequence>(
			_ data: S
		) where S.Element == XSD.BinaryOctet {
			self.octets = sequence(
				state: data.makeIterator()
			) { state in
				var nextState = state as! S.Iterator
				let result = nextState.next()
				state = nextState
				return result
			}
		}

		public init(
			mapping literal:
				XSD.Base64BinaryValue.LexicalRepresentation
		) {
			self.init(
				Data(
					base64Encoded: String(describing: literal),
					options: .ignoreUnknownCharacters
				)!
			)
		}

	}

}
