import Foundation

/// An XSD regular expression.
///
/// Inherits from `NSRegularExpression` and has all the same properties and methods.
/// Unlike normal `NSRegularExpression`s, `XSDRegularExpression`s are implicitly anchored at the head and tail.
///
/// + Note: `XSDRegularExpression` uses `Foundation`s regular expression language without modification, which is more expressive than the one defined in XSD.
public class XSDRegularExpression: NSRegularExpression {

	/// Creates the regular expression.
	public init(_ pattern: String) throws {
		guard
			try! NSRegularExpression(
				pattern: "[^\\x{1}-\\x{D7FF}\\x{E000}-\\x{FFFD}\\x{10FFFF}]"
			).firstMatch(
				in: pattern,
				range: NSMakeRange(0, pattern.count)
			) == nil
		else {
			throw NibError.invalidCharacterInRegularExpression
		}
		try super.init(pattern: "^\(pattern)$")
	}

	/// Required `NSCoder` initializer.
	///
	/// Probably don't use this; it's only here because `Foundation` demands it.
	/// Ignores the `NSOptions` because we don't use them.
	required public convenience init?(coder aDecoder: NSCoder) {
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
