#  Nib  #

A collection of Swift implementations of various XML specifications (and related work).

| Swift version | Nib version |
| :-: | :-: |
| 5.4 | 0.2-development |

Make something using Nib?
Feel free to talk about it in the [GitHub Discussions](https://github.com/marrus-sh/Nib/discussions/categories/demoscene).


##  What Is This?  ##

Formally, Nib is a [Swift Package Collection](https://github.com/apple/swift-package-manager/blob/main/Sources/PackageCollectionsModel/Formats/v1.md) which collects a number of related Swift packages, henceforth known as the **_Nib modules_**.
If you want, you *can* subscribe to Nib using:

    swift package-collection add https://go.KIBI.family/Nib/packages.json

However, this is more conceptual than practical.
Instead, you should think of this space as a sort of hub for collecting documentation, examples, and related work pertaining to the native support of X·M·L technologies in Swift, as overseen by [kibigo!](https://go.KIBI.family/About/#me).


##  Should I Use ~~This Library~~_These Libraries_?  ##

*Ideally,* **you should not.**
Nib is built as a highly precise/exact implementation of the algorithms present in the specifications it implements, which makes it more of a reference implementation than an optimized library for general usage.
*However,* there is something of a paucity of highly‐optimized native Swift implementations for the sorts of things that Nib accomplishes, so **you may find that it is the best, most‐reliable tool for the job nonetheless.**

The goal of the Nib project is to **_write code that could send you to the moon_**—i.e. code engineered for humans to use, with extensive documentation, which is failsafe in strange environments—not to write code which is fast, effective, or useful for business applications.

Nib modules take advantage of the flexibility of the Swift language to implement a number of DSLs for expressing common data structures or operations.
If you are going to be scared off by something like `.EmptyElemTag^! | .STag^! & .content^! & .ETag^!` then you might want to pick a different library.

**Nib requires an editor which supports Unicode and a programmer willing to input Unicode characters.**


##  License  ##

Copyright © 2021 kibigo!.

The files in this repository are licensed under the Creative Commons Attribution-ShareAlike 4.0 International Public License 🅭🅯🄎.
For more information, see [LICENSE](LICENSE).

Most Nib modules are licensed under the MPL 2.0.
