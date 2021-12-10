# HeroesNet
Uses the Marvel API to get information forms the different characters.

## Prerequissites

-- iOS 12 and up

-- Xcode 13 (possibly also works with Xcode 12).

-- tuist 2.1.1: The project includes a script called **buildtuist.sh** which installs it (see the last point of the **Compilation process** section).


## Project arquitecture

The app has been developed using the MVVM-C (Model-View-ViewModel-Coordinator) pattern.

![MVVM-C](https://user-images.githubusercontent.com/432215/142406868-deb7b169-8cb3-4ae3-bc37-45c7f2a7917a.png)


All the parameters to initialise "view model's" and other classes are protocols, consequently it is possible to inject both "real" instances or mock instances (i.e. to execute unit tests).

The project compiles with the last version of Xcode (at time of this writing the last version of Xcode is 13.1 and the last version of tuist is 2.1.1).

## Compilation process

The project in the main branch uses "tuist".

[![Tuist badge](https://img.shields.io/badge/Powered%20by-Tuist-blue)](https://tuist.io)

"tuist" is a tool that generates .xcodeproj and .xcworkspace files; this is the reason why, after downloading the project, those files do not exist in the main folder.

To compile and run the app, please follow the following instructions.

-- Install tuist: Open a terminal and execute

    bash <(curl -Ls https://install.tuist.io)

-- Download the project from the main branch

-- Open a terminal and go to the folder "HeroesNet/HeroesNet" (it contains the Project.swift file, which is the manifest for the "tuist" tool).

-- Once you are in the aforementioned folder, execute:

    tuist generate
    
  If every think is OK, you will see a message saying "Project generated"; this means that both the .xcodeproj and .xcworspace files have been generated.
    
-- Finally you can open the project using Xcode from the .xcworkspace file, or you can also execute the following command from the terminal:

    xed .
    
  This command will open Xcode and then you will be able to run the app, the unit tests and the UI tests.
  
-- IMPORTANT: After downlading the project from the **main** branch, you will notice that there is a script called **buildtuist.sh** in the directory **HeroesNet/HeroesNet**. This script executes all the aforementioned steps for you (like installing the last version of **tuist**, generating the project files),
and finally, it opens the proyect with Xcode (with all its libraries loaded, and also its schemes), to run both the app and the tests.

## Project structure

The project has the following folder structure:

**HeroesNet**: The main app.

Inside "Project -> HeroesNet -> Source" there are the following folders:

  -- **App**: Contains the **AppDelegate** class and an **AppDelegate+DependenciesInjection** class to perform dependencies injection.
  
  -- **Modules**: **This is the main part of the app**; it contains two modules, one for every "screen" of the app; that is, one module for the list of heroes
  and anothe module for the detail of the hero.
  
  Every module is structured to contain every layer of the MVVM-C pattern.
  
  Inside "**Project** -> **HeroesNet**" there are the following folders:
  
  -- **Resources**: Contains assets and localizable strings.
  
  -- **Application**: Contains UIKIt resources like LaunchScreen, Storyboard.
  
  Inside the "**Project**" folder there are the folders for the tests:
  
  -- **HeroesNetTests**: Contains Unit test for the ViewModels and Coordinators of the app.
  
  -- **HeroesNetUITests**: Default UI test.


**EamData**: Contains specific data entities related to the API provided by Marvel.

    Inside the "Project -> EamData -> Source" folder there are:
        
        -- Entities: For example; structs that are related to (and depend on) the API provided by Marvel
        
        -- Providers: For example, the implementation to call the API; but not the the interface (or protocol), which goes into the "EamDomain" layer.
    
    Note: Eam stands for "Enterprise Architecture Mobile" components; that is, components that can be created as a frameworks, so that they can be
      shared among different app's.
      

**EamDomain**: Contains specific models to decouple from the Data models and also the providers interfaces'.

    Inside the "Project -> EamDomain -> Source" folder there are:
    
        -- Models: Classes/Structs that are related to the business model (like HeroDomain, which is decoupled from its counterpart in the Data layer).
        
        -- Provider: Which contains the interfaces (that is, the counterpart of the implementation, which goes into the Data layer), to get the heroes.
        
        -- UseCase: It uses the provider to get the heroes; and then those "use cases" will be called from the ViewModel

At the end the main purpose is to have a clean architecture like:

<img width="454" alt="CleanArchitecture" src="https://user-images.githubusercontent.com/432215/142401462-c001780e-1617-4852-b234-34aa65916512.png">


**EamCoreServices**: Framework that contains the implementation of generic webservices and reachability methods.

The **Provider** calls the methods implemented in that layer.

Inside the "Project" folder there are:

  -- **EamCoreServices**: "Project -> EamCoreServices -> Source" contains:
  
    -- WebServices: Implementation of generic web services.
    
    -- ReachabilityService: Implementation of generic reachability services.
    
  -- **EamCoreServicesTests**: Includes test for the NetworkRequestService
  

**EamCoreUtils**: Framework that contains the implementation of several utilities.

  -- **EamCoreUtils**: "Project -> EamCoreUtils -> Source" contains:
  
    -- Binding: Utility to add one-way binding for UILabel and two-way binding for UITextField.
    
       It will be used by the ViewModels; paritculary, BoundLabel is a bindable label which can be updated
       from the viewmodel.
    
    -- Network: Utility which provides a method to download images asynchronously.
    
    -- BaseCoordinator: Provides a protocol which must be implemented by all the coordinators of the app.
    
    -- Storyboard: Provides a helper method to load a viewcontroller form the Storyboard.
    
  -- **EamCoreUtilsTests**: Not implemented yet.
  
