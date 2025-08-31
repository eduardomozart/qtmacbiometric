#include "biometricauth.h"
#include <LocalAuthentication/LocalAuthentication.h>
#include <QDebug>
#include <QCoreApplication>

class BiometricAuthPrivate {
public:
    explicit BiometricAuthPrivate(BiometricAuth *q) : q_ptr(q) {}

    void authenticate(const QString &reason) {
        LAContext *context = [[LAContext alloc] init];
        NSError *error = nil;

        // Check if authentication is possible with biometrics
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                     localizedReason:reason.toNSString()
                               reply:^(BOOL success, NSError *authError) {
                // This block is executed on a background thread, so we must
                // emit signals on the main thread
                QMetaObject::invokeMethod(q_ptr, [=]() {
                    if (success) {
                        emit q_ptr->authenticationSucceeded();
                    } else {
                        // Handle different error codes
                        if (authError.code == LAErrorUserCancel) {
                            emit q_ptr->authenticationCanceled();
                        } else {
                            emit q_ptr->authenticationFailed(QString::fromNSString(authError.localizedDescription));
                        }
                    }
                });
            }];
        } else {
            // Biometric authentication not available or not configured
            qDebug() << "Biometric authentication not available:" << QString::fromNSString(error.localizedDescription);
            emit q_ptr->authenticationFailed(QString::fromNSString(error.localizedDescription));
        }
    }

private:
    BiometricAuth *q_ptr;
};

BiometricAuth::BiometricAuth(QObject *parent)
    : QObject(parent),
      d_ptr(new BiometricAuthPrivate(this))
{
}

BiometricAuth::~BiometricAuth()
{
    delete d_ptr;
}

void BiometricAuth::authenticate(const QString &reason)
{
    d_ptr->authenticate(reason);
}
