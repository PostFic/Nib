import XSD

public extension XSD {

	/// A four (or more)–digit year, possibly negative.
	///
	/// ````
	/// [56]   yearFrag ::= '-'? (([1-9] digit digit digit+)) | ('0' digit digit digit))
	/// ````
	///
	///  +  note:
	///     The EBNF provided by the XSD specification (above) has an
	///       extraneous closing parenthesis after `"digit+"`.
	final class yearFrag: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "-?([1-9][0-9]{3,}|[0-9]{4})"

		public class override var ·lexicalSpace·: XSD.RegularExpression
		{ return $pattern }

	}

}
