# HeroesNet
Using the Marvel API to get information forms the different characters.

## Project arquitecture

The app has been developed using the MVVM-C (Model-View-ViewModel-Coordinator) pattern.

<img width="721" alt="MVVM-C" src="https://user-images.githubusercontent.com/432215/141301513-c567c82b-a64a-4b5c-b7e2-07033ce0d0c6.png">

In addition, all the parameters to initialise a view model and other classes are protocols so that we can inject both "real" instances or mock instances (i.e. to execute unit tests).

The project compiles with the last version of Xcode (at time of this writing the last version of Xcode is 13.1 and the last version of tuist is 2.1.1).

## Compilation process

The project in the main branch has been modified to use "tuist".

[![Tuist badge](https://img.shields.io/badge/Powered%20by-Tuist-blue)](https://tuist.io)

"tuist" is a tool that generates .xcodeproj and .xcworkspace files;
this is the reason why, after downloading the project, those files do not exist. To compile and run the app, please follow the following instructions.

-- Install tuist: Open a terminal and execute

    bash <(curl -Ls https://install.tuist.io)

-- Download the project from the main branch

-- Open a terminal and go to the folder "HeroesNet/HeroesNet" (it contains the Project.swift file, which is the manifest for the "tuist" tool).

-- Once you are in the aforementioned folder execute:

    tuist generate
    
  If every think is OK, you will see a message saying "Project generated"; this means that the .xcdoeproj and xcworspace files have been generated.
    
-- Finally you can open the project using Xcode (open the .xcworkspace file), or simply execute the following command from the terminal:

    xed .
    
  This command will open Xcode and then you will be able to run the app, the unit tests and the UI tests.
  
-- IMPORTANT: It has been developed a script called **buildtuist.sh**, in the directory HeroesNet/HeroesNet, which executes the previous steps for you and
finally it opens Xcode with the proyect and its libraries loaded, and also the schemes to run both the app and also the tests.

## Project structure

The project has the following folder structure:

HeroesNet : The main app.

Inside "Project -> HeroesNet -> Source" there are the following folders:

  -- Repository : Contains specific calls to webservices and network status. ViewModels will call the public methods of this Repository. It acts as the "Model" shown in the previous picture.
  
  -- Modules: This is the main part of the app; it contains a module for every "screen" of the app (that is, there is a module for the list of the heroes
  and another module for the detail of the hero).
  
  Every module has been structured to follow the MVVM-C pattern; so every module is structured to contain every layer of the MVVM-C pattern.
  
  Inside "Project -> HeroesNet" there are the following folders:
  
  -- Resources: Contains assets and localizable strings.
  
  -- Application : Contains generic application files like AppDelegate, LaunchScreen, Storyboard, etc.
  
  The "Project" folder contains also the folders for the tests:
  
  -- HeroesNetTests: Contains Unit test for the ViewModels of the app.
  
  -- HeroesNetUITests : Default UI test.

  
EamCoreServices: Framework that contains the implementation of generic webservices and reachability methods.
The **Repository** calls the methods implemented in that layer (which are implemented using protocols).

Inside the "Project" folder there are:

  -- EamCoreServices: Inside the "Source" folder:
  
    -- WebServices: Implementation of generic web services.
    
    -- ReachabilityService: Implementation of generic reachability services.
    
  -- EamCoreServicesTests : Includes test for the NetworkRequestService
  
-- EamCoreUtils : Framework that contains the implementation of several utilities.

  -- EamCoreUtils: Inside the "Source" folder:
  
    -- Binding : Utility to add one-way binding for UILabel and two-way binding for UITextField.
    It will be used by the ViewModels; paritculary, BoundLabel is a bindable label which can be updated from the viewmodel.
    
    -- Network : Utility which provides a method to download iamges asynchronously.
    
    -- BaseCoordinator : Provides a protocol that all the coordinators of the app must implement.
    
    -- Storyboard : Provides a helper method to load a viewcontroller form the Storyboard.
    
  -- EamCoreUtilsTests : Not implemented yet.
  
