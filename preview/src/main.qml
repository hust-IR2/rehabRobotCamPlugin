import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtMultimedia 5.0
import CVEyeCamera 1.0
import CVCamera 1.0
Window {
  visible: true

  //Width and height stuff is for desktop only, they seem to be ignored on Android (this is expected good behavior)
  width: camera0.size.width * 2
  height: camera0.size.height * 2
  maximumHeight: camera0.size.height * 2
  maximumWidth: camera0.size.width * 2
  CVEyeCamera {
    id: camera0
    device: 2
    size: "640x480"
  }
  VideoOutput {
    id: video0
    source: camera0
    property var firstPoint: Qt.point(0, 0)
    property var secondPoint: Qt.point(0, 0)
    property var clickNums: 0
    MouseArea {
      anchors.fill: parent
      acceptedButtons: Qt.LeftButton
      propagateComposedEvents: true
      onPressed: {
        // set leftTop point once click leftButton
        if (video0.firstPoint.x >= 0 && video0.firstPoint.x < camera0.size.width  && video0.firstPoint.y < camera0.size.height &&
            video0.secondPoint.x >= 0 && video0.secondPoint.x < camera0.size.width  && video0.secondPoint.y < camera0.size.height) {
          video0.firstPoint = Qt.point(mouse.x, mouse.y)
          if (1 != video0.clickNums) {
            video0.clickNums = 1
          }
        }
      }
      onPositionChanged: {
        if (video0.clickNums == 1) {
          if (mouse.x >= 0 && mouse.x < camera0.size.width  && mouse.y >= 0 && mouse.y < camera0.size.height){
            video0.secondPoint = Qt.point(mouse.x, mouse.y)
            canv0.requestPaint()
          }
        }
      }
      onReleased: {
        video0.clickNums = 2
        video0.secondPoint = Qt.point(mouse.x, mouse.y)
        // set leftTop and rightDown when the rect is in the image
        if (mouse.x >= 0 && mouse.x < camera0.size.width  && mouse.y >= 0 && mouse.y < camera0.size.height){
          camera0.leftTop = Qt.point(video0.firstPoint.x < video0.secondPoint.x ? video0.firstPoint.x : video0.secondPoint.x,
                                                                               video0.firstPoint.y < video0.secondPoint.y ? video0.firstPoint.y : video0.secondPoint.y)
          camera0.rightDown = Qt.point(video0.firstPoint.x > video0.secondPoint.x ? video0.firstPoint.x : video0.secondPoint.x,
                                                                                 video0.firstPoint.y > video0.secondPoint.y ? video0.firstPoint.y : video0.secondPoint.y)
          canv0.requestPaint()
        }
      }
    }
  }
  Canvas {
    id: canv0
    anchors.fill: video0
    onPaint: {
      var ctx = getContext("2d")
      ctx.clearRect(0, 0 ,camera0.size.width, camera0.size.height)
      ctx.strokeStyle = 'red'
      ctx.lineWidth = 2
      ctx.strokeRect(video0.firstPoint.x, video0.firstPoint.y , video0.secondPoint.x - video0.firstPoint.x, video0.secondPoint.y - video0.firstPoint.y)
    }
  }
//  ComboBox {
//    anchors.top: video0.top
//    id: deviceBox0
//    width: 200
//    model: camera0.deviceList
//    onCurrentIndexChanged: {
//        if (currentIndex != camera1.device)
//            camera0.device = currentIndex;
//    }
//  }

  CVEyeCamera {
    id: camera1
    device: 1
    size: "640x480"
  }
  VideoOutput {
    id: video1
    anchors.top: video0.top
    anchors.left: video0.right
    source: camera1
    property var firstPoint: Qt.point(0, 0)
    property var secondPoint: Qt.point(0, 0)
    property var clickNums: 0
    MouseArea {
      anchors.fill: parent
      acceptedButtons: Qt.LeftButton
      propagateComposedEvents: true
      onPressed: {
        // set leftTop point once click leftButton
        if (video1.firstPoint.x >= 0 && video1.firstPoint.x < camera1.size.width  && video1.firstPoint.y < camera1.size.height &&
            video1.secondPoint.x >= 0 && video1.secondPoint.x < camera1.size.width  && video1.secondPoint.y < camera1.size.height) {
          video1.firstPoint = Qt.point(mouse.x, mouse.y)
          if (1 != video1.clickNums) {
            video1.clickNums = 1

          }

        }
      }
      onPositionChanged: {
        if (video1.clickNums == 1) {
          if (mouse.x >= 0 && mouse.x < camera1.size.width  && mouse.y >= 0 && mouse.y < camera1.size.height){
            video1.secondPoint = Qt.point(mouse.x, mouse.y)
            canv1.requestPaint()
          }
        }
      }
      onReleased: {
        video1.clickNums = 2
        video1.secondPoint = Qt.point(mouse.x, mouse.y)
        // set leftTop and rightDown when the rect is in the image
        if (mouse.x >= 0 && mouse.x < camera1.size.width  && mouse.y >= 0 && mouse.y < camera1.size.height){
          camera1.leftTop = Qt.point(video1.firstPoint.x < video1.secondPoint.x ? video1.firstPoint.x : video1.secondPoint.x,
                                                                               video1.firstPoint.y < video1.secondPoint.y ? video1.firstPoint.y : video1.secondPoint.y)
          camera1.rightDown = Qt.point(video1.firstPoint.x > video1.secondPoint.x ? video1.firstPoint.x : video1.secondPoint.x,
                                                                                 video1.firstPoint.y > video1.secondPoint.y ? video1.firstPoint.y : video1.secondPoint.y)
          canv1.requestPaint()
        }
      }
    }
  }
  Canvas {
    id: canv1
    anchors.fill: video1
    onPaint: {
      var ctx = getContext("2d")
      ctx.clearRect(0, 0 ,camera1.size.width, camera1.size.height)
      ctx.strokeStyle = 'blue'
      ctx.lineWidth = 2
      ctx.strokeRect(video1.firstPoint.x, video1.firstPoint.y , video1.secondPoint.x - video1.firstPoint.x, video1.secondPoint.y - video1.firstPoint.y)
    }
  }
//  ComboBox {
//    anchors.top: video1.top
//    anchors.left: video1.left
//    id: deviceBox1
//    width: 200
//    model: camera1.deviceList
//    onCurrentIndexChanged: {
//        if (currentIndex != camera0.device)
//            camera1.device = currentIndex;
//    }
//  }

}
