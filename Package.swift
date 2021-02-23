// swift-tools-version:5.3
import PackageDescription

/// __Nib ✒💦:__ A Swift implementation of the XML suite of specifications.
let package = Package(

	name: "Nib",

	products: [
		.library(
			name: "Nib",
			targets: ["Core", "E·B·N·F", "L·E·I·R·I"]
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
		.testTarget(
			name: "E·B·N·F·Tests",
			dependencies: ["Core", "E·B·N·F"],
			exclude: ["Documentation"]
		)
	],

	swiftLanguageVersions: [.v5]

)
