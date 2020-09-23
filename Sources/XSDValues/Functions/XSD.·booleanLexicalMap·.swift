import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.booleanRep` to a `XSD.BooleanValue`.
	///
	///  +  parameters:
	///      +  LEX:
	///         A `XSD.booleanRep`.
	///
	///  +  returns:
	///     A `XSD.BooleanValue`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-booleanLexmap>
	@inlinable
	static func ·booleanLexicalMap·(
		_ LEX: XSD.booleanRep
	) -> XSD.BooleanValue {
		return (
			String(describing: LEX) == "true"
				|| String(describing: LEX) == "1"
		) ? .true : .false
	}

}
