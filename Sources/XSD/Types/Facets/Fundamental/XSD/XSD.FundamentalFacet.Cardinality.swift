public extension XSD.FundamentalFacet {

	final class Cardinality: XSDFundamentalFacet, XSDAnnotated {

		public enum Keyword: String {

			case finite

			case countablyInfinite = "countably infinite"

		}

		public convenience init(
			baseTypeDefinition: XSDSimpleTypeDefinition,
			facets: XSDConstrainingFacets,
			primitiveTypeDefinition: XSDSimpleTypeDefinition
		) throws {
			guard let cardinality = (
				baseTypeDefinition.fundamentalFacets[.cardinality] as? Cardinality
			)?.value else {
				throw XSD.ConstraintOnSchemasError.baseTypeMustHaveFacet("cardinality")
			}
			if
				cardinality == .finite ||
				facets[.length] is XSD.ConstrainingFacet.Length ||
				facets[.maxLength] is XSD.ConstrainingFacet.MaxLength ||
				facets[.totalDigits] is XSD.ConstrainingFacet.TotalDigits ||
				(
					facets[.minInclusive] is XSD.ConstrainingFacet.MinInclusive ||
					facets[.minExclusive] is XSD.ConstrainingFacet.MinExclusive
				) &&
				(
					facets[.maxInclusive] is XSD.ConstrainingFacet.MaxInclusive ||
					facets[.maxExclusive] is XSD.ConstrainingFacet.MaxExclusive
				) &&
				(
					facets[.fractionDigits] is XSD.ConstrainingFacet.FractionDigits ||
					baseTypeDefinition.primitiveTypeDefinition ===
					XSD.date.definition ||
					baseTypeDefinition.primitiveTypeDefinition ===
					XSD.gYearMonth.definition ||
					baseTypeDefinition.primitiveTypeDefinition ===
					XSD.gYear.definition ||
					baseTypeDefinition.primitiveTypeDefinition ===
					XSD.gMonthDay.definition ||
					baseTypeDefinition.primitiveTypeDefinition ===
					XSD.gDay.definition ||
					baseTypeDefinition.primitiveTypeDefinition ===
					XSD.gMonth.definition
				)
			{
				self.init(value: .finite)
			} else {
				self.init(value: .countablyInfinite)
			}
		}

		public convenience init(
			baseTypeDefinition: XSDSimpleTypeDefinition,
			facets: XSDConstrainingFacets,
			itemTypeDefinition: XSDSimpleTypeDefinition
		) throws {
			if
				facets[.length] is XSD.ConstrainingFacet.Length ||
				facets[.minLength] is XSD.ConstrainingFacet.MinLength &&
				facets[.maxLength] is XSD.ConstrainingFacet.MaxLength,
				let cardinality = (
					itemTypeDefinition.fundamentalFacets[.cardinality] as? Cardinality
				)?.value,
				cardinality == .finite
			{
				self.init(value: .finite)
			} else {
				self.init(value: .countablyInfinite)
			}
		}

		public convenience init(
			baseTypeDefinition: XSDSimpleTypeDefinition,
			facets: XSDConstrainingFacets,
			memberTypeDefinitions: [XSDSimpleTypeDefinition]
		) throws {

			/// Processes members, returning a value.
			func handle(_ members: [XSDSimpleTypeDefinition]) throws -> Keyword {
				for member in members {

					/*
					If our `member` is a `union`, then we handle *its* members instead.
					*/
					if
						let memberVariety = member.variety,
						memberVariety == .union
					{
						if try handle(member.memberTypeDefinitions ?? []) == .countablyInfinite {
							return .countablyInfinite
						}
						continue
					}

					/*
					If our `member` isn't `finite`, then our union must not be.
					*/
					guard let cardinality = (
						member.fundamentalFacets[.cardinality] as? Cardinality
					)?.value else {
						throw XSD.ConstraintOnSchemasError.memberTypeMustHaveFacet("cardinality")
					}
					if cardinality == .countablyInfinite {
						return .countablyInfinite
					}

				}
				return .finite
			}

			self.init(value: try handle(memberTypeDefinitions))
		}

		public let value: Keyword

		public init(value: Keyword) {
			self.value = value
			super.init(📛: "cardinality")
		}

		public override func equivalent(to other: XSDFacet) -> Bool {
			guard let otherValue = (other as? Cardinality)?.value else {
				return false
			}
			return value == otherValue
		}

	}

}
