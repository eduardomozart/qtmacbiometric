# QtMacBiometric

Proof of concept on how to implement Touch ID support using Qt/C. Theorically it can be integrated with https://github.com/frankosterfeld/qtkeychain/tree/main to implement Touch ID support on macOS.

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
