import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.stringRep` to a `XSD.StringValue`.
	///
	///  +  parameters:
	///      +  LEX:
	///         A `XSD.stringRep`.
	///
	///  +  returns:
	///     A `XSD.StringValue`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-stringLexmap>
	@inlinable
	static func ·stringLexicalMap· (
		_ LEX: XSD.stringRep
	) -> XSD.StringValue
	{ XSD.StringValue(LEX) }

}
