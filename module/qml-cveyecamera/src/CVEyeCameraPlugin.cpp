#include "CVEyeCameraPlugin.h"

void CVEyeCameraPlugin::registerTypes(const char* uri)
{
    qmlRegisterType<CVEyeCamera>(uri, 1, 0, "CVEyeCamera");
}

