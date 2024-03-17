import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

public class DisplayEntries {
    var centerY;
    var lineHeight;
    var indentX;
    var marginX;
    var entries as Array<DisplayEntry> = [];
    var entryNames as Array<String> = [];
    var values as Dictionary<String, String> = {};
    var startBracket, endBracket;
    var bracketColor = Graphics.COLOR_LT_GRAY;
    var labelColor = Graphics.COLOR_BLUE;
    var valueColor = Graphics.COLOR_ORANGE;
    
    public function initialize(cy as Number, lh as Number, indent as Number, margin as Number) {
        centerY = cy;
        lineHeight = lh;
        indentX = indent;
        marginX = margin;
    }

    public function addEntry(e as String) {
        entryNames.add(e);
    }

    public function initializeEntries() {
        var ey = centerY - ((entryNames.size() + 2) * lineHeight / 2);
        startBracket = new WatchUi.Text({
            :text=> "{",
            :color=> bracketColor,
            :font=> Graphics.FONT_XTINY,
            :locX=> marginX,
            :locY=> ey
        });
        ey += lineHeight;
        var xOffset = indentX + marginX;
        for(var i = 0; i < entryNames.size(); i++) {
            var en = entryNames[i];
            var de = new DisplayEntry(en, xOffset, ey, labelColor, valueColor, Graphics.FONT_XTINY);
            entries.add(de);
            ey += lineHeight;
        }
        endBracket = new WatchUi.Text({
            :text=> "}",
            :color=> bracketColor,
            :font=> Graphics.FONT_XTINY,
            :locX=> marginX,
            :locY=> ey
        });
    }

    public function setValue(e as String, v as String) {
        values[e] = v;
    }

    public function draw(dc) {
        startBracket.draw(dc);
        var ec = entries.size();
        for(var i = 0; i < ec; i++) {
            var de = entries[i];
            de.setValue(values[de.name], i == ec - 1);
            de.draw(dc);
        }
        endBracket.draw(dc);
    }

    public function doLayout(dc) {
        for(var i = 0; i < entryNames.size(); i++) {
            var de = entries[i];
            de.positionValue();
        }
    }
}