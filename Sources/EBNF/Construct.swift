//  # EBNF :: Construct
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

import Foundation

/// An enumerated type representing a substring, potentially lexed into a tree of symbols.
/// The substring itself can be accessed (as a `Text.SubSequence`) via the `.text` property.
///
/// `Construct.symbol`s have an associated `Grammar` and content which is an array of further `Construct`s.
/// They represent a single *instance* of a `Grammar`.
///
/// `Construct.string`s represent the content of an instance of a terminal `Expression`.
public enum Construct:
	CustomDebugStringConvertible
{

	/// The string contents of an instance of a terminal `Expression`.
	case string (
		content: Text.SubSequence
	)

	/// A lexed instance of a `Symbol`.
	case symbol (
		Symbol,
		content: [Construct]
	)

	/// An XML tree representing the construct, as a string.
	public var debugDescription: String
	{ nsXML.xmlString(options: .nodePrettyPrint) }

	/// The substring which this `Construct` lexes.
	public var text: Text.SubSequence {
		switch self {
		case .string (
			content: let text
		):
			return text
		case .symbol (
			_,
			content: let children
		):
			return children.count == 0 ? Text.SubSequence() : Substring(children[0].text).base[children[0].text.startIndex..<children.last!.text.endIndex].unicodeScalars
		}
	}

	/// An XML tree representing the construct, as a `XMLElement`.
	public var nsXML: XMLElement {
		switch self {
		case .string (
			content: let text
		):
			return XMLElement(
				name: "string",
				stringValue: String(text)
			)
		case .symbol(
			let symbol,
			content: let children
		):
			let node = XMLElement(name: "symbol")
			node.setAttributesWith(
				[
					"name": String(
						describing: symbol
					)
				]
			)
			for child in children
			{ node.addChild(child.nsXML) }
			return node
		}
	}

}
