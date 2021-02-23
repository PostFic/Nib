// swift-tools-version:5.3
import PackageDescription

let package = Package(

	/// ✒💦 A Swift implementation of XSD datatypes for RDF.
	name: "Nib",

	products: [
		.library(
			name: "Nib",
			targets: ["Core", "E·B·N·F", "L·E·I·R·I", "X·M·L"]
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
			name: "E·B·N·F",
			dependencies: ["Core"],
			exclude: ["Documentation"]
		),
		.target(
			name: "L·E·I·R·I",
			dependencies: ["Core", "E·B·N·F"],
			exclude: ["Documentation"]
		),
		.target(
			name: "X·M·L",
			dependencies: ["Core", "E·B·N·F", "L·E·I·R·I"],
 			exclude: ["Documentation"]
		),
		.testTarget(
			name: "E·B·N·F·Tests",
			dependencies: ["Core", "E·B·N·F"],
			exclude: ["Documentation"]
		),
		.testTarget(
			name: "X·M·L·Tests",
			dependencies: ["Core", "E·B·N·F", "L·E·I·R·I", "X·M·L"],
 			exclude: ["Documentation"]
		)
	],

	swiftLanguageVersions: [.v5]

)
