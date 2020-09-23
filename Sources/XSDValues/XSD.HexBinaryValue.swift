import XSD
import XSDLiterals

extension XSD {

	public struct HexBinaryValue:
		XSDBinaryData,
		XSDCanonicalMappable
	{

		public typealias LexicalRepresentation = XSD.hexBinaryRep

		public var canonicalMapping:
			XSD.HexBinaryValue.LexicalRepresentation
		{ XSD.·hexBinaryCanonical·(self) }

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
			mapping literal: XSD.HexBinaryValue.LexicalRepresentation
		) { self = XSD.·hexBinaryMap·(literal) }

	}

}
