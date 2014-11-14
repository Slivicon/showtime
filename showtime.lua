print("loading showtime15");

showtime = {};

function showtime:loadMap(name)

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
	setTextColor(0,0,0,1);
	renderText(0.87, 0.91, 0.018, getDate("%H:%M"));
	setTextColor(1, 1, 1, 0);
end;

addModEventListener(showtime);