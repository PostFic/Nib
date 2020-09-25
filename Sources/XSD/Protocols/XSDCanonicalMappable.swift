public protocol XSDCanonicalMappable:
	Codable,
	LosslessStringConvertible,
	TextOutputStreamable,
	XSDValue
{

	var ·canonicalMapping·: Self.LexicalRepresentation { get }

}

public extension XSDCanonicalMappable {

	@inlinable
	var description: String { String(describing: ·canonicalMapping·) }

	@inlinable
	init(
		from decoder: Decoder
	) throws { try self = Self.LexicalRepresentation(from: decoder).·lexicalMapping· }

	@inlinable
	func encode(
		to encoder: Encoder
	) throws { try ·canonicalMapping·.encode(to: encoder) }

	@inlinable
	func write<Target: TextOutputStream>(
		to target: inout Target
	) { ·canonicalMapping·.write(to: &target) }

}

