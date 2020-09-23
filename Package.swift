// swift-tools-version:5.0
import PackageDescription

let package = Package(
	/// ✒💦 A Swift implementation of XSD datatypes for RDF.
	name: "Nib",
	products: [
		.library(
			name: "Nib",
			targets: ["XSDValues"]
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
			name: "XSDLiterals",
			dependencies: ["XSD"]
		),
		.target(
			name: "XSDValues",
			dependencies: ["XSDLiterals"]
		),
		//.target(name: "XSDDatatypes", dependencies: ["XSDValues"]),
		.testTarget(
			name: "XSDTests",
			dependencies: ["XSD"]
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
