import E·B·N·F

extension Construct:
	CustomDebugStringConvertible
{

	/// An XML tree representing the `Construct`, as a string.
	///
	///  +  Complexity:
	///     `O(n)` over nested `Construct`s.
	public var debugDescription: String {
		switch self {
		case .string (
			content: let text
		): return "<string>\(Substring(text))</string>"
		case .symbol (
			let symbol,
			version: let version,
			content: let children
		): return #"<symbol name="\#(symbol)" version="\#(version)">\#(children.map(\.debugDescription).joined())</symbol>"#
		}
	}

}
