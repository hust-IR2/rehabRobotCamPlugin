TEMPLATE = lib
TARGET = cveyecameraplugin

CONFIG += qt plugin c++11 nostrip
CONFIG -= android_install

QT += qml quick multimedia

QMAKE_CXXFLAGS -= -O2
QMAKE_CXXFLAGS_RELEASE -= -O2

QMAKE_CXXFLAGS += -O3
QMAKE_CXXFLAGS_RELEASE += -O3

TARGET = $$qtLibraryTarget($$TARGET)
uri = CVEyeCamera

HEADERS += \
    src/CVCamera.h \
    src/CameraThread.h \
    src/BetterVideoCapture.h \
    src/CVEyeCameraPlugin.h \
    src/CVEyeCamera.h \
    src/pupilDetect.h

SOURCES += \
    src/CVCamera.cpp \
    src/CameraThread.cpp \
    src/BetterVideoCapture.cpp \
    src/CVEyeCameraPlugin.cpp \
    src/CVEyeCamera.cpp \
    src/pupilDetect.cpp
win32 {
QMAKESPEC = win32-msvc
    INCLUDEPATH += $$(OPENCV_HOME)\include $$(OPENCV_HOME)\include\opencv
    LIBS += -L$$(OPENCV_HOME)\x64\vc12\lib

    win32:CONFIG(release, debug|release): LIBS += -lopencv_world310
    else:win32:CONFIG(debug, debug|release): LIBS += -lopencv_world310d

    CONFIG(release, debug|release) {
        DESTDIR = release
        OBJECTS_DIR = release/obj
        MOC_DIR = release/moc
        RCC_DIR = release/rcc
        UI_DIR = release/ui
    }
    else:CONFIG(debug, debug|release){
        DESTDIR = debug
        OBJECTS_DIR = debug/obj
        MOC_DIR = debug/moc
        RCC_DIR = debug/rcc
        UI_DIR = debug/ui
    }
}
unix{
    LIBS += -lopencv_core -lopencv_highgui -lopencv_imgproc -lopencv_videoio
}

android {
    HEADERS += \
        src/CVCaptureAndroid.h
    SOURCES += \
        src/CVCaptureAndroid.cpp

    #Enable automatic NEON vectorization
    QMAKE_CXXFLAGS -= -mfpu=vfp
    QMAKE_CXXFLAGS_RELEASE -= -mfpu=vfp
    QMAKE_CXXFLAGS += -mfpu=neon -ftree-vectorize -ftree-vectorizer-verbose=1 -mfloat-abi=softfp
    QMAKE_CXXFLAGS_RELEASE += -mfpu=neon -ftree-vectorize -ftree-vectorizer-verbose=1 -mfloat-abi=softfp

    INCLUDEPATH += $(ANDROID_STANDALONE_TOOLCHAIN)/sysroot/usr/share/opencv/sdk/native/jni/include
    LIBS += -L$(ANDROID_STANDALONE_TOOLCHAIN)/sysroot/usr/share/opencv/sdk/native/libs/armeabi-v7a/
    LIBS += -lopencv_androidcamera
}
OTHER_FILES += qmldir cveyecamera.qmltypes

#Install plugin library, qmldir and types
qmldir.files = qmldir
types.files =  cveyecamera.qmltypes
unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    types.path = $$installPath
    target.path = $$installPath
    INSTALLS += target qmldir types
}
win32{
    COPY_INSTALL_PATH = $$[QT_INSTALL_QML]/CVEyeCamera
    MY_PWD = $${PWD}
    DLL = $$OUT_PWD/$${DESTDIR}/$${TARGET}.dll
    DLL_FILE = $${COPY_INSTALL_PATH}/$${TARGET}.dll
    TYPES_FILE = $${COPY_INSTALL_PATH}/cveyecamera.qmltypes
    QMLDIR_FILE = $${COPY_INSTALL_PATH}/qmldir

    DLL ~= s,/,\,
    DLL_FILE ~= s,/,\,
    TYPES_FILE ~= s,/,\,
    QMLDIR_FILE ~= s,/,\,
    MY_PWD ~= s,/,\,
    QMAKE_POST_LINK +=$$quote(cmd /c copy /y $${DLL} $${DLL_FILE}$$escape_expand(\n\t))
    QMAKE_POST_LINK +=$$quote(cmd /c copy /y $${MY_PWD}\cveyecamera.qmltypes $${TYPES_FILE}$$escape_expand(\n\t))
    QMAKE_POST_LINK +=$$quote(cmd /c copy /y $${MY_PWD}\qmldir $${QMLDIR_FILE}$$escape_expand(\n\t))
}
#message($${MY_PWD}\cveyecamera.qmltypes)
#message($${MY_PWD}\qmldir)
#message($${DLL})
#message($${DLL_FILE})
#message($${TYPES_FILE})
#message($${QMLDIR_FILE})
#message($${LIBS})
#message($${INCLUDEPATH})
