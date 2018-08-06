import XCTest
@testable import Common

final class FacetTests: XCTestCase {

	/// Tests to ensure that the behaviour of `XSDFundamentalFacet`s in sets is as desired.
	func testFundamentalFacetSetInclusion() {
		let orderedFacet = XSDFundamentalFacet.ordered(value: .false)
		let facetSet: Set<XSDFundamentalFacet> = [orderedFacet]
		let selectedFacet = facetSet[.📛("ordered")]
		XCTAssertNotNil(selectedFacet)
		switch selectedFacet! {
		case .ordered:
			break
		default:
			XCTFail()
		}
	}

	/// Tests to ensure that the behaviour of `XSDFundamentalFacet`s in sets is as desired.
	func testConstrainingFacetSetInclusion() {
		let patternFacet = XSDConstrainingFacet.pattern(
			annotations: [],
			value: [try! XSDRegularExpression("")]
		)
		let facetSet: Set<XSDConstrainingFacet> = [patternFacet]
		let selectedFacet = facetSet[.📛("pattern")]
		XCTAssertNotNil(selectedFacet)
		switch selectedFacet! {
		case .pattern:
			break
		default:
			XCTFail()
		}
	}

}
