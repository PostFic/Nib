// swift-tools-version:5.0
import PackageDescription

let package = Package(
	/// ✒💦 A Swift implementation of XSD datatypes for RDF.
	name: "Nib",
	products: [
		.library(
			name: "Nib",
			targets: ["Core", "EBNF"]
		),
	],
	dependencies: [
	],
	targets: [
		.target(
			name: "Core",
			dependencies: []
		),
		.target(
			name: "EBNF",
			dependencies: ["Core"]
		),
//		.target(
//			name: "XML11",
//			dependencies: ["Core", "EBNF"]
//		),
//		.target(
//			name: "XSD",
//			dependencies: ["XML11"]
//		),
//		.testTarget(
//			name: "XML11Tests",
//			dependencies: ["XML11"]
//		),
//		.testTarget(
//			name: "XSDTests",
//			dependencies: ["XSD"]
//		)
	],
	swiftLanguageVersions: [.v5]
)
