import Core

/// Either character data or XML markup.
///
///  +  Version:
///     `0.2.0`.
public enum X·M·L·Data {

	/// XML text which is not markup.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-chardata>.
	///
	///  +  Version:
	///     `0.2.0`.
	case characterData (
		Text
	)

	/// XML markup.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-markup>.
	///
	///  +  Version:
	///     `0.2.0`.
	case markup (
		Markup
	)

}

extension X·M·L·Data:
	Equatable
{

	/// Returns whether two `X·M·L·Data`s are equivalent.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `Markup`.
	///      +  r·h·s:
	///         A `Markup`.
	///
	///  +  Returns:
	///     `true` if `l·h·s` and `r·h·s` are equivalent pieces of data; `false` otherwise.
	public static func == (
		_ l·h·s: X·M·L·Data,
		_ r·h·s: X·M·L·Data
	) -> Bool {
		switch l·h·s {
			case .characterData(let l·h·s·text):
				guard case .characterData(let r·h·s·text) = r·h·s
				else { return false }
				return l·h·s·text.elementsEqual(r·h·s·text)
			case .markup(let l·h·s·markup):
				guard case .markup(let r·h·s·markup) = r·h·s
				else { return false }
				return l·h·s·markup == r·h·s·markup
		}
	}

}

extension X·M·L·Data:
	ExpressibleByStringLiteral
{

	/// Creates `X·M·L·Data.CharacterData` from a string literal.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  stringLiteral:
	///         A `String` literal containing character data.
	public init (
		stringLiteral value: String
	) { self = .characterData(value.unicodeScalars) }

}
