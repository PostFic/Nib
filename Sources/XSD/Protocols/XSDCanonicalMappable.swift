public protocol XSDCanonicalMappable:
	Codable,
	ExpressibleByStringLiteral,
	LosslessStringConvertible,
	TextOutputStreamable,
	XSDValue
where Self.StringLiteralType == String {

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
	init(
		stringLiteral: Self.StringLiteralType
	) { self.init(mapping: stringLiteral◊) }

	@inlinable
	func encode(
		to encoder: Encoder
	) throws { try String(describing: self).encode(to: encoder) }

	@inlinable
	func write<Target: TextOutputStream>(
		to target: inout Target
	) { target.write(String(describing: self)) }

}

