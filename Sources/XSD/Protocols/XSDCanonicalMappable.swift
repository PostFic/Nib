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
	) throws {
		if let result = try Self(String(from: decoder)) {
			self = result
		} else { throw XSD.Error.notInLexicalSpace }
	}

	@inlinable
	func encode(
		to encoder: Encoder
	) throws { try String(describing: self).encode(to: encoder) }

	@inlinable
	func write<Target: TextOutputStream>(
		to target: inout Target
	) { target.write(String(describing: self)) }

}

