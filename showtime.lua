print("loading showtime15");

showtime = {};

function showtime:loadMap(name)
	fontSize = 0.018;
	timeFormat = "%H:%M";
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
	--set text params
	setTextColor(0, 0, 0, 1);
	setTextAlignment(RenderText.ALIGN_RIGHT);
	--improved position based on Marhu's better resolution-independent code
	local xPos = g_currentMission.weatherTimeBackgroundOverlay.x + g_currentMission.weatherTimeBackgroundWidth - g_currentMission.timeOffsetRight;
	local yPos = g_currentMission.weatherTimeBackgroundOverlay.y + (fontSize/4);
	local sTime = tostring(getDate(timeFormat));
	renderText(xPos, yPos, fontSize, sTime);
	--renderText(0.87, 0.91, 0.018, getDate("%H:%M")); --static position values which have a different result depending on screen resolution
	--reset text params
	setTextColor(1, 1, 1, 1);
	setTextAlignment(RenderText.ALIGN_LEFT);
end;

addModEventListener(showtime);