TEMPLATE = app

QT += qml quick
CONFIG += c++11

#Additional files and libs for motion Contrl
INCLUDEPATH += $${PWD}/../Src/APS Library/Include
INCLUDEPATH += $${PWD}/../Src/ATI/ATI Header Files
INCLUDEPATH += $${PWD}/../Src/ATI/ATI Source Files
INCLUDEPATH += $${PWD}/../Src/Eigen3
INCLUDEPATH += $${PWD}/../Src/NI/include

LIBS += -L$${PWD}/../Src/NI/lib  -NIDAQmx
LIBS += -L$${PWD}/../Src/APS Library -APS168

SOURCES += main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
