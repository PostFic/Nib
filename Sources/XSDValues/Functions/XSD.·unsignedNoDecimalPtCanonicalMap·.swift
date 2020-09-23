import XSD
import XSDLiterals

public extension XSD {

	/// Maps an `XSD.Integer` to an `XSD.unsignedNoDecimalPtNumeral`,
	///   its canonical representation.
	///
	///  +  parameters:
	///      +  i:
	///         A nonnegative `XSD.Integer`.
	///
	///  +  returns:
	///     An `XSD.unsignedNoDecimalPtNumeral`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-unsNoDecCanFragMap>
	@inlinable
	static func ·unsignedNoDecimalPtCanonicalMap·(
		_ i: XSD.Integer
	) -> XSD.unsignedNoDecimalPtNumeral {
		var ·digitSeq·i = XSD.·digitSeq·(i)
		let ·lastSignificantDigit·digitRemainderSeq·i =
			XSD.·lastSignificantDigit·(XSD.·digitRemainderSeq·(i))
		var result: Array<String> = []
		result.reserveCapacity(
			Int(·lastSignificantDigit·digitRemainderSeq·i)
		)
		for _ in 0...·lastSignificantDigit·digitRemainderSeq·i {
			result += CollectionOfOne(
				String(describing: XSD.·digit·(·digitSeq·i.next()!))
			)
		}
		return result.reversed().joined()◊
	}

}
