import ProjectDescription

let swiftlint = """
  if test -f /opt/homebrew/bin/swiftlint; then
    /opt/homebrew/bin/swiftlint  --config ./.swiftlint.yml
  fi
  """

let project = Project(
  name: "HeroesNet",
  organizationName: "Genar",
  settings: nil,
  targets: [
    Target(
      name: "HeroesNet",
      platform: .iOS,
      product: .app,
      bundleId: "org.genar.HeroesNet",
      infoPlist: "HeroesNet/Info.plist",
      sources: ["HeroesNet/Source/**"],
      resources: ["HeroesNet/Resources/**",
                  "HeroesNet/Application/**"],
      scripts: [
        .pre(script: swiftlint, name: "SwiftLint")
      ],
      dependencies: [
        .project(target: "EamCoreServices",
                 path: .relativeToManifest("EamCoreServices")),
        .project(target: "EamCoreUtils",
                 path: .relativeToManifest("EamCoreUtils"))
                    ],
      settings: nil),
    
    Target(
      name: "HeroesNetTests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "org.genar.HeroesNetUnitTests",
      infoPlist: "HeroesNetTests/Info.plist",
      sources: ["HeroesNetTests/Source/**"],
      dependencies: [
        .target(name: "HeroesNet")
      ]),
    
    Target(
      name: "HeroesNetUITests",
      platform: .iOS,
      product: .uiTests,
      bundleId: "org.genar.HeroesNetUITests",
      infoPlist: "HeroesNetUITests/Info.plist",
      sources: ["HeroesNetUITests/Source/**"],
      dependencies: [
        .target(name: "HeroesNet")
      ])
    
  ])
