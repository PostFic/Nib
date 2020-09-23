import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.Sequence` of `XSD.BinaryDigit`s to a
	///   `XSD.hexOctet`.
	///
	///  +  parameters:
	///      +  d:
	///         A `XSD.Sequence` of four `XSD.BinaryDigit`s.
	///
	///  +  returns:
	///     A `XSD.hexDigit`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-hexDigitCanonical>
	@inlinable
	static func ·hexDigitCanonical·(
		_ d: XSD.Sequence<XSD.BinaryDigit>
	) -> XSD.hexDigit {
		var iterator = d.makeIterator()
		let result: String
		if iterator.next() == .０ {
			if iterator.next() == .０ {
				if iterator.next() == .０ {
					result = iterator.next() == .０ ? "0" : "1"
				}
				else { result = iterator.next() == .０ ? "2" : "3" }
			}
			else {
				if iterator.next() == .０ {
					result = iterator.next() == .０ ? "4" : "5"
				}
				else { result = iterator.next() == .０ ? "6" : "7" }
			}
		} else {
			if iterator.next() == .０ {
				if iterator.next() == .０ {
					result = iterator.next() == .０ ? "8" : "9"
				}
				else { result = iterator.next() == .０ ? "A" : "B" }
			}
			else {
				if iterator.next() == .０ {
					result = iterator.next() == .０ ? "C" : "D"
				}
				else { result = iterator.next() == .０ ? "E" : "F" }
			}
		}
		return result◊
	}

}
