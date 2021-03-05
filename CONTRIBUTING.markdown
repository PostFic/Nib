#  Hacking Nib  #

Look, the real shit is that this code is highly particular with a highly esoteric coding style, and it’s not really made for other people to just pick up and contribute to.
Plus I’ve got waayyyy better things to do with my time than try to manage an Open Source Project®.
I am not anticipating a large developer interest in this software and nor do I particularly want one.

So this is actually less a “How To Contribute” page and more a “How To Remix For Your Own Purposes” page.
It’s titled `CONTRIBUTING.markdown` because that’s the filename which GitHub likes to have.

On the offchance that you actually do want to participate in Nib development, you should reach out to me [on Mastodon](https://joinmastodon.org).
If you want to build something *with* Nib instead, see [the GitHub Discussions](https://github.com/marrus-sh/Nib/discussions).

##  File Structure  ##

Nib is organized into modules, where each module (more·or·less) implements a different specification, has its own set of tests, etc.
Within the module, the file structure is as follows:

| Path | Meaning |
| --- | --- |
| Classes/ | Class type definitions |
| Documentation/ | `.markdown` documentation |
| Functions/ | Toplevel function definitions |
| Protocols/ | Protocol definitions |
| Values/ | Value type definitions (structs and enums) |
| Operators.swift | Any operators defined in this module as well as any toplevel operator definitions |
| Precedences.swift | Operator precedences if required |

Extensions to types declared in a module go in the same file as that type.
Otherwise, they go in the place where that type would go.
Files are named based on the thing they define; append the module name for things declared in other modules.
For example, an extension to `String` should go in `Values/Swift.String.swift`.

Typealiases get their own file, organized by the aliased type.
Place extensions to an aliased type in the same file as the typealias.

##  Character Input  ##

The character set of Nib is MacRoman + Emoji; these are all characters which should be available through ordinary Macintosh input methods.
(Linux users: You should be able to install a Macintosh keyboard layout on your system; I cannot help you when it comes to emoji [but recommend [fcitx](https://fcitx-im.org/wiki/Fcitx)].)

For your convenience, use of the following non·ASCII characters is planned:

| Codepoint | Character | Unicode Name | Macintosh U.S. Keyboard Input |
| :-: | :-: | --- | --- |
| U+00AB | « | LEFT-POINTING DOUBLE ANGLE QUOTATION MARK | `⌥ option` + `\` |
| U+00B7 | · | MIDDLE DOT | `⌥ option` + `⇧ shift` + `9` |
| U+00BB | » | RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK | `⌥ option` + `⇧ shift` + `\` |
| U+00F7 | ÷ | DIVISION SIGN | `⌥ option` + `/` |
| U+2022 | • | BULLET | `⌥ option` + `8` |
| U+2039 | ‹ | SINGLE LEFT-POINTING ANGLE QUOTATION MARK | `⌥ option` + `⇧ shift` + `3` |
| U+203A | › | SINGLE RIGHT-POINTING ANGLE QUOTATION MARK | `⌥ option` + `⇧ shift` + `4` |
| U+221A | √ | SQUARE ROOT | `⌥ option` + `V` |
| U+25CA | ◊ | LOZENGE | `⌥ option` + `⇧ shift` + `V` |

##  Naming Conventions  ##

The usual Swift naming conventions apply.
However, the names given in specifications take priority; this is especially true of grammars.
In some cases the specification name is a little more opaque or cumbersome than the common name which you might expect; oftentimes, maintaining this is important, because another specification will later redefine the common name with slightly different semantics.

Emoji may be used in non‐public code *only*.
The emoji `🙈`, `🙉`, `🙊` are used as markers of access control, signifying `private`, `fileprivate`, and `internal`, respectively.

The character `U+00B7 · MIDDLE DOT` is used in place of a hyphen; the following letter is not capitalized.
It is also used in abbreviations in place of Swift’s more idiomatic “write all the letters with the same case” convention; in this case, the following letter *is* capitalized.

Properties, functions, or methods explicitly provided for by a specification are written surrounded by middle dots, like `·this·`; this is to distinguish them from both (a) grammars et cetera which might have the same name, and (b) the idiomatic Swift interfaces, where better ones exist.
In the actual specifications, you might see `[this]` or `·this·` or `{this}` or similar.

##  Documentation Conventions  ##

Documentation should follow [ordinary Swift conventions](https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_markup_formatting_ref/SymbolDocumentation.html).
All public API terms should be documented, and each should have a `Version` callout describing when they were added.
Additional `Version` callouts should be used when additional features are added.

An `Authors` callout should be used for functions and computed properties, but *not* for protocol requirements or types.
All contributors to the implementation should put their names here.

Use `Note` callouts for documenting ambiguous cases in the spec, differences in the implementation, or common gotchas with use.

Functions which take parameters should have a `Parameters` section; functions which return should have a `Returns`, and functions which throw should have a `Throws`.

---

Copyright © 2021 kibigo!

[This file](https://github.com/marrus-sh/Nib/blob/current/CONTRIBUTING.markdown) is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International Public License](https://creativecommons.org/licenses/by-sa/4.0/) 🅭🅯🄎.
