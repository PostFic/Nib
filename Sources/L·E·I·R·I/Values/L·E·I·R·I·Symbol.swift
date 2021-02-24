//  #  L·E·I·R·I :: L·E·I·R·I·Symbol  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Core
import E·B·N·F

public enum L·E·I·R·I·Symbol:
	String
{

	/// The version of IRI syntax.
	///
	///  +  Version:
	///     `0.2.0`.
	public enum Version:
		String,
		Defaultable,
		VersionProtocol
	{

		/// A RFC 3986 Universal Resource Identifier.
		case rfc3986 = "RFC 3986"

		/// A RFC 3987 International Resource Identifier.
		case rfc3987 = "RFC 3987"

		/// A Legacy Encoded International Resource Identifier.
		case leiri = "W3C NOTE 2008-11-03"

		/// The default kind of (LE)IRI syntax.
		///
		/// By default, the LEIRI syntax is used.
		///
		///  +  Version:
		///     `0.2.0`.
		public static let `default` = L·E·I·R·I·Symbol.Version.leiri

	}

	/// A complete (LE)IRI.
	///
	/// This case is used regardless of the actual syntax being processed.
	///
	///     [1] LEIRI ::= scheme ":" ihier-part [ "?" iquery ] [ "#" ifragment ]
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#LEIRI>.
	///
	///  +  Version:
	///     `0.2.0`.
	case LEIRI

	/// A (LE)IRI (internationalized) heirarchical part.
	///
	///     [2] ihier-part ::= "//" iauthority ipath-abempty
	///                        / ipath-absolute
	///                        / ipath-rootless
	///                        / ipath-empty
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#ihier-part>.
	///
	///  +  Version:
	///     `0.2.0`.
	case ihier·part = "ihier-part"

	/// An complete or relative (LE)IRI reference.
	///
	/// This case is used regardless of the actual syntax being processed.
	///
	///     [3] LEIRI-reference ::= LEIRI / irelative-ref
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#LEIRI-reference>.
	///
	///  +  Version:
	///     `0.2.0`.
	case LEIRI·reference = "LEIRI-reference"

	/// An absolute (LE)IRI, with no fragment.
	///
	/// This case is used regardless of the actual syntax being processed.
	///
	///     [4] absolute-LEIRI ::= scheme ":" ihier-part [ "?" iquery ]
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#absolute-LEIRI>.
	///
	///  +  Version:
	///     `0.2.0`.
	case absolute·LEIRI = "absolute-LEIRI"

	/// A (LE)IRI (internationalized) relative reference.
	///
	///     [5] irelative-ref ::= irelative-part [ "?" iquery ] [ "#" ifragment ]
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#irelative-ref>.
	///
	///  +  Version:
	///     `0.2.0`.
	case irelative·ref = "irelative-ref"

	/// An (internationalized) relative part of a (LE)IRI reference.
	///
	///     [6] irelative-part ::= "//" iauthority ipath-abempty
	///                            / ipath-absolute
	///                            / ipath-noscheme
	///                            / ipath-empty
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#irelative-part>.
	///
	///  +  Version:
	///     `0.2.0`.
	case irelative·part = "irelative-part"

	/// An (internationalized) (LE)IRI authority.
	///
	///     [7] iauthority ::= [ iuserinfo "@" ] ihost [ ":" port ]
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#iauthority>.
	///
	///  +  Version:
	///     `0.2.0`.
	case iauthority

	/// An (internationalized) (LE)IRI userinfo.
	///
	///     [8] iuserinfo ::= *( iunreserved / pct-encoded / sub-delims / ":" )
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#iuserinfo>.
	///
	///  +  Version:
	///     `0.2.0`.
	case iuserinfo

	/// An (internationalized) (LE)IRI host.
	///
	///     [9] host ::= IP-literal / IPv4address / ireg-name
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#host>.
	///
	///  +  Version:
	///     `0.2.0`.
	case ihost

	/// An (internationalized) (LE)IRI registered name.
	///
	///     [10] ireg-name ::= *( iunreserved / pct-encoded / sub-delims )
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#ireg-name>.
	///
	///  +  Version:
	///     `0.2.0`.
	case ireg·name = "ireg-name"

	/// An (internationalized) (LE)IRI path.
	///
	///     [11] ipath ::= ipath-abempty ; begins with "/" or is empty
	///                    / ipath-absolute ; begins with "/" but not "//"
	///                    / ipath-noscheme ; begins with a non-colon segment
	///                    / ipath-rootless ; begins with a segment
	///                    / ipath-empty ; zero characters
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#ipath>.
	///
	///  +  Version:
	///     `0.2.0`.
	case ipath

	/// An (internationalized) (LE)IRI path which begins with `/` or is empty.
	///
	///     [12] ipath-abempty ::= *( "/" isegment )
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#ipath-abempty>.
	///
	///  +  Version:
	///     `0.2.0`.
	case ipath·abempty = "ipath-abempty"

	/// An (internationalized) (LE)IRI path which begins with `/` but not `//`.
	///
	///     [13] ipath-absolute ::= "/" [ isegment-nz *( "/" isegment ) ]
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#ipath-absolute>.
	///
	///  +  Version:
	///     `0.2.0`.
	case ipath·absolute = "ipath-absolute"

	/// An (internationalized) (LE)IRI path which begins with a noncolon segment.
	///
	///     [14] ipath-noscheme ::= isegment-nz-nc *( "/" isegment )
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#ipath-noscheme>.
	///
	///  +  Version:
	///     `0.2.0`.
	case ipath·noscheme = "ipath-noscheme"

	/// An (internationalized) (LE)IRI path which begins with a segment.
	///
	///     [15] ipath-rootless ::= isegment-nz *( "/" isegment )
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#ipath-rootless>.
	///
	///  +  Version:
	///     `0.2.0`.
	case ipath·rootless = "ipath-rootless"

	/// An (internationalized) (LE)IRI path of zero characters.
	///
	///     [16] ipath-empty ::= 0<ipchar>
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#ipath-empty>.
	///
	///  +  Version:
	///     `0.2.0`.
	case ipath·empty = "ipath-empty"

	/// An (internationalized) (LE)IRI segment, possibly empty.
	///
	///     [17] isegment ::= *ipchar
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#isegment>.
	///
	///  +  Version:
	///     `0.2.0`.
	case isegment

	/// A nonempty (internationalized) (LE)IRI segment.
	///
	///     [18] isegment-nz ::= 1*ipchar
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#isegment-nz>.
	///
	///  +  Version:
	///     `0.2.0`.
	case isegment·nz = "isegment-nz"

	/// A nonempty (internationalized) (LE)IRI segment which does not contain a colon.
	///
	///     [19] isegment-nz-nc ::= 1*( iunreserved / pct-encoded / sub-delims / "@" )
	///                             ; non-zero-length segment without any colon ":"
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#isegment-nz-nc>.
	///
	///  +  Version:
	///     `0.2.0`.
	case isegment·nz·nc = "isegment-nz-nc"

	/// An (internationalized) (LE)IRI possibly‐percentencoded character.
	///
	///     [20] ipchar ::= iunreserved / pct-encoded / sub-delims / ":"
	///                     / "@"
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#ipchar>.
	///
	///  +  Version:
	///     `0.2.0`.
	case ipchar

	/// An (internationalized) (LE)IRI query string.
	///
	///     [21] iquery ::= *( ipchar / iprivate / "/" / "?" )
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#iquery>.
	///
	///  +  Version:
	///     `0.2.0`.
	case iquery

	/// An (internationalized) (LE)IRI fragment string.
	///
	///     [22] ifragment ::= *( ipchar / "/" / "?" )
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#ifragment>.
	///
	///  +  Version:
	///     `0.2.0`.
	case ifragment

	/// An (internationalized) (LE)IRI unreserved character.
	///
	///     [23] iunreserved ::= ALPHA / DIGIT / "-" / "." / "_" / "~" / ucschar
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#iunreserved>.
	///
	///  +  Version:
	///     `0.2.0`.
	case iunreserved

	/// An (internationalized) (LE)IRI private‐use character.
	///
	///     [24] iprivate ::= %xE000-F8FF / %xE0000-E0FFF / %xF0000-FFFFD
	///                       / %x100000-10FFFD
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#iprivate>.
	///
	///  +  Version:
	///     `0.2.0`.
	case iprivate

	/// A (LE)IRI scheme.
	///
	///     [25] scheme ::= ALPHA *( ALPHA / DIGIT / "+" / "-" / "." )
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#scheme>.
	///
	///  +  Version:
	///     `0.2.0`.
	case scheme

	/// A (LE)IRI port.
	///
	///     [26] port ::= *DIGIT
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#port>.
	///
	///  +  Version:
	///     `0.2.0`.
	case port

	/// A (LE)IRI IP address literal.
	///
	///     [27] IP-literal ::= "[" ( IPv6address / IPvFuture ) "]"
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#IP-literal>.
	///
	///  +  Version:
	///     `0.2.0`.
	case IP·literal = "IP-literal"

	/// A (LE)IRI IP future address literal.
	///
	///     [28] IPvFuture ::= "v" 1*HEXDIG "." 1*( unreserved / sub-delims / ":" )
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#IPvFuture>.
	///
	///  +  Version:
	///     `0.2.0`.
	case IPvFuture

	/// A (LE)IRI IPv6 address literal.
	///
	///     [29] IPv6address ::= 6( h16 ":" ) ls32
	///                          / "::" 5( h16 ":" ) ls32
	///                          / [ h16 ] "::" 4( h16 ":" ) ls32
	///                          / [ *1( h16 ":" ) h16 ] "::" 3( h16 ":" ) ls32
	///                          / [ *2( h16 ":" ) h16 ] "::" 2( h16 ":" ) ls32
	///                          / [ *3( h16 ":" ) h16 ] "::" h16 ":" ls32
	///                          / [ *4( h16 ":" ) h16 ] "::" ls32
	///                          / [ *5( h16 ":" ) h16 ] "::" h16
	///                          / [ *6( h16 ":" ) h16 ] "::"
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#IPv6address>.
	///
	///  +  Version:
	///     `0.2.0`.
	case IPv6address

	/// Sixteen bits of a (LE)IRI IPv6 address literal.
	///
	///     [30] h16 ::= 1*4HEXDIG
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#h16>.
	///
	///  +  Version:
	///     `0.2.0`.
	case h16

	/// The last 32 bits of a (LE)IRI IPv6 address literal.
	///
	///     [31] ls32 ::= ( h16 ":" h16 ) / IPv4address
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#ls32>.
	///
	///  +  Version:
	///     `0.2.0`.
	case ls32

	/// A (LE)IRI IPv4 address literal.
	///
	///     [32] IPv4address ::= dec-octet "." dec-octet "." dec-octet "." dec-octet
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#IPv4address>.
	///
	///  +  Version:
	///     `0.2.0`.
	case IPv4address

	/// A decimal octet of a (LE)IRI IPv4 address literal.
	///
	///     [33] dec-octet ::= DIGIT ; 0-9
	///                        / %x31-39 DIGIT ; 10-99
	///                        / "1" 2DIGIT ; 100-199
	///                        / "2" %x30-34 DIGIT ; 200-249
	///                        / "25" %x30-35 ; 250-255
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#dec-octet>.
	///
	///  +  Version:
	///     `0.2.0`.
	case dec·octet = "dec-octet"

	/// A (LE)IRI percentencoded character.
	///
	///     [34] pct-encoded ::= "%" HEXDIG HEXDIG
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#pct-encoded>.
	///
	///  +  Version:
	///     `0.2.0`.
	case pct·encoded = "pct-encoded"

	/// A (LE)IRI unreserved character.
	///
	///     [35] unreserved ::= ALPHA / DIGIT / "-" / "." / "_" / "~"
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#unreserved>.
	///
	///  +  Version:
	///     `0.2.0`.
	case unreserved

	/// A (LE)IRI reserved character.
	///
	///     [36] reserved ::= gen-delims / sub-delims
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#reserved>.
	///
	///  +  Version:
	///     `0.2.0`.
	case reserved

	/// A (LE)IRI general delimiter.
	///
	///     [37] gen-delims ::= ":" / "/" / "?" / "#" / "[" / "]" / "@"
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#gen-delims>.
	///
	///  +  Version:
	///     `0.2.0`.
	case gen·delims = "gen-delims"

	/// A (LE)IRI sub delimiter.
	///
	///     [38] sub-delims ::= ":" / "/" / "?" / "#" / "[" / "]" / "@"
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#sub-delims>.
	///
	///  +  Version:
	///     `0.2.0`.
	case sub·delims = "sub-delims"

	/// A (LE)IRI UCS character.
	///
	///     [39] ucschar ::= " " / "<" / ">" / '"' / "{" / "}" / "|"
	///                      / "\" / "^" / "`" / %x0-1F / %x7F-D7FF
	///                      / %xE000-FFFD / %x10000-10FFFF
	///
	/// <https://www.w3.org/TR/2008/NOTE-leiri-20081103/#ucschar>.
	///
	///  +  Version:
	///     `0.2.0`.
	case ucschar

}

extension L·E·I·R·I·Symbol:
	Symbolic
{

	/// The type of this `Symbolic`.
	///
	///  +  Version:
	///     `0.2.0`.
	public typealias Symbol = L·E·I·R·I·Symbol

	/// The reference identifier for this `L·E·I·R·I·Symbol`.
	///
	/// Reference identifiers are based off of the [LEIRI](https://www.w3.org/TR/2008/NOTE-leiri-20081103/) spec.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	public var reference: String? {
		switch self {
			case .LEIRI:
				return "1"
			case .ihier·part:
				return "2"
			case .LEIRI·reference:
				return "3"
			case .absolute·LEIRI:
				return "4"
			case .irelative·ref:
				return "5"
			case .irelative·part:
				return "6"
			case .iauthority:
				return "7"
			case .iuserinfo:
				return "8"
			case .ihost:
				return "9"
			case .ireg·name:
				return "10"
			case .ipath:
				return "11"
			case .ipath·abempty:
				return "12"
			case .ipath·absolute:
				return "13"
			case .ipath·noscheme:
				return "14"
			case .ipath·rootless:
				return "15"
			case .ipath·empty:
				return "16"
			case .isegment:
				return "17"
			case .isegment·nz:
				return "18"
			case .isegment·nz·nc:
				return "19"
			case .ipchar:
				return "20"
			case .iquery:
				return "21"
			case .ifragment:
				return "22"
			case .iunreserved:
				return "23"
			case .iprivate:
				return "24"
			case .scheme:
				return "25"
			case .port:
				return "26"
			case .IP·literal:
				return "27"
			case .IPvFuture:
				return "28"
			case .IPv6address:
				return "29"
			case .h16:
				return "30"
			case .ls32:
				return "31"
			case .IPv4address:
				return "32"
			case .dec·octet:
				return "33"
			case .pct·encoded:
				return "34"
			case .unreserved:
				return "35"
			case .reserved:
				return "36"
			case .gen·delims:
				return "37"
			case .sub·delims:
				return "38"
			case .ucschar:
				return "39"
		}
	}

	/// Returns the `Expression` corresponding to this `L·E·I·R·I·Symbol` for the given `version`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  version:
	///         The `Version` of this value to get an `Expression` for.
	///
	///  +  Returns:
	///     An `Expression`.
	public func callAsFunction (
		_ version: Version = .default
	) -> L·E·I·R·I·Symbol.Expression? {
		switch self {
			//  Productions changed from RFC3986
			case .LEIRI:
				return ∏[.scheme®, ":", .ihier·part®, ("?" & .iquery®)^?, ("#" & .ifragment®)^?]
			case .ihier·part:
				var ihier·part: L·E·I·R·I·Symbol.Expression
				ihier·part = ∏["//", .iauthority®, .ipath·abempty®]
				ihier·part |= .ipath·absolute®
				ihier·part |= .ipath·rootless®
				ihier·part |= .ipath·empty®
				return ihier·part
			case .LEIRI·reference:
				return .LEIRI® | .irelative·ref®
			case .absolute·LEIRI:
				return ∏[.scheme®, ":", .ihier·part®, ("?" & .iquery®)^?]
			case .irelative·ref:
				return ∏[.irelative·part®, ("?" & .iquery®)^?, ("#" & .ifragment®)^?]
			case .irelative·part:
				var irelative·part: L·E·I·R·I·Symbol.Expression
				irelative·part = ["//", .iauthority®, .ipath·abempty®]
				irelative·part |= .ipath·absolute®
				irelative·part |= .ipath·noscheme®
				irelative·part |= .ipath·empty®
				return irelative·part
			case .iauthority:
				return ∏[(.iuserinfo® & "@")^?, .ihost®, (":" & .port®)^?]
			case .iuserinfo:
				return *(∑[.iunreserved®, .pct·encoded®, .sub·delims®, ":"])
			case .ihost:
				return ∑[.IP·literal®, .IPv4address®, .ireg·name®]
			case .ireg·name:
				return *(∑[.iunreserved®, .pct·encoded®, .sub·delims®])
			case .ipath:
				var ipath: L·E·I·R·I·Symbol.Expression
				ipath = .ipath·abempty®
				ipath |= .ipath·absolute®
				ipath |= .ipath·noscheme®
				ipath |= .ipath·rootless®
				ipath |= .ipath·empty®
				return ipath
			case .ipath·abempty:
				return *("/" & .isegment®)
			case .ipath·absolute:
				return "/" & (.isegment·nz® & *("/" & .isegment®))^?
			case .ipath·noscheme:
				return .isegment·nz·nc® & *("/" & .isegment®)
			case .ipath·rootless:
				return .isegment·nz® & *("/" & .isegment®)
			case .ipath·empty:
				return 0 * .ipchar®
			case .isegment:
				return *.ipchar®
			case .isegment·nz:
				return 1... * .ipchar®
			case .isegment·nz·nc:
				return 1... * ∑[.unreserved®, .pct·encoded®, .sub·delims®, "@"]
			case .ipchar:
				var ipchar: L·E·I·R·I·Symbol.Expression
				ipchar = ∑[.unreserved®, .pct·encoded®, .sub·delims®, ":"]
				ipchar |= "@"
				return ipchar
			case .iquery:
				return version == .rfc3986 ? *(∑[.ipchar®, "/", "?"]) : *(∑[.ipchar®, .iprivate®, "/", "?"])
			case .ifragment:
				return *(∑[.ipchar®, "/", "?"])
			case .iunreserved:
				return version == .rfc3986 ? ∑[.ALPHA, .DIGIT, "-", ".", "_", "~"] : ∑[.ALPHA, .DIGIT, "-", ".", "_", "~", .ucschar®]
			case .iprivate:
				guard version != .rfc3986
				else { return nil }
				var iprivate: L·E·I·R·I·Symbol.Expression
				iprivate = ∑[√["\u{E000}"..."\u{F8FF}"], √["\u{E0000}"..."\u{E0FFF}"], √["\u{F0000}"..."\u{FFFFD}"]]
				iprivate |= √["\u{100000}"..."\u{10FFFD}"]
				return iprivate

			//  Productions unchanged from RFC3986
			case .scheme:
				return .ALPHA & *(∑[.ALPHA, .DIGIT, "+", "-", "."])
			case .port:
				return *.DIGIT
			case .IP·literal:
				return ∏["[", (.IPv6address® | .IPvFuture®), "]"]
			case .IPvFuture:
				return ∏["v", 1... * .HEXDIG, ".", 1... * ∑[.unreserved®, .sub·delims®, ":"]]
			case .IPv6address:
				//  <https://www.rfc-editor.org/errata/eid4394> is not relevant here because IPv6 addresses are properly end‐delimited with two colons and/or a pattern of set length.
				//  Nib’s first·match·wins strategy nevertheless requires a complete match.
				var IPv6address: L·E·I·R·I·Symbol.Expression
				IPv6address = [6 * (.h16® & ":"), .ls32®]
				IPv6address |= ∏["::", 5 * (.h16® & ":"), .ls32®]
				IPv6address |= ∏[.h16^?, "::", 4 * (.h16® & ":"), .ls32®]
				IPv6address |= ∏[((...1 * (.h16® & ":")) & .h16®)^?, "::", 3 * (.h16® & ":"), .ls32®]
				IPv6address |= ∏[((...2 * (.h16® & ":")) & .h16®)^?, "::", 2 * (.h16® & ":"), .ls32®]
				IPv6address |= ∏[((...3 * (.h16® & ":")) & .h16®)^?, "::", .h16®, ":", .ls32®]
				IPv6address |= ∏[((...4 * (.h16® & ":")) & .h16®)^?, "::", .ls32®]
				IPv6address |= ∏[((...5 * (.h16® & ":")) & .h16®)^?, "::", .h16®]
				IPv6address |= ((...6 * (.h16® & ":")) & .h16®)^? & "::"
				return IPv6address
			case .h16:
				return (1...4) * .HEXDIG
			case .ls32:
				return ∏[.h16®, ":", .h16®] | .IPv4address®
			case .IPv4address:
				return ∏[.dec·octet®, ".", .dec·octet®, ".", .dec·octet®, ".", .dec·octet®]
			case .dec·octet:
				//  See <https://www.rfc-editor.org/errata/eid4393>.
				var dec·octet: L·E·I·R·I·Symbol.Expression
				dec·octet = "25" & √["\u{30}"..."\u{35}"]
				dec·octet |= ∏["2", √["\u{30}"..."\u{34}"], .DIGIT]
				dec·octet |= "1" & (2 * .DIGIT)
				dec·octet |= √["\u{31}"..."\u{39}"] & .DIGIT
				dec·octet |= .DIGIT
				return dec·octet
			case .pct·encoded:
				return ∏["%", .HEXDIG, .HEXDIG]
			case .unreserved:
				return ∑[.ALPHA, .DIGIT, "-", ".", "_", "~"]
			case .reserved:
				return .gen·delims® | .sub·delims®
			case .gen·delims:
				return ∑[":", "/", "?", "#", "[", "]", "@"]
			case .sub·delims:
				var sub·delims: L·E·I·R·I·Symbol.Expression
				sub·delims = ∑["!", "$", "&", "'", "(", ")"]
				sub·delims |= ∑["*", "+", ",", ";", "="]
				return sub·delims

			//  Modified ucschar production
			case .ucschar:
				switch version {
					case .rfc3986:
						return nil
					case .rfc3987:
						var ucschar: L·E·I·R·I·Symbol.Expression
						ucschar = ∑[√["\u{A0}"..."\u{D7FF}"], √["\u{F900}"..."\u{FDCF}"], √["\u{FDF0}"..."\u{FFEF}"]]
						ucschar |= ∑[√["\u{10000}"..."\u{1FFFD}"], √["\u{20000}"..."\u{2FFFD}"], √["\u{30000}"..."\u{3FFFD}"]]
						ucschar |= ∑[√["\u{40000}"..."\u{4FFFD}"], √["\u{50000}"..."\u{5FFFD}"], √["\u{60000}"..."\u{6FFFD}"]]
						ucschar |= ∑[√["\u{70000}"..."\u{7FFFD}"], √["\u{80000}"..."\u{8FFFD}"], √["\u{90000}"..."\u{9FFFD}"]]
						ucschar |= ∑[√["\u{A0000}"..."\u{AFFFD}"], √["\u{B0000}"..."\u{BFFFD}"], √["\u{C0000}"..."\u{CFFFD}"]]
						ucschar |= √["\u{D0000}"..."\u{DFFFD}"] | √["\u{E1000}"..."\u{EFFFD}"]
						return ucschar
					case .leiri:
						var ucschar: L·E·I·R·I·Symbol.Expression
						ucschar = ∑[" ", "<", ">", "\"", "{", "}", "|"]
						ucschar |= ∑["\\", "^", "`", "\u{0}", √["\u{1}"..."\u{1F}"], √["\u{7F}"..."\u{D7FF}"]]  //  a bracketed expression will never match `"\u{0}"` because it is not a `Char`
						ucschar |= √["\u{E000}"..."\u{FFFD}"] | √["\u{10000}"..."\u{10FFFF}"]
						return ucschar
				}
		}
	}

}
