import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.Commons
import qs.Services.UI
import qs.Widgets

// Igual que el widget SessionMenu de Noctalia, pero con una imagen en vez del icono "power"
NIconButton {
  id: root

  property var pluginApi: null
  property ShellScreen screen
  property string widgetId: ""
  property string section: ""
  property int sectionWidgetIndex: -1
  property int sectionWidgetsCount: 0

  readonly property string imagen: {
    const ruta = pluginApi?.pluginSettings?.imagen || pluginApi?.manifest?.metadata?.defaultSettings?.imagen || "";
    return ruta.replace(/^~/, Quickshell.env("HOME"));
  }

  baseSize: Style.getCapsuleHeightForScreen(screen?.name)
  applyUiScale: false
  customRadius: Style.radiusL
  icon: ""
  tooltipText: PanelService.getPanel("sessionMenuPanel", screen)?.isPanelOpen ? "" : I18n.tr("tooltips.session-menu")
  tooltipDirection: BarService.getTooltipDirection(screen?.name)
  colorBg: Style.capsuleColor
  colorBgHover: Color.mHover
  border.color: Style.capsuleBorderColor
  border.width: Style.capsuleBorderWidth

  onClicked: PanelService.getPanel("sessionMenuPanel", screen)?.toggle()

  IconImage {
    anchors.centerIn: parent
    width: root.buttonSize * 0.8
    height: width
    source: root.imagen !== "" ? "file://" + root.imagen : ""
    visible: source !== ""
    smooth: true
    asynchronous: true
  }
}
