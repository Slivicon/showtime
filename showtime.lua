--
-- showtime15 - Displays the real world time within Farming Simulator 15
--
-- @author  Slivicon https://github.com/Slivicon/showtime
-- @date    2014-11-11
-- Thank you to:
--  Decker_MMIV for code to read and write config XML and utility http://fs-uk.com/mods/list/user/90139
--  Marhu for code to dynamically determine clock position http://marhu.net
--  ita for the idea to have white as an option for display outside the default area
--

showtime = {};

local modItem = ModsUtil.findModItemByModName(g_currentModName);
showtime.version = (modItem and modItem.version) and modItem.version or "?.?.?";

function showtime:loadMap(name)
  if g_client == nil then
    return;
  end;
  showtime.setDefaults();
  local fXmlName = g_modsDirectory .. "/" .. "showtime.xml";
  local tag = "showtime";
  if not fileExists(fXmlName) then
    showtime.writeConfig(fXmlName, tag);
  else
    showtime.readConfig(fXmlName, tag);
  end;
end;

function showtime:deleteMap()

end;

function showtime:mouseEvent(posX, posY, isDown, isUp, button)

end;

function showtime:keyEvent(unicode, sym, modifier, isDown)

end;

function showtime:update(dt)

end;

function showtime:draw()
  if not g_currentMission.renderTime then
    return;
  end;
  if showtime.white then
    setTextColor(1, 1, 1, 1);
  else
    setTextColor(0, 0, 0, 1);
  end;
  setTextAlignment(RenderText.ALIGN_RIGHT);
  local posX = showtime.posX;
  local posY = showtime.posY;
  if showtime.posDynamic then
    posX = showtime.getDefaultPosX();
	posY = showtime.getDefaultPosY(showtime.fontSize);
  end;
  renderText(posX, posY, showtime.fontSize, tostring(getDate(showtime.timeFormat)));
  setTextColor(1, 1, 1, 1);
  setTextAlignment(RenderText.ALIGN_LEFT);
end;

function showtime.getDefaultFontSize()
  return 0.018;
end;

function showtime.getDefaultPosDynamic()
  return true;
end;

function showtime.getDefaultPosX()
  return g_currentMission.weatherTimeBackgroundOverlay.x + g_currentMission.weatherTimeBackgroundWidth - g_currentMission.timeOffsetRight;
end;

function showtime.getDefaultPosY(fontSize)
  if fontSize == nil then
    fontSize = showtime.getDefaultFontSize();
  end;
  return g_currentMission.weatherTimeBackgroundOverlay.y + (fontSize/4);
end;

function showtime.getDefaultShowSeconds()
  return false;
end;

function showtime.getDefaultTimeFormat24()
  return true;
end;

function showtime.getDefaultWhite()
  return false;
end;

function showtime.getFontSize(fontSize)
  if showtime.isValidFloat(fontSize) then
    return fontSize;
  end;
  return showtime.getDefaultFontSize();
end;

function showtime.getPosDynamic(posDynamic)
  if posDynamic then
    return true;
  end;
  return false;
end;

function showtime.getPosX(posX)
  if showtime.isValidFloat(posX) then
    return posX;
  end;
  return showtime.getDefaultPosX();
end;

function showtime.getPosY(posY)
  if showtime.isValidFloat(posY) then
    return posY;
  end;
  return showtime.getDefaultPosY();
end;

function showtime.getTimeFormat(timeFormat24, showSeconds)
  local timeFormat = "";
  if timeFormat24 then
    timeFormat = "%H";
  else
    timeFormat = "%I";
  end;
  timeFormat = timeFormat .. ":%M";
  if showSeconds then
    timeFormat = timeFormat .. ":%S";
  end;
  return timeFormat;
end

function showtime.getTimeFormat24(timeFormat24)
  if timeFormat24 then
    return true;
  end;
  return false;
end;

function showtime.getWhite(white)
  if white then
    return true;
  end;
  return false;
end;

function showtime.isValidFloat(num)
  e = tonumber(num);
  if e == nil then
    return false;
  end;
  if e > 0 and e < 1 then
    return true;
  end;
  return false;
end;

function showtime.readConfig(fXmlName, tag)
  local fXml = loadXMLFile("fXml", fXmlName);
  local white = Utils.getNoNil(getXMLBool(fXml, tag .. "#white"), showtime.getDefaultWhite());
  local fontSize = Utils.getNoNil(getXMLFloat(fXml, tag .. "#fontSize"), showtime.getDefaultFontSize());
  local posDynamic = Utils.getNoNil(getXMLBool(fXml, tag .. "#posDynamic"), showtime.getDefaultPosDynamic());
  local posX = Utils.getNoNil(getXMLFloat(fXml, tag .. "#posX"), showtime.getDefaultPosX);
  local posY = Utils.getNoNil(getXMLFloat(fXml, tag .. "#posY"), showtime.getDefaultPosY(fontSize));
  local timeFormat24 = Utils.getNoNil(getXMLBool(fXml, tag .. "#timeFormat24"), showtime.getDefaultTimeFormat24());
  local showSeconds = Utils.getNoNil(getXMLBool(fXml, tag .. "#showSeconds"), showtime.getDefaultShowSeconds());
  showtime.setParams(white, fontSize, posDynamic, posX, posY, timeFormat24, showSeconds);
  delete(fXml);
end;

function showtime.setDefaults()
  local fontSize = showtime.getDefaultFontSize();
  showtime.setParams(showtime.getDefaultWhite(), fontSize, showtime.getDefaultPosDynamic(), showtime.getDefaultPosX(), showtime.getDefaultPosY(fontSize), showtime.getDefaultTimeFormat24(), showtime.getDefaultShowSeconds());
end;

function showtime.setParams(white, fontSize, posDynamic, posX, posY, timeFormat24, showSeconds)
  showtime.white = showtime.getWhite(white);
  showtime.fontSize = showtime.getFontSize(fontSize);
  showtime.posDynamic = showtime.getPosDynamic(posDynamic);
  showtime.posX = showtime.getPosX(posX);
  showtime.posY = showtime.getPosY(posY);
  showtime.timeFormat24 = showtime.getTimeFormat24(timeFormat24);
  showtime.timeFormat = showtime.getTimeFormat(timeFormat24, showSeconds);
end;

function showtime.writeConfig(fXmlName, tag)
  local fXml = createXMLFile(tag, fXmlName, tag);
  setXMLBool(fXml, tag .. "#white", showtime.white);
  setXMLFloat(fXml, tag .. "#fontSize", showtime.fontSize);
  setXMLBool(fXml, tag .. "#posDynamic", showtime.posDynamic);
  local posX = showtime.posX;
  local posY = showtime.posY;
  if showtime.posDynamic then
    posX = 0;
	posY = 0;
  end;
  setXMLFloat(fXml, tag .. "#posX", posX);
  setXMLFloat(fXml, tag .. "#posY", posY);
  setXMLBool(fXml, tag .. "#timeFormat24", showtime.timeFormat24);
  setXMLBool(fXml, tag .. "#showSeconds", showtime.showSeconds);
  saveXMLFile(fXml);
  delete(fXml);
end;

addModEventListener(showtime);

print(string.format("Script loaded: showtime.lua (v%s)", showtime.version));
