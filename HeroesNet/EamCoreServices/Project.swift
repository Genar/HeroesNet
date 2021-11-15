import ProjectDescription

let project = Project(
  name: "EamCoreServices",
  organizationName: "Genar",
  settings: nil,
  targets: [
    Target(
      name: "EamCoreServices",
      platform: .iOS,
      product: .framework,
      bundleId: "org.genar.EamCoreServices",
      infoPlist: "EamCoreServices/Info.plist",
      sources: ["EamCoreServices/Source/**"],
      settings: nil),
    
    Target(
      name: "EamCoreServicesTests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "org.genar.EamCoreServicesUnitTests",
      infoPlist: "EamCoreServicesTests/Info.plist",
      sources: ["EamCoreServicesTests/Source/**"],
      dependencies: [
        .target(name: "EamCoreServices")
      ])
  ])
