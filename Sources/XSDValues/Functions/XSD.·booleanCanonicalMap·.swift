import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.BooleanValue` to a `XSD.booleanRep`.
	///
	///  +  parameters:
	///      +  b:
	///         A `XSD.BooleanValue`.
	///
	///  +  returns:
	///     A `XSD.booleanRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-booleanCanmap>
	@inlinable
	static func ·booleanCanonicalMap· (
		_ b: XSD.BooleanValue
	) -> XSD.booleanRep
	{ XSD.booleanRep(b.rawValue)! }

}
