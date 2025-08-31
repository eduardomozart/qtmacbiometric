TEMPLATE = app
TARGET = MyBiometricApp
QT += core gui widgets

SOURCES += main.cpp \
           biometricauth.mm

HEADERS += biometricauth.h

macx {
    LIBS += -framework LocalAuthentication \
            -framework Foundation
}