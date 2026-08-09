import QtQuick
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "omarchy.menu"

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "\uF011"
    fontFamily: Style.font.family
    foreground: "#f38ba8"
    horizontalMargin: 7.5
    onPressed: function(button) {
      if (!root.bar) return
      root.bar.run("wlogout || ~/.config/hypr/scripts/powermenu.sh")
    }
  }
}
