import Common

public extension XSD.ConstrainingFacet {

	final class Length: XSDFixedValuebasedFacet, XSDAnnotated {

		public let value: XSDValue

		public init(value: UInt, fixed: Bool = false) {
			self.value = [🌌Decimal(value)!]
			super.init(📛: "length", fixed: fixed)
		}

		public override func canConstrain(_ facets: XSDConstrainingFacets) throws {
			try super.canConstrain(facets)
			if
				let minLength = facets[.minLength] as? MinLength,
				minLength.value ⋠ value
			{
				throw XSD.SchemaComponentConstraintError.lengthAndMinLengthOrMaxLength
			}
			if
				let maxLength = facets[.maxLength] as? MaxLength,
				value ⋠ maxLength.value
			{
				throw XSD.SchemaComponentConstraintError.lengthAndMinLengthOrMaxLength
			}
			if
				let length = facets[.length] as? Length,
				value ≭ length.value
			{
				throw XSD.SchemaComponentConstraintError.lengthValidRestriction
			}
		}

		public override func equivalent(to other: XSDFacet) -> Bool {
			guard let otherValue = (other as? Length)?.value else {
				return false
			}
			return value ≍ otherValue
		}

		public func 🆗(_ value: XSDValue, as type: XSDDatatype) throws {
			guard let variety = type.definition.variety else {
				throw XSD.ValidationRuleError.maxLengthValid
			}
			switch variety {
			case .atomic:
				guard let primitive = type.definition.primitiveTypeDefinition else {
					throw XSD.ValidationRuleError.maxLengthValid
				}
				if
					primitive === XSD.string.definition ||
					primitive === XSD.anyURI.definition
				{
					guard
						let string = value.string,
						string.unicodeScalars.count == self.value.uInt!
					else {
						throw XSD.ValidationRuleError.maxLengthValid
					}
				} else if primitive === XSD.hexBinary.definition {
					guard
						let data = value.data,
						data.count == self.value.uInt!
					else {
						throw XSD.ValidationRuleError.maxLengthValid
					}
				} else if primitive === XSD.base64Binary.definition {
					guard
						let data = value.data,
						data.count == self.value.uInt!
					else {
						throw XSD.ValidationRuleError.maxLengthValid
					}
				} else if
					primitive === XSD.QName.definition ||
					primitive === XSD.NOTATION.definition
				{
					return
				} else {
					throw XSD.ValidationRuleError.maxLengthValid
				}
			case .list:
				guard value.count == self.value.uInt! else {
					throw XSD.ValidationRuleError.maxLengthValid
				}
			default:
				throw XSD.ValidationRuleError.maxLengthValid
			}
		}

	}

}
