// swift-tools-version:5.3
import PackageDescription

let package = Package(
	/// ✒💦 A Swift implementation of XSD datatypes for RDF.
	name: "Nib",
	products: [
		.library(
			name: "Nib",
			targets: ["Core", "E·B·N·F", "L·E·I·R·I"]
		),
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
//		.target(
//			name: "X·M·L",
//			dependencies: ["Core", "E·B·N·F"],
// 			exclude: ["Documentation"]
//		),
//		.target(
//			name: "Names",
//			dependencies: ["Core", "E·B·N·F", "X·M·L"],
// 			exclude: ["Documentation"]
//		),
//		.target(
//			name: "Infoset",
//			dependencies: ["Core", "X·M·L", "Names"],
// 			exclude: ["Documentation"]
//		),
//		.target(
//			name: "X·S·D",
//			dependencies: ["X·M·L"],
// 			exclude: ["Documentation"]
//		),
		.testTarget(
			name: "E·B·N·F·Tests",
			dependencies: ["Core", "E·B·N·F"],
			exclude: ["Documentation"]
		),
//		.testTarget(
//			name: "X·M·L·Tests",
//			dependencies: ["Core", "E·B·N·F", "X·M·L"],
// 			exclude: ["Documentation"]
//		),
//		.testTarget(
//			name: "X·S·D·Tests",
//			dependencies: ["Core", "E·B·N·F", "X·S·D"],
// 			exclude: ["Documentation"]
//		)
	],
	swiftLanguageVersions: [.v5]
)
