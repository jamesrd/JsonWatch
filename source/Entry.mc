import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

public class DisplayEntry {
    public var name as String;
    public var label as WatchUi.Text;
    public var value as WatchUi.Text;

    public function initialize(n as String, x as Number, y as Number) {
        name = n;
        var text = Lang.format("\"$1$\": ", [name]);
        label = new WatchUi.Text({
            :text=> text,
            :color=> Graphics.COLOR_BLUE,
            :font=> Graphics.FONT_XTINY,
            :locX=> x,
            :locY=> y
        });
        value = new WatchUi.Text({
            :text=> "",
            :color=> Graphics.COLOR_ORANGE,
            :font=> Graphics.FONT_XTINY,
            :locX=> x,
            :locY=> y
        });
    }

    public function draw(dc) {
        label.draw(dc);
        value.draw(dc);
    }

    public function setValue(v as String, isLast as Boolean) {
        var t = v;
        if (!isLast) {
            t = t +",";
        }
        value.setText(t);
    }

    public function positionValue() {
        value.locX = label.locX + label.width;
    }

    public function setX(x as Number) {
        label.locX = x;
        positionValue();
    }
}