import XSD

public extension XSD {

	/// A `XSD.duDayFrag` and/or `XSD.duTimeFrag`, in order.
	///
	/// ````
	/// [14]   duDayTimeFrag ::= (duDayFrag duTimeFrag?) | duTimeFrag
	/// ````
	final class duDayTimeFrag: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = """
			[0-9]+D(T(\
			[0-9]+H([0-9]+M)?([0-9]+S)?|\
			[0-9]+M([0-9]+S)?|\
			[0-9]+S\
			))?|T(\
			[0-9]+H([0-9]+M)?([0-9]+(\\.[0-9]+)?S)?|\
			[0-9]+M([0-9]+(\\.[0-9]+)?S)?|\
			[0-9]+(\\.[0-9]+)?S\
			)
			"""

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
