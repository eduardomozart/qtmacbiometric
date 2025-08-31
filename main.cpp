#include <QApplication>
#include <QDebug>
#include "biometricauth.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    BiometricAuth auth;

    QObject::connect(&auth, &BiometricAuth::authenticationSucceeded, [](){
        qDebug() << "Authentication successful!";
        QApplication::quit();
    });

    QObject::connect(&auth, &BiometricAuth::authenticationFailed, [](const QString &error){
        qDebug() << "Authentication failed:" << error;
    });

    QObject::connect(&auth, &BiometricAuth::authenticationCanceled, [](){
        qDebug() << "Authentication canceled by user.";
    });

    auth.authenticate("Authenticate to unlock sensitive data.");

    return a.exec();
}