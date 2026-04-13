import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    anchors.fill: parent

    // --- TAVOLOZZA COLORI DRACULA ---
    readonly property color dracBg:       "#282a36"
    readonly property color dracCurrLine: "#44475a"
    readonly property color dracFg:       "#f8f8f2"
    readonly property color dracComment:  "#6272a4"
    readonly property color dracCyan:     "#8be9fd"
    readonly property color dracPink:     "#ff79c6"
    readonly property color dracPurple:   "#bd93f9"
    readonly property color dracRed:      "#ff5555"

    readonly property color colPanelBg:   "#E6282a36"
    readonly property color colInputBg:   "#F244475a"

    // SFONDO
    Image {
        id: backgroundImage
        anchors.fill: parent
        source: "wallpaper.png"
        fillMode: Image.PreserveAspectCrop
        
        Rectangle {
            anchors.fill: parent
            color: dracBg
            visible: backgroundImage.status !== Image.Ready
        }
    }

    // GESTIONE FOCUS E ERRORI
    Connections {
        target: sddm
        function onLoginFailed() {
            passwordField.text = ""
            errorMessage.visible = true
            passwordField.focus = true
        }
    }

    // OROLOGIO
    Column {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 60
        
        Text {
            id: clockLabel
            text: Qt.formatDateTime(new Date(), "hh:mm")
            font.pixelSize: 130
            font.bold: true
            font.family: "JetBrains Mono"
            color: dracPurple
            horizontalAlignment: Text.AlignRight
        }
        Text {
            text: Qt.formatDateTime(new Date(), "dddd, MMMM d")
            font.pixelSize: 32
            font.family: "JetBrains Mono"
            color: dracCyan
            font.bold: true
            anchors.right: parent.right
        }
    }

    // BOX DI LOGIN CENTRALE
    Rectangle {
        id: loginBox
        anchors.centerIn: parent
        width: 600
        height: 780  // Aumentato per far spazio alla sessione
        color: colPanelBg
        radius: 20
        border.width: 3 
        border.color: dracPurple

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 60
            spacing: 20

            Text {
                text: "SYSTEM ACCESS"
                font.pixelSize: 36
                font.bold: true
                font.family: "JetBrains Mono"
                font.letterSpacing: 2
                color: dracPurple
                Layout.alignment: Qt.AlignHCenter
                Layout.bottomMargin: 20
            }

            // --- USERNAME ---
            Text { 
                text: "USERNAME"
                color: dracCyan
                font.bold: true
                font.pixelSize: 20
                font.family: "JetBrains Mono"
            }
            TextField {
                id: usernameField
                Layout.fillWidth: true
                Layout.preferredHeight: 65
                text: userModel.lastUser
                color: dracFg
                font.pixelSize: 24
                font.family: "JetBrains Mono"
                leftPadding: 15
                background: Rectangle {
                    color: colInputBg
                    border.color: usernameField.activeFocus ? dracCyan : dracComment
                    border.width: usernameField.activeFocus ? 3 : 1
                    radius: 12
                }
            }

            // --- PASSWORD ---
            Text { 
                text: "PASSWORD"
                color: dracPink
                font.bold: true
                font.pixelSize: 20
                font.family: "JetBrains Mono"
            }
            TextField {
                id: passwordField
                Layout.fillWidth: true
                Layout.preferredHeight: 65
                echoMode: TextInput.Password
                color: dracFg
                font.pixelSize: 24
                font.family: "JetBrains Mono"
                leftPadding: 15
                focus: true
                background: Rectangle {
                    color: colInputBg
                    border.color: passwordField.activeFocus ? dracPink : dracComment
                    border.width: passwordField.activeFocus ? 3 : 1
                    radius: 12
                }
                onAccepted: loginButton.clicked()
            }

            // --- SESSION SELECTOR (NUOVO) ---
            Text { 
                text: "ENVIRONMENT"
                color: dracComment
                font.bold: true
                font.pixelSize: 20
                font.family: "JetBrains Mono"
            }
            ComboBox {
                id: sessionSelector
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                model: sessionModel
                currentIndex: sessionModel.lastIndex
                textRole: "name"
                
                // Testo visualizzato nel box
                contentItem: Text {
                    text: sessionSelector.displayText
                    color: dracPurple // Viola per la sessione attiva
                    font.pixelSize: 20
                    font.bold: true
                    font.family: "JetBrains Mono"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 15
                }
                
                // Sfondo del box
                background: Rectangle {
                    color: colInputBg
                    border.color: dracComment
                    border.width: 1
                    radius: 12
                }

                // Menu a tendina
                delegate: ItemDelegate {
                    width: sessionSelector.width
                    contentItem: Text {
                        text: model.name
                        color: hovered ? dracBg : dracFg // Testo scuro su hover
                        font.bold: true
                        font.pixelSize: 18
                        font.family: "JetBrains Mono"
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 15
                    }
                    background: Rectangle {
                        color: hovered ? dracCyan : dracBg // Sfondo Ciano su hover
                    }
                }
            }

            Text {
                id: errorMessage
                text: "✕ ACCESS DENIED"
                color: dracRed
                font.pixelSize: 18
                font.bold: true
                visible: false
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 5
            }

            // --- TASTO LOGIN ---
            Button {
                id: loginButton
                Layout.fillWidth: true
                Layout.preferredHeight: 70
                Layout.topMargin: 15
                
                contentItem: Text {
                    text: "INITIALIZE LOGIN"
                    color: dracBg
                    font.bold: true
                    font.pixelSize: 22
                    font.family: "JetBrains Mono"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    color: loginButton.hovered ? dracPink : dracPurple
                    radius: 12
                }
                onClicked: {
                    errorMessage.visible = false
                    // Passiamo l'indice della sessione selezionata
                    sddm.login(usernameField.text, passwordField.text, sessionSelector.currentIndex)
                }
            }
        }
    }

    // --- PULSANTI POWER ---
    RowLayout {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 50
        spacing: 30

        Button {
            id: rebootBtn
            implicitWidth: 180
            implicitHeight: 60
            onClicked: sddm.reboot()
            
            contentItem: Text { 
                text: "REBOOT"
                color: rebootBtn.hovered ? dracBg : dracCyan
                font.bold: true
                font.pixelSize: 20
                font.family: "JetBrains Mono"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            background: Rectangle {
                color: rebootBtn.hovered ? dracCyan : "transparent"
                border.color: dracCyan
                border.width: 3
                radius: 10
            }
        }

        Button {
            id: shutdownBtn
            implicitWidth: 180
            implicitHeight: 60
            onClicked: sddm.powerOff()
            
            contentItem: Text { 
                text: "SHUTDOWN"
                color: shutdownBtn.hovered ? dracBg : dracRed
                font.bold: true
                font.pixelSize: 20
                font.family: "JetBrains Mono"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            background: Rectangle {
                color: shutdownBtn.hovered ? dracRed : "transparent"
                border.color: dracRed
                border.width: 3
                radius: 10
            }
        }
    }

    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: clockLabel.text = Qt.formatDateTime(new Date(), "hh:mm")
    }
}
