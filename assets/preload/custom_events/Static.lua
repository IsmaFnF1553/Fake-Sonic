function onCreatePost()
	precacheSound('staticBUZZ')
	
	makeAnimatedLuaSprite('static', 'daSTAT', 0, 0)
	addAnimationByPrefix('static', 'idle', 'staticFLASH', 24, true);
	addLuaSprite('static', false)
	setProperty('static.visible', false)
	setObjectCamera('static', 'other')
	scaleObject('static', 3.5, 3)
end

function onEvent(n,v1,v2)
	if n == 'Static' then
		setProperty('static.visible', true)
		playSound(v2, 1)
		runTimer('staticTime', v1);
	end
end

function onTimerCompleted(tag)
	if tag == 'staticTime' then
		setProperty('static.visible', false);
	end
end