import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.StringValue` to a `XSD.stringRep`.
	///
	///  +  parameters:
	///      +  s:
	///         A `XSD.StringValue`.
	///
	///  +  returns:
	///     A `XSD.stringRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-stringCanmap>
	@inlinable
	static func ·stringCanonicalMap·(
		_ s: XSD.StringValue
	) -> XSD.stringRep { return s.string◊ }

}
