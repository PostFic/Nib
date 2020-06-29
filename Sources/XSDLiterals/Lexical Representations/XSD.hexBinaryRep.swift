import XSD

public extension XSD {

	/// Strings of hex (hexadecimal) digits, with two consecutive
	///   digits representing each octet in the corresponding value
	///   (treating the octet as the binary representation of a number
	///   between 0 and 255).
	///
	/// ````
	/// [26]   hexBinary ::= hexOctet*
	/// ````
	///
	///  +  note:
	///     The XSD Specification names this lexical space `hexBinary`;
	///       it is renamed here to avoid a naming conflict with the
	///       `XSD.hexBinary` datatype.
	final class hexBinaryRep: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "([0-9a-fA-F]{2})*"

		public class override var lexicalSpace: XSD.RegularExpression {
			return $pattern
		}

	}

}
