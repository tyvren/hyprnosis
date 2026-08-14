import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import qs.Themes
import qs.Services

Item {
    id: styledSliderRoot
    width: 80
    height: 6

    property real inputValue: 0.0
    property real fromValue: 0.0
    property real toValue: 0.0
    property real stepSizeValue: 0.0

    signal moved(real value)

    Slider {
        id: styledSlider
        value: styledSliderRoot.inputValue 
        from: styledSliderRoot.fromValue
        to: styledSliderRoot.toValue
        snapMode: Slider.SnapOnRelease
        stepSize: styledSliderRoot.stepSizeValue
                
        background: Rectangle {
            x: styledSlider.leftPadding
            y: styledSlider.topPadding + styledSlider.availableHeight / 2 - height / 2
            implicitWidth: styledSliderRoot.width
            implicitHeight: styledSliderRoot.height
            width: styledSlider.availableWidth
            height: implicitHeight
            radius: Config.data.rounding 
            color: Theme.colMuted
            opacity: 0.5

            Rectangle {
                width: styledSlider.visualPosition * parent.width
                height: parent.height
                color: Theme.colAccent
                radius: Config.data.rounding
            }
        }

        handle: Rectangle {
            x: styledSlider.leftPadding + styledSlider.visualPosition * (styledSlider.availableWidth - width)
            y: styledSlider.topPadding + styledSlider.availableHeight / 2 - height / 2
            implicitWidth: 12
            implicitHeight: 12
            radius: Config.data.rounding
            color: styledSlider.pressed ? Theme.colAccent : Theme.colBg
            border.color: Theme.colAccent
            border.width: Config.data.borderSize
        }

        onMoved: {
            styledSliderRoot.inputValue = styledSlider.value
            styledSliderRoot.moved(styledSlider.value)
        }
    }
}
