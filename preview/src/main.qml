import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtMultimedia 5.0
import CVEyeCamera 1.0
import CVCamera 1.0
Window {
    visible: true
    width:800;height:800
    Loader {
        id: eye_l
    }
    Button {
        id: btn1
        text: "Open"
        x:0
        y:480
        width: 200
        onClicked: {

            eye_l.source = "eyeCamera.qml"
        }
    }
    Button {
      id: btn2
      text: "Open"
      x:200
      y:480
      width: 200
      onClicked: {
          console.log("dfjaksdfjlkas")
      }
    }

}
