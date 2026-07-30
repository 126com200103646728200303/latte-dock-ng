/*
    SPDX-FileCopyrightText: 2020 Michail Vourlakos <mvourlakos@gmail.com>
    SPDX-License-Identifier: GPL-2.0-or-later
*/

import QtQuick 2.0

import org.kde.plasma.plasmoid 2.0

SequentialAnimation{
    readonly property string bouncePropertyName: taskItem.isVertical ? "iconAnimatedOffsetX" : "iconAnimatedOffsetY"

    Component.onDestruction: {
        //! make sure to return on initial position even when the animation is destroyed in the middle
        if (taskItem.isVertical) {
            taskItem.iconAnimatedOffsetX = 0;
        } else {
            taskItem.iconAnimatedOffsetY = 0;
        }
    }

    //! I think the Ghost animation is useless, why don't we make other animations longer?
    //! Here disabled ParallelAnimation to prevent the zoom recovering...
    // make the second rise animation alone
    PropertyAnimation {
        target: taskItem
        property: bouncePropertyName
        to: taskItem.abilities.metrics.iconSize
        //! make the duration a little longer to make it seems more fluent and better
        duration: 1.5 * launcherAnimation.speed
        easing.type: Easing.OutQuad
    }

    // this is the fall animation
    PropertyAnimation {
        target: taskItem
        property: bouncePropertyName
        to: 0
        // make the duration a little longer to make it seems more fluent and better
        duration: 5 * launcherAnimation.speed
        easing.type: Easing.OutBounce
    }

    onStopped: {
        //! make sure to return on initial position even when the animation is destroyed in the middle
        if (taskItem.isVertical) {
            taskItem.iconAnimatedOffsetX = 0;
        } else {
            taskItem.iconAnimatedOffsetY = 0;
        }
    }
}
