import Foundation
import XSD

public protocol XSDBinaryData:
	Hashable,
	Sequence
where Self.Iterator == XSD.Sequence<XSD.BinaryOctet>.Iterator {

	var data: Data { get }

	var octets: XSD.Sequence<XSD.BinaryOctet> { get }

	init<S: Sequence>(_ data: S) where S.Element == XSD.BinaryOctet

}

public extension XSDBinaryData {

	@inlinable
	var data: Data { Data(octets) }

	func hash(
		into hasher: inout Hasher
	) { for octet in octets { hasher.combine(octet) } }

	@inlinable
	func makeIterator() -> Self.Iterator { octets.makeIterator() }

	@inlinable
	static func ==(
		lhs: Self,
		rhs: Self
	) -> Bool { lhs.octets.elementsEqual(rhs.octets) }

}
