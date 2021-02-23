#  Nib :: XML EBNF  #

##  Introduction  ##

This module implements a processor for the *semantics* of the Extended Backus‐Naur Form described in “§6 Notation” of the XML 1.1 specification.
It does *not* provide a parser for the XML EBNF *syntax*, instead implementing a Swift DSL for writing EBNF expressions.

###  Limitations  ###

Nib EBNF is simple and greedy, which means that constructions must be constructed somewhat carefully.
For example, consider the following rules:

    S ::= (#x20 | #x9 | #xD | #xA)+
    endsWithSpace ::= "something" S?
    somethingMore ::= endsWithSpace S "else"

Because `S` matches any number of spaces, `endsWithSpace` will greedily “gobble up” all of the available spaces. This means that the `S` in `somethingMore` will never match, even if there are multple spaces between `"something"` and `"else"`.

The above limitation is not an issue with any of the XML EBNF productions, with one notable exception:
XML rules which contain something of the form `A - (Char* B Char*)`.
Nib EBNF introduces an alternate expression, `A ÷ B`, which only matches for `A` up until the first occurrence of `B`, if present, for handling this case.

Nib EBNF choices always select the first possible match out of a set of options.
So, here is another impossible situation:

    postfix ::= "*"
    postfixed ::= expression postfix
    expression ::= "$" | postfixed

`expression` will never match `$*`, because matching the `$` will “shortcircuit” the expression.
This can’t be fixed by reversing the choices either, as this will create an infinite loop between `expression` and `postfixed`.
Instead, one must write

    properExpression ::= "$" postfix*

As a result of these limitations, there is no way for Nib EBNF to build a tree of nested postfix expressions.
Fortunately, this is not needed for XML.

###  Symbols  ###

Each EBNF `Expression` must have an associated `.Symbol` `Symbolic` type, which *should* be an enumeration.
This type is the associated type for `Expression.symbol`s, which can be used to add recursion into the expressions.
(Because `Expression`s are value types, one cannot simply nest one inside itself without this kind of indirection.)

`Symbolic` types must also be `Versionable`, meaning that they must have a `.Version` associated type.
In the case of `Symbolic` types, this `.Version` must be `Defaultable`; i.e. it must have a static `.default`.
In many cases, only a default version will be needed, but this mechanism can be used to provide different `.expression`s for `.Symbol`s depending on the version of the underlying specification being used.

###  String Conversions  ###

Each EBNF expression has a canonical `.description` which closely resembles, but does not match, the syntax used in the XML specification.
This can aid in testing and debugging expressions.

Nib provides EBNF for EBNF descriptions themselves!
These are available in the `DescriptionSymbol` enumeration.
EBNF `Expression`s are not strictly speaking `LosslessStringConvertible`, but there is a failable initializer to generate an *equivalent* expression from their `.description` strings.
Using the DSL when possible is generally preferred.

##  List of Expressions  ##

A table summarizing the various EBNF expressions is below:

| XML | DSL | `.description` | Expression kind |
| :-: | :-: | :-: | --- |
| `#x2764` | `"\u{2764}"` | `£2764;` | `.character` |
| `[#x2620#xFE0F#x1F496]` | `√"\u{2620}\u{FE0F}\u{1F496}"` | `⟨£2620;£FE0F;£1F496;⟩` | `.anyOf` |
| `[#x1F494-#x1F49D]` | `√["\u{1F494}"..."\u{1F49D}"]` | `⟨£1F494;-£1F49D;⟩` | `.anyOf` |
| `[^#x2620#xFE0F#x1F496]` | `^"\u{2620}\u{FE0F}\u{1F496}"` | `⟨∼£2620;£FE0F;£1F496;⟩` | `.noneOf` |
| `[^#x1F494-#x1F49D]` | `^["\u{1F494}"..."\u{1F49D}"]` | `⟨∼£1F494;-£1F49D;⟩` | `.noneOf` |
| `"string"` | `"string"` | `‹string›` | `.string` |
| `symbol` | `symbol®` | `symbol` | `.symbol` |
| <code>A &#x7C; B</code> | <code>A &#x7C; B</code> | <code>(A &#x7C; B)</code> | `.choice` |
| <code>A &#x7C; B &#x7C; C</code> | `∑[A, B, C]` | <code>(A &#x7C; B &#x7C; C)</code> | `.choice` |
| `A B` | `A & B` | `(A B)` | `.sequence` |
| `A B C` | `∏[A, B, C]` | `(A B C)` | `.sequence` |
| `A - B` | `A - B` | `(A − B)` | `.excluding` |
| `A - (Char* B Char*)` | `A ÷ B` | `(A ÷ B)` | `.notIncluding` |
| `A?` | `A^?` | `(A?)` | `.zeroOrOne` |
| `A+` | `A^+` | `(A+)` | `.oneOrMore` |
| `A*` | `A^*` | `(A×)` | `.zeroOrMore` |

###  `.character`  ###

Where `N` is a Unicode codepoint :—

 +  XML EBNF: `#xN`
 +  Swift DSL: `"\u{N}"`
 +  `.description`: `£N;`

Matches a single Unicode codepoint.

Printable ASCII characters are treated as `.strings` for their `.description`.

###  `.anyOf`  ###

Where `I`, `J`, `K`, `M`, and `N` are Unicode codepoints :—

 +  XML EBNF: `[#xI#xJ#xK]`, `[#xM-#xN]`
 +  Swift DSL: `√"\u{I}\u{J}\u{K}"`; `√["\u{M}"..."\u{N}"]`
 +  `.description`: `⟨£I;£J;£K;⟩`; `⟨£M;–£N;⟩`

Matches a range of Unicode codepoints.
Any number of characters or character ranges may be provided within the array syntax.
 
Always fails to match things which are not XML 1.1 `Char`s; namely, high and low surrogates, `U+0000`, `U+FFFE`, and `U+FFFF`.

Printable ASCII characters are given literally in the `.description`, except for space.
 
The dash in the `.description` is a `U+2013 – EN DASH`.
 
 ###  `.noneOf`  ###

 +  XML EBNF: `[^#xI#xJ#xK]`, `[^#xM-#xN]`
 +  Swift DSL: `^"\u{I}\u{J}\u{K}"`; `^["\u{M}"..."\u{N}"]`
 +  `.description`: `⟨∼£I;£J;£K;⟩`; `⟨∼£M;–£N;⟩`
 
Matches any XML 1.1 `Char` not in a range of Unicode codepoints.
Any number of characters or character ranges may be provided within the array syntax.
 
Always fails to match things which are not XML 1.1 `Char`s; namely, high and low surrogates, `U+0000`, `U+FFFE`, and `U+FFFF`.

Printable ASCII characters (excluding space) are given literally in the `.description`.
 
The dash in the `.description` is a `U+2013 – EN DASH`.
The tilde is a `U+223C ∼ TILDE OPERATOR`.
 
 ###  `.string`  ###

Where `string` is a string :—

 +  XML EBNF: `"string"`
 +  Swift DSL: `"\(string)"`
 +  `.description`:
     +  Printable ASCII characters (excluding space) only: `string` wrapped in `‹` and `›`
     +  Other characters only: As if it were a `.sequence` of `.characters`
     +  Both printable ASCII characters (excluding space) and other characters: As if it were a `.sequence` of `.characters` and ASCII `.string`s, as above.
 
Matches the sequence of Unicode codepoints given by `string`.

###  `.symbol`  ###

Where `symbol` is a `.Symbol` :—

 +  XML EBNF: `symbol`
 +  Swift DSL: `symbol®`
 +  `.description`: `symbol.name`.
 
Matches `symbol.expression`.

###  `.choice`  ###

Where `A`, `B`, and `C` are `Expression`s :—

 +  XML EBNF: `A | B`; `A | B | C`
 +  Swift DSL: `A | B`; `∑[A, B, C]`
 +  `.description`: `(A | B)`; `(A | B | C)`
 
Matches `A`, `B`, or `C` (always selecting whichever matches first).

The `‖[A, B, C]` form is preferred whenever choosing between more than two options, because it helps the Swift typechecker infer types more easily.

`‖` is `U+2016 ‖ DOUBLE VERTICAL LINE`, not two `U+007C | VERTICAL LINES`.

###  `.sequence`  ###

Where `A`, `B`, and `C` are `Expression`s :—

 +  XML EBNF: `A B`; `A B C`
 +  Swift DSL: `A & B`; `∏[A, B, C]`
 +  `.description`: `(A B)`; `(A B C)`
 
Matches `A`, `B`, and `C` in order.

###  `.excluding`  ###

Where `A` and `B` are `Expression`s :—

 +  XML EBNF: `A - B`
 +  Swift DSL: `A - B`
 +  `.description`: `(A − B)`
 
Matches `A` only if `B` does not also (exactly) match.

The minus is `U+2212 − MINUS SIGN`.

###  `.notIncluding`  ###

Where `A` and `B` are `Expression`s :—

 +  XML EBNF: `A - (Char* B Char*)`
 +  Swift DSL: `A ÷ B`
 +  `.description`: `(A ÷ B)`
 
Matches `A`, if possible, but only up until the first occurrence of `B`, if present.

###  `.zeroOrOne`  ###

Where `A` is an `Expression` :—

 +  XML EBNF: `A?`
 +  Swift DSL: `A^?`
 +  `.description`: `(A?)`
 
Matches `A` zero or one times.

###  `.oneOrMore`  ###

Where `A` is an `Expression` :—

 +  XML EBNF: `A+`
 +  Swift DSL: `A^+`
 +  `.description`: `(A+)`
 
Matches `A` one or more times.

###  `.zeroOrMore`  ###

Where `A` is an `Expression` :—

 +  XML EBNF: `A*`
 +  Swift DSL: `A^*`
 +  `.description`: `(A×)`
 
Matches `A` zero or more times.

---

Copyright © 2021 kibigo!
[This file](https://github.com/marrus-sh/Nib/blob/current/Sources/E·B·N·F/Documentation/README.markdown) is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International Public License](https://creativecommons.org/licenses/by-sa/4.0/) 🅭🅯🄎.
