//  #  E·B·N·F :: Construct  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Core

/// An enumerated type representing a substring, potentially lexed into a tree of symbols.
/// The substring itself can be accessed (as a `Text.SubSequence`) via the `.text` property.
///
/// `Construct.symbol`s have an associated `Symbol` and content which is an array of further `Construct`s.
/// They represent a single *instance* of a `Symbol`.
///
/// `Construct.string`s represent the text content of an instance of a terminal `Expression`.
///
///  +  Version:
///     `0.1.0`.
public enum Construct <Symbol>:
	CustomTextConvertible
where Symbol : Symbolic {

	public typealias Text = Substring.UnicodeScalarView

	/// The text contents of an instance of a terminal `Expression`.
	///
	///  +  Version:
	///     `0.1.0`.
	case string (
		content: Text
	)

	/// A lexed instance of a `Symbol`.
	///
	/// The `content` must form a contiguous sequence from `.first.text.startIndex` to `.last.text.endIndex`.
	///
	///  +  Version:
	///     `0.1.0`.
	case symbol (
		Symbol,
		version: Symbol.Version,
		content: [Symbol.Construct]
	)

	/// If this `Symbol` is a `.symbol`, its `content`; otherwise, an array containing only this `Symbol`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	@inlinable
	public var content: [Symbol.Construct] {
		switch self {
			case .string:
				return [self]
			case .symbol (
				_,
				version: _,
				content: let content
			): return content
		}
	}

	/// If this `Symbol` is a `.symbol`, its `symbol`; otherwise, `nil`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	@inlinable
	public var symbol: Symbol? {
		switch self {
			case .string:
				return nil
			case .symbol (
				let symbol,
				version: _,
				content: _
			): return symbol
		}
	}

	/// The substring which this `Construct` lexes.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	@inlinable
	public var text: Text {
		switch self {
			case .string (
				content: let text
			): return text
			case .symbol (
				_,
				version: _,
				content: let children
			): return children.count == 0 ? Text() : Substring(children[0].text).base[children[0].text.startIndex..<children[children.count - 1].text.endIndex].unicodeScalars
		}
	}

	/// If this `Symbol` is a `.symbol`, its `version`; otherwise, `nil`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	@inlinable
	public var version: Symbol.Version? {
		switch self {
			case .string:
				return nil
			case .symbol (
				_,
				version: let version,
				content: _
			): return version
		}
	}

}
