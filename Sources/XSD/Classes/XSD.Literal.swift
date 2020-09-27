extension XSD {

	/// A string, optionally belonging to a particular lexical space.
	///
	/// The `XSD.Literal` class is used to assert that strings actually belong to a given lexical space, as the initializer will fail for strings which are out‐of‐bounds.
	/// The underlying `description` property contains the actual string.
	open class Literal:
		Codable,
		LosslessStringConvertible
	{

		/// The string value of the literal.
		public let description: String

		/// Initializes the `XSD.Literal`, ensuring that the provided `literal` is within its `·lexicalSpace·`.
		/// Fails otherwise.
		///
		///  +  parameters:
		///      +  literal:
		///         Another `XSD.Literal`.
		public required init? <L> (
			_ literal: L
		) where L: XSD.Literal
		{
			if L.·lexicalSpace· == Self.·lexicalSpace·
			{ description = literal.description }
			else if
				let lexicalSpace = Self.·lexicalSpace·,
				!lexicalSpace.·matches·(literal.description)
			{ return nil }
			else
			{ description = literal.description }
		}

		/// Initializes the `XSD.Literal`, ensuring that the provided `representation` is within its `·lexicalSpace·`.
		/// Fails otherwise.
		///
		///  +  parameters:
		///      +  representation:
		///         The string value of the `XSD.Literal`, as a `String`.
		public required init? (
			_ representation: String = ""
		) {
			if
				let lexicalSpace = Self.·lexicalSpace·,
				!lexicalSpace.·matches·(representation)
			{ return nil }
			else
			{ description = representation }
		}

		/// Initializes the `XSD.Literal`, ensuring that the provided `representation` is within its `·lexicalSpace·`.
		/// Fails otherwise.
		///
		///  +  parameters:
		///      +  representation:
		///         The string value of the `XSD.Literal`, as an instance conforming to `StringProtocol`.
		@inlinable
		public required convenience init? <S> (
			_ representation: S
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

		/// An (optional) `XSD.RegularExpression` which defines the lexical space of the literal.
		/// If `nil`, this `XSD.Literal` does not have an associated lexical space.
		@inlinable
		open class var ·lexicalSpace·: XSD.RegularExpression? { nil }

	}

}

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
	///     `true` if the literals represent the same string; `false` otherwise.
	///
	/// Equality is determined based on the `description` string of the literal.
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
