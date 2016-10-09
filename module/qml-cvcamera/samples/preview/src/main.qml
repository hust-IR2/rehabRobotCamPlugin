import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtMultimedia 5.0
import CVEyeCamera 1.0
import CVCamera 1.0
Window {
    visible: true

    //Width and height stuff is for desktop only, they seem to be ignored on Android (this is expected good behavior)
    width: camera.size.width
    height: camera.size.height
    maximumHeight: camera.size.height
    maximumWidth: camera.size.width
    CVEyeCamera {
      id: camera
      device: deviceBox.currentIndex
      size: "640x480"
    }


    VideoOutput {
      anchors.top: imageSizeField.top
      id: video
      source: camera
      property var firstPoint: Qt.point(0, 0)
      property var secondPoint: Qt.point(0, 0)
      property var clickNums: 0
      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        propagateComposedEvents: true
        onPressed: {
          // set leftTop point once click leftButton
          if (video.firstPoint.x >= 0 && video.firstPoint.x < camera.size.width  && video.firstPoint.y < camera.size.height &&
              video.secondPoint.x >= 0 && video.secondPoint.x < camera.size.width  && video.secondPoint.y < camera.size.height) {
            video.firstPoint = Qt.point(mouse.x, mouse.y)
            if (1 != video.clickNums) {
              video.clickNums = 1

            }

          }
        }
        onPositionChanged: {
          if (video.clickNums == 1) {
            if (mouse.x >= 0 && mouse.x < camera.size.width  && mouse.y >= 0 && mouse.y < camera.size.height){
              video.secondPoint = Qt.point(mouse.x, mouse.y)
              canv.requestPaint()
            }
          }
        }

        onReleased: {
          video.clickNums = 2
          video.secondPoint = Qt.point(mouse.x, mouse.y)
          // set leftTop and rightDown when the rect is in the image
          if (mouse.x >= 0 && mouse.x < camera.size.width  && mouse.y >= 0 && mouse.y < camera.size.height){
              camera.leftTop = Qt.point(video.firstPoint.x < video.secondPoint.x ? video.firstPoint.x : video.secondPoint.x,
                                                                                   video.firstPoint.y < video.secondPoint.y ? video.firstPoint.y : video.secondPoint.y)
              camera.rightDown = Qt.point(video.firstPoint.x > video.secondPoint.x ? video.firstPoint.x : video.secondPoint.x,
                                                                                     video.firstPoint.y > video.secondPoint.y ? video.firstPoint.y : video.secondPoint.y)
              canv.requestPaint()
            }
          }
        }
      }

      Canvas {
        id: canv
        anchors.fill: parent
        onPaint: {
          var ctx = getContext("2d")
          ctx.clearRect(0, 0 ,camera.size.width, camera.size.height)
          ctx.strokeStyle = 'blue'
          ctx.lineWidth = 2
          //ctx.strokeRect(video.firstPoint.x, video.firstPoint.y , video.secondPoint.x - video.firstPoint.x, video.secondPoint.y - video.firstPoint.y)
          ctx.strokeRect(video.firstPoint.x, video.firstPoint.y , video.secondPoint.x - video.firstPoint.x, video.secondPoint.y - video.firstPoint.y)
        }
      }
      TextField {
        id: imageSizeField
        text: "640x480"
        placeholderText: "Enter image size"
      }
      Button {
        id: imageSizeSetButton
        text: imageSizeField.placeholderText
        anchors.left: imageSizeField.right
        onClicked: camera.size = imageSizeField.text
      }
      ComboBox {
        id: deviceBox
        width: 200
        anchors.left: imageSizeSetButton.right
        model: camera.deviceList
      }
    }
