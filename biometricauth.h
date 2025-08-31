#ifndef BIOMETRICAUTH_H
#define BIOMETRICAUTH_H

#include <QObject>
#include <QString>

class BiometricAuthPrivate; // Forward declaration of the private class

class BiometricAuth : public QObject
{
    Q_OBJECT
public:
    explicit BiometricAuth(QObject *parent = nullptr);
    ~BiometricAuth();

    Q_INVOKABLE void authenticate(const QString &reason);

signals:
    void authenticationSucceeded();
    void authenticationFailed(const QString &error);
    void authenticationCanceled();

private:
    BiometricAuthPrivate *d_ptr; // The private implementation
};

#endif // BIOMETRICAUTH_H