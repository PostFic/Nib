import Foundation
import XSD

public extension XSD {

	/// An XSD regular expression.
	///
	/// Inherits from `NSRegularExpression` and has all the same
	///   properties and methods.
	/// Unlike normal `NSRegularExpression`s, `XSD.RegularExpression`s
	///   are implicitly anchored at the head and tail.
	///
	///  +  Note:
	///     The syntax and supported escapes for XSD Regular
	///       Expressions differs somewhat from that used by
	///       Foundation.
	///     `XSD.RegularExpression` does its best to bridge this
	///       divide, and is able to support all of the regular
	///       expressions used as `pattern`s for the XSD base
	///       datatypes.
	///     However, there is a chance that exceedingly complicated
	///       regular expressions might behave in an unexpected manner.
	///
	///  +  Note:
	///     Foundation does not support XSD's `\p{Is…}` syntax, which
	///       will be passed through unmodified.
	///     Using this syntax will likely result in an error.
	///
	///  +  Note:
	///     `XSD.RegularExpression` is not sophisticated enough to
	///       completely parse the given pattern; this task is left to
	///       `NSRegularExpression` and Foundation.
	///     However, Foundation will likely accept some regular
	///       expressions which would be in error under XSD syntax,
	///       because its rules regarding atoms and metacharacters are
	///       less restrictive.
	///     Be sure to double‐check that your regular expressions meet
	///       the syntax requirements of XSD.
	struct RegularExpression: CustomStringConvertible {

		/// Wraps a string to associate it with a regular expression,
		///   used for defining the static lexical spaces of literals.
		///
		/// Only use with strings which are known to be valid regular
		///   expressions, or a runtime error may result.
		@propertyWrapper
		internal struct Wrapper {

			/// The wrapped string.
			let wrappedValue: String

			/// The compiled regular expression represented by the
			///   string.
			let projectedValue: XSD.RegularExpression

			/// Forces a compilation of the wrapped string into its
			///   projected regular expression.
			///
			///  +  parameters:
			///      +  wrappedValue:
			///         The string value to be wrap.
			init(wrappedValue: String) {
				self.wrappedValue = wrappedValue
				self.projectedValue =
					XSD.RegularExpression(wrappedValue)!
			}

		}

		/// The string representation of the regular expression.
		public let description: String

		/// The underlying `NSRegularExpression` which this regular
		///   expression is (hopefully) equivalent to.
		public let nsRegularExpression: NSRegularExpression

		/// Attempts to create a regular expression from a string.
		/// Fails if the input is not a valid XSD regular expression.
		///
		///  +  parameters:
		///      +  description:
		///         The XSD regular expression source.
		public init?(_ description: String) {
			guard  //  only XML characters
				try! NSRegularExpression(
					pattern: """
						[^\\x{1}-\\x{D7FF}\
						\\x{E000}-\\x{FFFD}\
						\\x{10FFFF}]
						"""
				).firstMatch(
					in: description,
					range: NSMakeRange(0, (description as NSString).length)
				) == nil
			else { return nil }
			guard  //  no unsupported escape sequences
				try! NSRegularExpression(
					pattern: """
						\(XSD.RegularExpression.unescaped)\
						\\\\[^nrt\\\\|\
						\\.?*+(){}\\x2D\\x5B\\x5D\\x5EpPsSiIcCdDwW]
						"""
				).firstMatch(
					in: description,
					range: NSMakeRange(0, (description as NSString).length)
				) == nil
			else { return nil }
			var swiftPattern = description
			XSD.RegularExpression.replaceIn(  //  escape `?` in `(?`
				string: &swiftPattern,
				"(\(XSD.RegularExpression.unescaped)\\()\\?",
				"$1\\\\?"
			)
			XSD.RegularExpression.replaceIn(  //  character groups
				string: &swiftPattern,
				"""
					(\(XSD.RegularExpression.unescaped))\
					\\[(\\^?(?:\(XSD.RegularExpression.singleChar)|\
					\(XSD.RegularExpression.charRange)|\
					\(XSD.RegularExpression.charClassEsc))+)-\\[(.+)]]
					""",
				"$1(?:(?![$3])[$2])"
			)
			XSD.RegularExpression.replaceIn(  //  escape second `?`/`+`
				string: &swiftPattern,
				"""
					(\(XSD.RegularExpression.unescaped)\
					(?:[*+?]|\\{\\d+,\\d*\\}))([?+])
					""",
				"$1\\\\$2"
			)
			XSD.RegularExpression.replaceIn(  //  escape `^`/`$`/etc.
				string: &swiftPattern,
				"(\\A\\^|\\$\\z)", "\\\\$1"
			)
			XSD.RegularExpression.replaceIn(  //  `.`
				string: &swiftPattern,
				"(\(XSD.RegularExpression.unescaped))\\.",
				"$1[^\(XSD.RegularExpression.lineChar)]"
			)
			XSD.RegularExpression.replaceIn(  //  `\s`
				string: &swiftPattern,
				"(\(XSD.RegularExpression.unescaped))\\\\s",
				"$1[\(XSD.RegularExpression.spaceChar)]"
			)
			XSD.RegularExpression.replaceIn(  //  `\S`
				string: &swiftPattern,
				"(\(XSD.RegularExpression.unescaped))\\\\S",
				"$1[^\(XSD.RegularExpression.spaceChar)]"
			)
			XSD.RegularExpression.replaceIn(  //  `\i`
				string: &swiftPattern,
				"(\(XSD.RegularExpression.unescaped))\\\\i",
				"$1[\(XSD.RegularExpression.startChar)]"
			)
			XSD.RegularExpression.replaceIn(  //  `\I`
				string: &swiftPattern,
				"(\(XSD.RegularExpression.unescaped))\\\\I",
				"$1[^\(XSD.RegularExpression.startChar)]"
			)
			XSD.RegularExpression.replaceIn(  //  `\c`
				string: &swiftPattern,
				"(\(XSD.RegularExpression.unescaped))\\\\c",
				"$1[\(XSD.RegularExpression.char)]"
			)
			XSD.RegularExpression.replaceIn(  //  `\C`
				string: &swiftPattern,
				"(\(XSD.RegularExpression.unescaped))\\\\C",
				"$1[^\(XSD.RegularExpression.char)]"
			)
			XSD.RegularExpression.replaceIn(  //  `\w`
				string: &swiftPattern,
				"(\(XSD.RegularExpression.unescaped))\\\\w",
				"$1(?:(?![\(XSD.RegularExpression.wordChar)])[\(XSD.RegularExpression.anyChar)])"
			)
			XSD.RegularExpression.replaceIn(  //  `\W`
				string: &swiftPattern,
				"(\(XSD.RegularExpression.unescaped))\\\\W",
				"$1[\(XSD.RegularExpression.wordChar)]"
			)
			guard  //  make regexp
				let nsRegularExpression = try? NSRegularExpression(
					pattern: "^\(swiftPattern)$"
				)
			else { return nil }
			self.nsRegularExpression = nsRegularExpression
			self.description = description
		}

		/// Tests for a match between a string and a regular
		///   expression.
		///
		///  +  parameters:
		///      +  string:
		///         The string to test.
		///
		///  +  returns:
		///     `true` or `false` depending on whether the regular
		///       expression matches the entire string.
		public func matches(
			_ string: String
		) -> Bool {
			return nsRegularExpression.firstMatch(
				in: string,
				range: NSMakeRange(0, (string as NSString).length)
			) != nil
		}

		/// Ensures that the following character is unescaped.
		private static let unescaped = "(?<!\\\\)(?:\\\\\\\\)*"

		/// A single character.
		///
		///     [80]   singleChar   ::=   SingleCharEsc | SingleCharNoEsc
		private static let singleChar = """
			\\\\[nrt\\\\|\\.?*+(){}\\x2D\\x5B\\x5D\\x5E]\
			|\
			[^\\x5B\\x5D]
			"""

		/// A character range.
		///
		///     [81]   charRange   ::=   singleChar '-' singleChar
		private static let charRange =
			"(?:\(singleChar))-(?:\(singleChar))"

		/// A character class escape.
		///
		///     [83]   charClassEsc   ::=   ( MultiCharEsc | catEsc | complEsc )
		private static let charClassEsc = """
			(?:\
			\\\\[sSiIcCdDwW]|\
			\\\\[Pp]\\{(?:\
			L[ultmo]?|\
			M[nce]?|\
			N[dlo]?|\
			P[cdseifo]?|\
			Z[slp]?|\
			S[mcko]?|\
			C[cfon]?|\
			Is[a-zA-Z0-9\\x2D]+\
			)\\})
			"""

		/// Any Unicode character.
		private static let anyChar =
			NSRegularExpression.escapedTemplate(
				for: "\\x00-\\x{10FFFF}"
			)

		/// The set of name characters, those matched by
		///   [NameChar].
		///
		/// [NameChar]: https://www.w3.org/TR/xml11/#NT-NameChar
		private static let char = NSRegularExpression.escapedTemplate(
			for: """
				:A-Z_a-z\
				\\xC0-\\xD6\
				\\xD8-\\xF6\
				\\xF8-\\x{2FF}\
				\\x{370}-\\x{37D}\
				\\x{37F}-\\x{1FFF}\
				\\x{200C}-\\x{200D}\
				\\x{2070}-\\x{218F}\
				\\x{2C00}-\\x{2FEF}\
				\\x{3001}-\\x{D7FF}\
				\\x{F900}-\\x{FDCF}\
				\\x{FDF0}-\\x{FFFD}\
				\\x{10000}-\\x{EFFFF}\
				\\-\\.0-9\\xB7\
				\\x{0300}-\\x{036F}\
				\\x{203F}-\\x{2040}
				"""
		)

		/// Line break characters.
		private static let lineChar =
			NSRegularExpression.escapedTemplate(
				for: "\\n\\r"
			)

		/// Space characters.
		private static let spaceChar =
			NSRegularExpression.escapedTemplate(
				for: "\\x20\\t\\n\\r"
			)

		/// The set of initial name characters, those matched by
		///   [NameStartChar].
		///
		/// [NameStartChar]:
		///   https://www.w3.org/TR/xml11/#NT-NameStartChar
		private static let startChar =
			NSRegularExpression.escapedTemplate(
				for: """
					:A-Z_a-z\
					\\xC0-\\xD6\
					\\xD8-\\xF6\
					\\xF8-\\x{2FF}\
					\\x{370}-\\x{37D}\
					\\x{37F}-\\x{1FFF}\
					\\x{200C}-\\x{200D}\
					\\x{2070}-\\x{218F}\
					\\x{2C00}-\\x{2FEF}\
					\\x{3001}-\\x{D7FF}\
					\\x{F900}-\\x{FDCF}\
					\\x{FDF0}-\\x{FFFD}\
					\\x{10000}-\\x{EFFFF}
					"""
			)

		/// Word characters.
		private static let wordChar =
			NSRegularExpression.escapedTemplate(
				for: "\\p{P}\\p{Z}\\p{C}"
			)

		/// Replaces within a string, used internally to modify the
		///   input string.
		///
		///  +  parameters:
		///      +  string:
		///         The string to replace within.
		///      +  pattern:
		///         The pattern to match within the string.
		///      +  template:
		///         The template to use when replacing matches.
		private static func replaceIn(
			string: inout String,
			_ pattern: String,
			_ template: String
		) {
			string = try! NSRegularExpression(
				pattern: pattern
			).stringByReplacingMatches(
				in: string,
				range: NSMakeRange(0, (string as NSString).length),
				withTemplate: template
			)
		}

	}
}

extension XSD.RegularExpression: Equatable {

	/// Tests to see if two XSD regular expressions are equal.
	///
	///  +  parameters:
	///      +  lhs:
	///         A `XSD.RegularExpression`.
	///      +  rhs:
	///         A `XSD.RegularExpression`.
	///
	///  +  returns:
	///     `true` if the regular expressions represent the same
	///       string; `false` otherwise.
	///
	/// Equality is determined based on the `description` string of the
	///   regular expression.
	public static func ==(
		lhs: XSD.RegularExpression,
		rhs: XSD.RegularExpression
	) -> Bool { return lhs.description == rhs.description }

}

extension XSD.RegularExpression: Hashable {

	/// Hashes the regular expression.
	///
	///  +  parameters:
	///      +  hasher:
	///         The hasher to hash into.
	///
	/// Hashing is done using the `description` string of the regular
	///   expression.
	public func hash(
		into hasher: inout Hasher
	) { hasher.combine(description) }

}
