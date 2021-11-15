import ProjectDescription

let project = Project(
  name: "EamCoreUtils",
  organizationName: "Genar",
  settings: nil,
  targets: [
    Target(
      name: "EamCoreUtils",
      platform: .iOS,
      product: .framework,
      bundleId: "org.genar.EamCoreUtils",
      infoPlist: "EamCoreUtils/Info.plist",
      sources: ["EamCoreUtils/Source/**"],
      settings: nil),
    
    Target(
      name: "EamCoreUtilsTests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "org.genar.EamCoreUtilsUnitTests",
      infoPlist: "EamCoreUtilsTests/Info.plist",
      sources: ["EamCoreUtilsTests/Source/**"],
      dependencies: [
        .target(name: "EamCoreUtils")
      ])
    
  ])
