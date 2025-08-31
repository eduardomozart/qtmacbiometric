# QtMacBiometric

Proof of concept on how to implement Touch ID support using Qt/C. Theoretically, it can be integrated with https://github.com/frankosterfeld/qtkeychain/tree/main to implement Touch ID support on macOS.

There's no native biometric authentication module directly in the main Qt library. To implement biometric authentication on macOS (using Touch ID or Face ID), you'll need to use either a third-party library or write platform-specific code that bridges Qt with Apple's `LocalAuthentication` framework.

## Explanation of the Structure

Here is the folder structure for the Qt project with biometric authentication for macOS:

```
qtmacbiometric/
├── MyBiometricApp.pro
├── main.cpp
├── biometricauth.h
└── biometricauth.mm
```

  * **qtmacbiometric/**: This is the root directory of your project. The name of the folder is based on the `TARGET` variable in the `.pro` file.
    * **MyBiometricApp.pro**: This is the project file that `qmake` uses to generate the build files. It defines the project's sources, headers, and any platform-specific linker flags  to link against the necessary macOS frameworks.
    * **main.cpp**: This is the main source file that contains the `main()` function, which is the entry point of your application.
    * **biometricauth.h**: This is the header file for the BiometricAuth class, which declares the public API for the biometric functionality. This header defines the public API for your Qt application. It declares signals and slots, making it easy to use with other Qt components.
    * **biometricauth.mm:** This is the implementation file for the BiometricAuth class. The `.mm` extension is crucial as it tells the compiler to treat this file as a mix of C++ and Objective-C code, enabling it to access the native macOS LocalAuthentication framework. It includes the `LocalAuthentication` framework and uses Objective-C syntax to call the native APIs. A public Qt C++ class provides the API (e.g., `authenticate()`) and an internal Objective-C++ (`.mm`) class handles the native calls. This keeps the platform-specific code isolated. You can use the `BiometricAuth` class just like any other Qt object in your `main.cpp` or another C++ class.

## Building

```
qmake
make
```

## Running

```
qtmacbiometric % cd MyBiometricApp/Contents/MacOS
MacOS % ./MyBiometricApp 
Authentication successful!
MacOS % ./MyBiometricApp
Authentication canceled by user.
```
