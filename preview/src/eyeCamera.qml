import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtMultimedia 5.0
import CVEyeCamera 1.0
import CVCamera 1.0
Rectangle {
  visible: true

  //Width and height stuff is for desktop only, they seem to be ignored on Android (this is expected good behavior)
  width: camera0.size.width
  height: camera0.size.height
  CVEyeCamera {
    id: camera0
    device: 0
    size: "640x480"
    onCvImageChanged: {
          canv0.requestPaint()
    }
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
    console.log(camera0.pupilCenter.x)
      var ctx = getContext("2d")
      ctx.clearRect(0, 0 ,camera0.size.width, camera0.size.height)
      ctx.strokeStyle = 'red'
      ctx.lineWidth = 2
      ctx.strokeRect(video0.firstPoint.x, video0.firstPoint.y , video0.secondPoint.x - video0.firstPoint.x, video0.secondPoint.y - video0.firstPoint.y)

        // Fill inside with blue, leaving 10 pixel border
        // Draw a circle
        ctx.beginPath();
        ctx.fillStyle = "orange"
        ctx.strokeStyle = "red"
        ctx.moveTo(camera0.pupilCenter.x, camera0.pupilCenter.y);
        ctx.arc(camera0.pupilCenter.x, camera0.pupilCenter.y,15, 0, 2*Math.PI, true)
        ctx.fill();
        ctx.stroke();

        // Draw some text
        ctx.beginPath();
        ctx.strokeStyle = "lime green"
        ctx.font = "20px sans-serif";
        ctx.text(Number(camera0.pupilCenter.x).toLocaleString(Qt.locale("de_DE")) + Number(camera0.pupilCenter.x).toLocaleString(Qt.locale("de_DE")), camera0.pupilCenter.x, camera0.pupilCenter.y);
        ctx.stroke();

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
}
