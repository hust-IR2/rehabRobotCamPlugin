import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtMultimedia 5.0
import CVCamera 1.0

Window {
    visible: true

    //Width and height stuff is for desktop only, they seem to be ignored on Android (this is expected good behavior)
    width: camera0.size.width + camera1.size.width
    height: camera0.size.height + camera1.size.height
    maximumWidth: camera0.size.width  + camera1.size.width
    maximumHeight: 2 * camera0.size.height

    CVCamera {
        id: camera0
        device: 0
        size: "640x480"
    }

    CVCamera {
        id: camera1
        device: 1
        size: "640x480"
    }
    CVCamera {
        id: camera2
        device: 2
        size: "640x480"
    }

    CVCamera {
        id: camera3
        device: 4
        size: "640x480"
    }
    VideoOutput {
        id: output0
        source: camera0
    }

    VideoOutput {
        id: output1
        anchors.left: output0.right
        source: camera1
    }
    VideoOutput {
        id: output2
        anchors.top: output0.bottom
        source: camera2
    }

    VideoOutput {
        id: output3
        anchors.left: output2.right
        anchors.top: output1.bottom
        source: camera3
    }
}
