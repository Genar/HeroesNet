import ProjectDescription

let project = Project(
  name: "EamDomain",
  organizationName: "Genar",
  settings: nil,
  targets: [
    Target(
      name: "EamDomain",
      platform: .iOS,
      product: .framework,
      bundleId: "org.genar.EamDomain",
      infoPlist: .default,
      sources: ["EamDomain/Source/**"],
      
      dependencies: [
        .project(target: "EamCoreServices",
                 path: .relativeToManifest("../EamCoreServices"))
        
                    ],
      
      settings: nil),
    
    Target(
      name: "EamDomainTests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "org.genar.EamDomainUnitTests",
      infoPlist: .default,
      sources: ["EamDomainTests/Source/**"],
      dependencies: [
        .target(name: "EamDomain")
      ])
    
  ])
