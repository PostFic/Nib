import XSD

extension XSD {

	public enum BooleanValue:
		String,
		XSDBooleanValue
	{

		case `true`

		case `false`

		@inlinable
		public var bool: Bool
		{ return self.rawValue == "true" }

		@inlinable
		public init (
			_ value: Bool
		) { self = value ? .true : .false }

		public func hash(
			into hasher: inout Hasher
		) { hasher.combine(self.bool) }

	}

}
