// swift-tools-version:5.0
import PackageDescription

let package = Package(
	/// ✒💦 A Swift implementation of XSD datatypes for RDF.
	name: "Nib",
	products: [
		.library(
			name: "Nib",
			targets: ["XSDLiterals"]
		)
	],
	dependencies: [
	],
	targets: [
		.target(
			name: "XSD",
			dependencies: []
		),
		.target(
			name: "XSDRegularExpressions",
			dependencies: ["XSD"]
		),
		.target(
			name: "XSDLiterals",
			dependencies: ["XSDRegularExpressions"]
		),
		.target(
			name: "XSDValues",
			dependencies: ["XSDLiterals"]
		),
		//.target(name: "XSDDatatypes", dependencies: ["XSDValues"]),
		.testTarget(
			name: "XSDRegularExpressionTests",
			dependencies: ["XSDRegularExpressions"]
		),
		.testTarget(
			name: "XSDLiteralTests",
			dependencies: ["XSDLiterals"]
		),
		.testTarget(
			name: "XSDValueTests",
			dependencies: ["XSDValues"]
		),
		//.testTarget(name: "XSDDatatypeTests", dependencies: ["XSDDatatypes"])
	],
	swiftLanguageVersions: [.v5]
)
