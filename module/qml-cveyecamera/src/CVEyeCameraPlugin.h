#ifndef CVEYECAMERAPLUGIN_H
#define CVEYECAMERAPLUGIN_H

#include<QQmlExtensionPlugin>
#include<qqml.h>

#include"CVEyeCamera.h"

/**
 * @brief Object that exposes the CVEyeCamera plugin and friends as QML objects
 */

class CVEyeCameraPlugin : public QQmlExtensionPlugin
{
Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char* uri);
};

#endif // CVEYECAMERAPLUGIN_H


