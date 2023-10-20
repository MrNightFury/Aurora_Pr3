/*******************************************************************************
**
** Copyright (C) 2022 ru.mrnightfury
**
** This file is part of the   project.
**
** Redistribution and use in source and binary forms,
** with or without modification, are permitted provided
** that the following conditions are met:
**
** * Redistributions of source code must retain the above copyright notice,
**   this list of conditions and the following disclaimer.
** * Redistributions in binary form must reproduce the above copyright notice,
**   this list of conditions and the following disclaimer
**   in the documentation and/or other materials provided with the distribution.
** * Neither the name of the copyright holder nor the names of its contributors
**   may be used to endorse or promote products derived from this software
**   without specific prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
** AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
** THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
** FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
** IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
** FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
** OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
** PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS;
** OR BUSINESS INTERRUPTION)
** HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
** WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE)
** ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
** EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
*******************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0

ApplicationWindow {
    objectName: "applicationWindow"
    initialPage: Qt.resolvedUrl("pages/MainPage.qml")
    cover: Qt.resolvedUrl("cover/DefaultCoverPage.qml")
    allowedOrientations: defaultAllowedOrientations

    ListView {
        id: listView;
        y: 100;
        width: parent.width;
        height: parent.height / 2;
        model: ListModel {
            id: dataModel;
            ListElement {
                color: "red"
                text: "Red"
                textColor: "yellow"
            }
            ListElement {
                color: "green"
                text: "Green"
                textColor: "white"
            }
            ListElement {
                color: "blue"
                text: "Blue"
                textColor: "pink"
            }
        }
        delegate: Rectangle {
            width: parent.width;
            height: 50;
            color: model.color;
            Text {
                anchors.centerIn: parent.Center;
                text: model.text;
                color: model.textColor;
            }
            MouseArea {
                height: parent.height;
                width: parent.width;
                onClicked: {
                    dataModel.remove(index);
                }
            }
        }
    }

    Button {
        id: addButton;
        anchors.top: listView.bottom;
        property int index: 3;
        onClicked: {
            index++;
            dataModel.append({
                color: ["red", "green", "blue", "yellow", "orange"][Math.floor(Math.random() * 5)],
                text: "Rectangle №" + index,
                textColor: "black"
            })
        }
    }

    XmlListModel {
        id: xml;
        source: "http://www.cbr.ru/scripts/XML_daily.asp";
        query: "/ValCurs/Valute"
        XmlRole { name: "name"; query: "Name/string()" }
        XmlRole { name: "value"; query: "Value/string()" }
        XmlRole { name: "code"; query: "CharCode/string()" }
    }

    ListView {
        id: curView;
        anchors.top: addButton.bottom;
        width: parent.width;
        height: parent.height / 2 - addButton.height - 150;
        model: xml;
        delegate: Rectangle {
            width: parent.width;
            height: 50;
            color: index % 2 === 0 ? "#f2f2f2" : "white";
            Text {
                anchors.centerIn: parent;
                text: model.name + " (" + model.code + "): " + model.value + " RUB";
            }
        }
    }
}
