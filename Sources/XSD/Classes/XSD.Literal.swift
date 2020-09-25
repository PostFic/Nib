extension XSD {

	/// A string, optionally belonging to a particular lexical space.
	///
	/// The `XSD.Literal` class is used to assert that strings actually
	///   belong to a given lexical space, as the initializer will fail
	///   for strings which are out‐of‐bounds.
	/// The underlying `description` property contains the actual
	///   string.
	open class Literal:
		Codable,
		LosslessStringConvertible
	{

		/// The string value of the literal.
		public let description: String

		/// Initializes the literal, ensuring that the provided
		///   `description` is within its `·lexicalSpace·`.
		/// Fails otherwise.
		///
		///  +  parameters:
		///      +  description:
		///         The string value of the literal.
		public required init? (
			_ description: String = ""
		) {
			if let lexicalSpace = Self.·lexicalSpace· {
				guard lexicalSpace.·matches·(description)
				else { return nil }
			}
			self.description = description
		}

		/// Initializes the literal, ensuring that the provided
		///   `representation` is within its `·lexicalSpace·`.
		/// Fails otherwise.
		///
		///  +  parameters:
		///      +  representation:
		///         The string value of the literal.
		@inlinable
		public convenience init? <S> (
			_ representation: S = ""
		) where S: StringProtocol
		{ self.init(String(representation)) }

		@inlinable
		public required convenience init (
			from decoder: Decoder
		) throws {
			try self.init(
				String(
					from: decoder
				)
			)!
		}

		@inlinable
		public final func encode (
			to encoder: Encoder
		) throws {
			try String(
				describing: self
			).encode(
				to: encoder
			)
		}

		/// An (optional) `XSD.RegularExpression` which defines the
		///   lexical space of the literal.
		/// If `nil`, this literal does not have an associated lexical
		///   space.
		@inlinable
		open class var ·lexicalSpace·: XSD.RegularExpression? { nil }

	}

}

public extension XSD.Literal {

	@inlinable
	final class func + (
		lhs: XSD.Literal,
		rhs: XSD.Literal
	) -> XSD.Literal
	{ XSD.Literal(lhs.description + rhs.description)! }

	@inlinable
	final class func + <S> (
		lhs: XSD.Literal,
		rhs: S
	) -> XSD.Literal
	where S: StringProtocol
	{ XSD.Literal(lhs.description + rhs)! }

	@inlinable
	final class func + <S> (
		lhs: S,
		rhs: XSD.Literal
	) -> XSD.Literal
	where S: StringProtocol
	{ XSD.Literal(lhs + rhs.description)! }
	
}

extension XSD.Literal: XSDLiteralConvertible {}

extension XSD.Literal: Equatable {

	/// Tests to see if two literals are equal.
	///
	///  +  parameters:
	///      +  lhs:
	///         A `XSD.Literal`.
	///      +  rhs:
	///         A `XSD.Literal`.
	///
	///  +  returns:
	///     `true` if the literals represent the same string; `false`
	///       otherwise.
	///
	/// Equality is determined based on the `description` string of the
	///   literal.
	/// It does not test against lexical space.
	@inlinable
	public final class func == (
		lhs: XSD.Literal,
		rhs: XSD.Literal
	) -> Bool
	{ lhs.description == rhs.description }

}

extension XSD.Literal: Hashable {

	public func hash (
		into hasher: inout Hasher
	) { hasher.combine(description) }

}

extension XSD.Literal: TextOutputStreamable {

	@inlinable
	public func write <Target> (
		to target: inout Target
	) where Target: TextOutputStream
	{ target.write(self.description) }

}
