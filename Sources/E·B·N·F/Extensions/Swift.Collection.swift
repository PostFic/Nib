//  #  E·B·N·F :: Swift.Collection  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Core

extension Collection
where SubSequence == Text.SubSequence {

	/// Returns whether the text of this `Collection` starts with something which matches the provided `expression`.
	///
	/// <https://www.w3.org/TR/xml11/#dt-match>.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  expression:
	///         An `Expressible`.
	///      +  version:
	///         The `VersionProtocol` to use when matching.
	///
	///  +  Returns:
	///     A `Boolean`.
	@inlinable
	public func starts <Expressed> (
		with expression: Expressed,
		version: Expressed.Symbol.Version = .default
	) -> Bool
	where Expressed : Expressible {
		(
			try? expression′.extract(
				from: self,
				version: version
			)
		) != nil
	}

	/// Returns whether the text of this `Collection` exactly matches the provided `expression`.
	///
	/// <https://www.w3.org/TR/xml11/#dt-match>.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  expression:
	///         An `Expressible`.
	///      +  version:
	///         The `VersionProtocol` to use when matching.
	///
	///  +  Returns:
	///     A `Boolean`.
	@inlinable
	public func matches <Expressed> (
		_ expression: Expressed,
		version: Expressed.Symbol.Version = .default
	) -> Bool
	where Expressed : Expressible {
		(
			try? expression′.parse(
				self,
				version: version
			)
		) != nil
	}

	/// Returns whether the text of the provided `Collection` exactly matches a given `expression`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  expression:
	///         An `Expressible`.
	///      +  r·h·s:
	///         A `Collection` whose `SubSequence` is `Text.SubSequence`.
	///
	///  +  Returns:
	///     A `Boolean`.
	@inlinable
	public static func ~= <Expressed> (
		_ l·h·s: Expressed,
		_ r·h·s: Self
	) -> Bool
	where Expressed : Expressible
	{ r·h·s.matches(l·h·s) }

}
