boomspeed = 4
bam = 1
function onEvent(n,v1,v2)
	if n == "Set Cam Boom" then
	boomspeed = tonumber(v1)
	bam = tonumber(v2)
	triggerEvent("Add Camera Zoom",0.001*bam,0.001*bam)
	end
end