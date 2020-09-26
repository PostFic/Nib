import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.hexDigit` to a `XSD.Sequence` of four
	///   `XSD.BinaryDigit`s.
	///
	///  +  parameters:
	///      +  d:
	///         A `XSD.hexDigit`.
	///
	///  +  returns:
	///     A `XSD.Sequence` of four `XSD.BinaryDigit`s.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-hexDigitMap>
	@inlinable
	static func ·hexDigitMap· (
		_ d: XSD.hexDigit
	) -> XSD.Sequence <XSD.BinaryDigit> {
		return sequence(
			state: 0 as UInt8
		) { state in
			let nextState = state as! UInt8 + 1
			guard nextState < 5
			else
			{ return nil }
			state = nextState
			switch String(d) {
			case "0":
				return .０
			case "1":
				return nextState == 4 ? .１ : .０
			case "2":
				return nextState == 3 ? .１ : .０
			case "3":
				return nextState == 1 || nextState == 2 ? .０ : .１
			case "4":
				return nextState == 2 ? .１ : .０
			case "5":
				return nextState == 1 || nextState == 3 ? .０ : .１
			case "6":
				return nextState == 1 || nextState == 4 ? .０ : .１
			case "7":
				return nextState == 1 ? .０ : .１
			case "8":
				return nextState == 1 ? .１ : .０
			case "9":
				return nextState == 1 || nextState == 4 ? .１ : .０
			case "A", "a":
				return nextState == 1 || nextState == 3 ? .１ : .０
			case "B", "b":
				return nextState == 2 ? .０ : .１
			case "C", "c":
				return nextState == 1 || nextState == 2 ? .１ : .０
			case "D", "d":
				return nextState == 3 ? .０ : .１
			case "E", "e":
				return nextState == 4 ? .０ : .１
			case "F", "f":
				return .１
			default:
				fatalError("Expected a hex digit but got \(d)")
			}
		}
	}

}
