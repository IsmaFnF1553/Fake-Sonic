function onEvent(n,v1,v2)
	if n == "Set HUD Boom" then
	intensity = tonumber(v1)
	speed = tonumber(v2)
	doTweenZoom('zoomie', 'camHUD', intensity*1.1, speed)
	end
end