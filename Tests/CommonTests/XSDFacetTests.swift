import XCTest
@testable import Common

final class FacetTests: XCTestCase {

	/// Tests to ensure that the behaviour of `XSDConstrainingFacet`s in sets is as desired.
	func testXSDConstrainingFacetSetInclusion() {
		let facet = XSDConstrainingFacet(📛: "aFacet")
		let facetSet: XSDConstrainingFacets = [facet]
		let selectedFacet = facetSet["aFacet"]
		XCTAssertNotNil(selectedFacet)
		XCTAssert(facet === selectedFacet)
	}

	/// Tests to ensure that the behaviour of `XSDFundamentalFacet`s in sets is as desired.
	func testXSDFundamentalFacetSetInclusion() {
		let facet = XSDFundamentalFacet(📛: "aFacet")
		let facetSet: XSDFundamentalFacets = [facet]
		let selectedFacet = facetSet["aFacet"]
		XCTAssertNotNil(selectedFacet)
		XCTAssert(facet === selectedFacet)
	}

}
