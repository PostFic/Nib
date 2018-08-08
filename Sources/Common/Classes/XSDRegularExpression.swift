import Foundation

fileprivate func replaceIn(string: inout String, _ pattern: String, _ template: String) {
	string = try! NSRegularExpression(
		pattern: pattern
	).stringByReplacingMatches(
		in: string,
		range: NSMakeRange(0, (string as NSString).length),
		withTemplate: template
	)
}

fileprivate let unescaped = "(?<!\\\\)(?:\\\\\\\\)*"
fileprivate let singleChar = """
	\\\\[nrt\\\\|\\.?*+(){}\\x2D\\x5B\\x5D\\x5E]\
	|\
	[^\\x5B\\x5D]
	"""
fileprivate let charRange = "(?:\(singleChar))-(?:\(singleChar))"
fileprivate let charClassEsc = """
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
	)})
	"""

fileprivate let anyChar = NSRegularExpression.escapedTemplate(
	for: "\\x00-\\x{10FFFF}"
)

fileprivate let char = NSRegularExpression.escapedTemplate(
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
fileprivate let lineChar = NSRegularExpression.escapedTemplate(
	for: "\\n\\r"
)
fileprivate let spaceChar = NSRegularExpression.escapedTemplate(
	for: "\\x20\\t\\n\\r"
)
fileprivate let startChar = NSRegularExpression.escapedTemplate(
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
fileprivate let wordChar = NSRegularExpression.escapedTemplate(
	for: "\\p{P}\\p{Z}\\p{C}"
)

/// An XSD regular expression.
///
/// Inherits from `NSRegularExpression` and has all the same properties and methods.
/// Unlike normal `NSRegularExpression`s, `XSDRegularExpression`s are implicitly anchored at the head and tail.
///
/// + Note:
/// The syntax and supported escapes for XSD Regular Expressions differs somewhat from that used by Foundation.
/// `XSDRegularExpression` does its best to bridge this divide, and is able to support all of the regular expressions used as `pattern`s for the XSD base datatypes.
/// However, there is a chance that exceedingly complicated regular expressions might behave in an unexpected manner.
///
/// + Note:
/// Foundation does not support XSD's `\p{Is…}` syntax, which will be passed through unmodified.
/// Using this syntax will likely result in an error.
///
/// + Note:
/// `XSDRegularExpression` is not sophisticated enough to completely parse the given pattern; this task is left to `NSRegularExpression` and Foundation.
/// However, Foundation will likely accept some regular expressions which would be in error under XSD syntax, because its rules regarding atoms and metacharacters are less restrictive.
/// Be sure to double-check that your regular expressions meet the syntax requirements of XSD.
public class XSDRegularExpression: NSRegularExpression {

	/// Creates the regular expression.
	public init(_ pattern: String) throws {

		guard
			try! NSRegularExpression(
				pattern: "[^\\x{1}-\\x{D7FF}\\x{E000}-\\x{FFFD}\\x{10FFFF}]"
			).firstMatch(
				in: pattern,
				range: NSMakeRange(0, (pattern as NSString).length)
			) == nil
		else {
			throw NibError.invalidCharacterInRegularExpression
		}

		guard
			try! NSRegularExpression(
				pattern: "\(unescaped)\\\\[^nrt\\\\|\\.?*+(){}\\x2D\\x5B\\x5D\\x5EpPsSiIcCdDwW]"
			).firstMatch(
				in: pattern,
				range: NSMakeRange(0, (pattern as NSString).length)
			) == nil
		else {
			throw NibError.invalidEscapeInRegularExpression
		}

		var swiftPattern = pattern
		replaceIn(string: &swiftPattern, "(\(unescaped)\\()\\?", "$1\\\\?")
		replaceIn(string: &swiftPattern, "(\(unescaped))\\[(\\^?(?:\(singleChar)|\(charRange)|\(charClassEsc))+)-\\[(.+)]]", "$1(?:(?![$3])[$2])")
		replaceIn(string: &swiftPattern, "(\(unescaped)(?:[*+?]|\\{\\d+,\\d*\\}))([?+])", "$1\\\\$2")
		replaceIn(string: &swiftPattern, "(\\A\\^|\\$\\z)", "\\\\$1")
		replaceIn(string: &swiftPattern, "(\(unescaped))\\.", "$1[^\(lineChar)]")
		replaceIn(string: &swiftPattern, "(\(unescaped))\\\\s", "$1[\(spaceChar)]")
		replaceIn(string: &swiftPattern, "(\(unescaped))\\\\S", "$1[^\(spaceChar)]")
		replaceIn(string: &swiftPattern, "(\(unescaped))\\\\i", "$1[\(startChar)]")
		replaceIn(string: &swiftPattern, "(\(unescaped))\\\\I", "$1[^\(startChar)]")
		replaceIn(string: &swiftPattern, "(\(unescaped))\\\\c", "$1[\(char)]")
		replaceIn(string: &swiftPattern, "(\(unescaped))\\\\C", "$1[^\(char)]")
		replaceIn(string: &swiftPattern, "(\(unescaped))\\\\w", "$1(?:(?![\(wordChar)])[\(anyChar)])")
		replaceIn(string: &swiftPattern, "(\(unescaped))\\\\W", "$1[\(wordChar)]")

		try super.init(pattern: "^\(swiftPattern)$")
	}

	/// Required `NSCoder` initializer.
	///
	/// Probably don't use this; it's only here because `Foundation` demands it.
	/// Ignores the `NSOptions` because we don't use them.
	public required convenience init?(coder aDecoder: NSCoder) {
		guard aDecoder.allowsKeyedCoding else {
			preconditionFailure("Unkeyed coding is unsupported.")
		}

		guard let pattern = aDecoder.decodeObject(forKey: "NSPattern") as? NSString else {
			return nil
		}

		do {
			try self.init(pattern as String)
		} catch {
			return nil
		}
	}

}
