// swift-tools-version:5.3
import PackageDescription

let package = Package(

	/// ✒💦 A Swift implementation of XSD datatypes for RDF.
	name: "Nib",

	products: [
		.library(
			name: "Nib",
			targets: ["Core", "EBNF"]
		)
	],

	dependencies: [

	],

	targets: [
		.target(
			name: "Core",
			dependencies: [],
			exclude: ["Documentation"]
		),
		.target(
			name: "EBNF",
			dependencies: ["Core"]
		)
	],

	swiftLanguageVersions: [.v5]

)
