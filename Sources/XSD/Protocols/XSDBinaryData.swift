import Foundation

public protocol XSDBinaryData:
	ExpressibleByArrayLiteral,
	Sequence,
	XSDValue
where
	Self.ArrayLiteralElement == XSD.BinaryOctet,
	Self.Iterator == XSD.Sequence<XSD.BinaryOctet>.Iterator
{

	var data: Data { get }

	var octets: XSD.Sequence<XSD.BinaryOctet> { get }

	init<S: Sequence>(_ data: S) where S.Element == XSD.BinaryOctet

	static func ==<BD: XSDBinaryData>(
		lhs: Self,
		rhs: BD
	) -> Bool

	static func !=<BD: XSDBinaryData>(
		lhs: Self,
		rhs: BD
	) -> Bool

}

public extension XSDBinaryData {

	@inlinable
	var data: Data { Data(octets) }

	init(arrayLiteral elements: Self.ArrayLiteralElement...) {
		self.init(elements)
	}

	func hash(
		into hasher: inout Hasher
	) { for octet in octets { hasher.combine(octet) } }

	@inlinable
	func makeIterator() -> Self.Iterator { octets.makeIterator() }

	@inlinable
	static func ===(
		lhs: Self,
		rhs: Self
	) -> Bool { lhs == rhs }

	@inlinable
	static func ==<BD: XSDBinaryData>(
		lhs: Self,
		rhs: BD
	) -> Bool { lhs.octets.elementsEqual(rhs.octets) }

	@inlinable
	static func !=<BD: XSDBinaryData>(
		lhs: Self,
		rhs: BD
	) -> Bool { !(lhs == rhs) }

	@inlinable
	static func »(
		lhs: Self,
		rhs: Self
	) -> Bool { false }

	@inlinable
	static func «(
		lhs: Self,
		rhs: Self
	) -> Bool { false }

}
