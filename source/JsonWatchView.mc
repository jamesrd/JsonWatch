import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time.Gregorian;

class JsonWatchView extends WatchUi.WatchFace {
    var steps = 1000;
    var messages = 0;
    var pulse = 68;
    var height = 416;
    var width = 416;
    var lineHeight = 34;
    var marginX = 50;
    var displayEntries;
    var doLayout = true;
    var is24Hour = false;
    var backgroundColor = Graphics.COLOR_BLACK;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
        height = dc.getHeight();
        width = dc.getWidth();

        lineHeight = Graphics.getFontHeight(Graphics.FONT_XTINY);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        var indentX = 20;
        var centerY = height / 2;
        displayEntries = new DisplayEntries(centerY, lineHeight, indentX, marginX);
        displayEntries.addEntry("time");
        displayEntries.addEntry("date");
        displayEntries.addEntry("battery");
        // below here - may be conditional based on watch abilities
        displayEntries.addEntry("steps");
        displayEntries.addEntry("pulse");
        displayEntries.addEntry("messages");

        displayEntries.initializeEntries();

        is24Hour = System.getDeviceSettings().is24Hour;
        backgroundColor = getApp().getProperty("BackgroundColor") as Number;

        doLayout = true;
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get and show the current time
        var clockTime = Gregorian.info(Time.now(), Time.FORMAT_SHORT); // System.getClockTime();
        var hours = clockTime.hour;
        if (!is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        }
        var timeString = Lang.format("\"$1$:$2$:$3$\"", [hours.format("%02d"), clockTime.min.format("%02d"), clockTime.sec.format("%02d")]);
        displayEntries.setValue("time", timeString);
        var dateString = Lang.format("\"$1$-$2$-$3$\"", [clockTime.year.format("%04d"), clockTime.month.format("%02d"), clockTime.day.format("%02d")]);
        displayEntries.setValue("date", dateString);
        var systemStats = System.getSystemStats();
        var batteryString = Lang.format("\"$1$%\"", [systemStats.battery.format("%02.1f")]);
        displayEntries.setValue("battery", batteryString);

        // below may not be available on all devices:

        var stepsString = Lang.format("$1$", [steps]);
        displayEntries.setValue("steps", stepsString);

        var pulseString = Lang.format("$1$", [pulse]);
        displayEntries.setValue("pulse", pulseString);

        var messageString = Lang.format("$1$", [messages]);
        displayEntries.setValue("messages", messageString);

        dc.setColor(Graphics.COLOR_TRANSPARENT, backgroundColor);
        dc.clear();
        displayEntries.draw(dc);
        if(doLayout) {
            displayEntries.doLayout(dc);
        }
        doLayout = false;
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
