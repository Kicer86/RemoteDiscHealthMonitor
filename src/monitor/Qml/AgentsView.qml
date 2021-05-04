import QtQuick.Layouts 1.15
import QtQuick 2.15
import QtQuick.Controls 2.15
import RDHM 1.0

Item {
    property alias label: label.title
    property alias model: agentsList.model

    clip: true

    SystemPalette { id: currentPalette; colorGroup: SystemPalette.Active }

    GroupBox {
        id: label
        anchors.fill: parent
        spacing: 2

        ListView {
            id: agentsList
            anchors.fill: parent

            spacing: 2
            clip: true

            delegate: Item {
                id: delegateItem

                width: ListView.view.width
                height: 30

                MouseArea {
                    id: delegateMouseArea
                    anchors.fill: parent

                    hoverEnabled: true

                    onDoubleClicked:{
                        switchAgentsListViewAndAgentDetailsView()
                    }

                    onClicked: {
                        agentsList.currentIndex = index

                        agentDetailsDisksComboBox.model = agentDiskInfoNames

                        agentDetailsDisksComboBox.smartVector = agentDiskInfoData
                    }

                    AgentDelegate {
                        id: agentDelegate

                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    DeletionItem {
                        id: deletionItem

                        visible: agentDetectionType == AgentInformation.Hardcoded
                        height: parent.height - 6
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.verticalCenter: parent.verticalCenter

                        onDeleteItem: {
                            agentsList.model.removeAgentAt(index);
                        }
                    }
                }
            }

            highlight: Rectangle {
                opacity: 0.5
                color: currentPalette.highlight
                radius: 5
                z: -1
            }
        }

        ColumnLayout {
            height: parent.height

            Button {
                id: agentDetailsBackBtn
                visible: false
                text: "<<"
                onClicked: {
                    switchAgentsListViewAndAgentDetailsView()
                }
            }


            ComboBox {
                id: agentDetailsDisksComboBox
                width: label.width
                visible: false
                anchors.top: agentDetailsBackBtn.bottom
                property var smartVector: []
                property var stringList: []
                onVisibleChanged: {
                    //console.log( agentDetailsDisksComboBox.currentIndex + " " + smartVector[currentIndex] + " AAA");
                    agentDetailsSmartLV.model.clear()
                    stringList = (smartVector[currentIndex]).split(';');
                    for(var i=0; i< stringList.length; i++)
                    {
                        console.log(stringList[i]);
                        agentDetailsSmartLV.model.append({attrWithResult: stringList[i]})
                    }

                }
                onCurrentIndexChanged: {
                    agentDetailsSmartLV.model.clear()
                    stringList = (smartVector[currentIndex]).split(';');
                    for(var i=0; i< stringList.length; i++)
                    {
                        console.log(stringList[i]);
                        agentDetailsSmartLV.model.append({attrWithResult: stringList[i]})
                    }
                }
            }


            Component {
                id: delegate1
                Item {
                    width: 200; height: 28
                    Label {
                        text: attrWithResult
                    }
                }
            }

            ListView {
                id: agentDetailsSmartLV
                model: smartModel
                visible: false
                delegate: delegate1
                height: parent.height
                anchors.top: agentDetailsDisksComboBox.bottom
                ScrollBar.vertical: ScrollBar {
                    active: true
                }
            }

            ListModel {
                id: smartModel
                ListElement { 
                    attrWithResult: "testText"
                }
            }
        }
    }

    function switchAgentsListViewAndAgentDetailsView() {
        agentsList.visible = !agentsList.visible
        agentDetailsBackBtn.visible = !agentDetailsBackBtn.visible
        agentDetailsDisksComboBox.visible = !agentDetailsDisksComboBox.visible
        agentDetailsSmartLV.visible = !agentDetailsSmartLV.visible
    }

}



