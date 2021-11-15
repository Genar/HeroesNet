import ProjectDescription

let project = Project(
  name: "EamData",
  organizationName: "Genar",
  settings: nil,
  targets: [
    Target(
      name: "EamData",
      platform: .iOS,
      product: .framework,
      bundleId: "org.genar.EamData",
      infoPlist: .default,
      sources: ["EamData/Source/**"],
      
      dependencies: [
        .project(target: "EamDomain",
                 path: .relativeToManifest("../EamDomain"))
        
                    ],
      
      settings: nil),
    
    Target(
      name: "EamDataTests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "org.genar.EamDataUnitTests",
      infoPlist: .default,
      sources: ["EamDataTests/Source/**"],
      dependencies: [
        .target(name: "EamData")
      ])
    
  ])
