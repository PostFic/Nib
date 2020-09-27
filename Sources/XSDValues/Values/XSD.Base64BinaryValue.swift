import Foundation
import XSD

extension XSD {

	public struct Base64BinaryValue:
		XSDBinaryDataValue
	{

		public let octets: XSD.Sequence <XSD.BinaryOctet>

		public init <S> (
			_ data: S
		) where
			S: Swift.Sequence,
			S.Element == XSD.BinaryOctet
		{
			self.octets = sequence(
				state: data.makeIterator()
			) { state in
				var nextState = state as! S.Iterator
				let result = nextState.next()
				state = nextState
				return result
			}
		}

	}

}
