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
    var startLabel, endLabel;
    //var timeLabel, dateLabel, batteryLabel, heartLabel, stepsLabel, messageLabel;
    //var timeValue, dateValue, batteryValue, heartValue, stepsValue, messageValue;
    var timeEntry;
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
        var lines = 8;
        var indentX = 20;
        var cy = (height / 2) - (lines * lineHeight / 2);
        startLabel = getLabel("{", marginX, cy, Graphics.COLOR_LT_GRAY);
        cy+=lineHeight;
        timeEntry = new DisplayEntry("time", marginX + indentX, cy);
        // timeLabel = getLabel("\"time\": ", marginX + indentX, cy, Graphics.COLOR_BLUE);
        // timeValue = getLabel("", marginX, cy, Graphics.COLOR_ORANGE);
        //cy+=lineHeight;
        // dateLabel = getLabel("\"date\": ", marginX + indentX, cy, Graphics.COLOR_BLUE);
        // dateValue = getLabel("", marginX, cy, Graphics.COLOR_ORANGE);
        // cy+=lineHeight;
        // batteryLabel = getLabel("\"battery\": ", marginX + indentX, cy, Graphics.COLOR_BLUE);
        // batteryValue = getLabel("", marginX, cy, Graphics.COLOR_ORANGE);
        // cy+=lineHeight;
        // stepsLabel = getLabel("\"steps\": ", marginX + indentX, cy, Graphics.COLOR_BLUE);
        // stepsValue = getLabel("", marginX, cy, Graphics.COLOR_ORANGE);
        // cy+=lineHeight;
        // heartLabel = getLabel("\"pulse\": ", marginX + indentX, cy, Graphics.COLOR_BLUE);
        // heartValue = getLabel("", marginX, cy, Graphics.COLOR_ORANGE);
        // cy+=lineHeight;
        // messageLabel = getLabel("\"messages\": ", marginX + indentX, cy, Graphics.COLOR_BLUE);
        // messageValue = getLabel("", marginX, cy, Graphics.COLOR_ORANGE);
        cy+=lineHeight;
        endLabel = getLabel("}", marginX, cy, Graphics.COLOR_LT_GRAY);

        is24Hour = System.getDeviceSettings().is24Hour;
        backgroundColor = getApp().getProperty("BackgroundColor") as Number;

        doLayout = true;
    }

    function getLabel(text as String, x as Number, y as Number, color as Graphics.ColorType) as WatchUi.Text {
        return new WatchUi.Text({
            :text=> text,
            :color=> color,
            :font=> Graphics.FONT_XTINY,
            :locX=> x,
            :locY=> y
        });
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
        var timeString = Lang.format("\"$1$:$2$:$3$\",", [hours.format("%02d"), clockTime.min.format("%02d"), clockTime.sec.format("%02d")]);
        timeEntry.setValue(timeString, true);
        // timeValue.setText(timeString);
        // var dateString = Lang.format("\"$1$-$2$-$3$\",", [clockTime.year.format("%04d"), clockTime.month.format("%02d"), clockTime.day.format("%02d")]);
        // dateValue.setText(dateString);
        // var systemStats = System.getSystemStats();
        // var batteryString = Lang.format("\"$1$%\",", [systemStats.battery.format("%02.1f")]);
        // batteryValue.setText(batteryString);
        // var stepsString = Lang.format("$1$,", [steps]);
        // stepsValue.setText(stepsString);
        // var pulseString = Lang.format("$1$,", [pulse]);
        // heartValue.setText(pulseString);
        // var messageString = Lang.format("$1$", [messages]);
        // messageValue.setText(messageString);


        dc.setColor(Graphics.COLOR_TRANSPARENT, backgroundColor);
        dc.clear();
        startLabel.draw(dc);
        timeEntry.draw(dc);
        // timeLabel.draw(dc);
        // dateLabel.draw(dc);
        // batteryLabel.draw(dc);
        // stepsLabel.draw(dc);
        // heartLabel.draw(dc);
        // messageLabel.draw(dc);
        endLabel.draw(dc);
        if(doLayout) {
            timeEntry.positionValue();
            timeEntry.draw(dc);
            // var x = timeLabel.locX + timeLabel.width;
            // timeValue.locX = x;
            // x = dateLabel.locX + dateLabel.width;
            // dateValue.locX = x;
            // x = batteryLabel.locX + batteryLabel.width;
            // batteryValue.locX = x;
            // x = stepsLabel.locX + stepsLabel.width;
            // stepsValue.locX = x;
            // x = messageLabel.locX + messageLabel.width;
            // messageValue.locX = x;
            // x = heartLabel.locX + heartLabel.width;
            // heartValue.locX = x;
        }
        // timeValue.draw(dc);
        // dateValue.draw(dc);
        // batteryValue.draw(dc);
        // stepsValue.draw(dc);
        // messageValue.draw(dc);
        // heartValue.draw(dc);
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
