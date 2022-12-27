local num = 1;
local Rnum = 1;

function onCreatePost()
	precacheSound('1')
	precacheSound('2')
	precacheSound('3')
	precacheImage('BlackVines')
	
	makeAnimatedLuaSprite('BlackVines', 'BlackVines', 0, 0)
	addAnimationByPrefix('BlackVines', '1', 'BlackVines Vine1Cover', 24, false)
	addAnimationByPrefix('BlackVines', '2', 'BlackVines Vine2Cover', 24, false)
	addAnimationByPrefix('BlackVines', '3', 'BlackVines Vine3Cover', 24, false)
	addAnimationByPrefix('BlackVines', '4', 'BlackVines Reverse1Cover', 24, false)
	addAnimationByPrefix('BlackVines', '5', 'BlackVines Reverse2Cover', 24, false)
	addAnimationByPrefix('BlackVines', '6', 'BlackVines Reverse3Cover', 24, false)
	setObjectCamera('BlackVines', 'other');
	setProperty('BlackVines.antialiasing', false);
	scaleObject('BlackVines', 1, 1);
	addLuaSprite('BlackVines', false);
	setProperty('BlackVines.visible', false);
end

function onUpdate()
	num = math.random(1,3)
end

function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'EXE_note' then --Check if the note on the chart is a Bullet Note
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'EXE_arrows'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'lowPriority', true) --lowPriority means it has less of a chance to be hit.
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'special_sploosh');
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has penalties
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	health = getProperty('health')
	if noteType == 'EXE_note' then
		playSound(num, 1);
		Rnum = num+3;
		objectPlayAnimation('bf', 'singLEFT-miss', true);
		objectPlayAnimation('BlackVines', num, true);
		setProperty('BlackVines.visible', true);
		if getProperty('health') > 1 then
			setProperty('health', health-0.1);
		end
		cameraShake('camGame', 0.01, 0.2);
		runTimer('hehehealthgobrrr', 0.5);
		runTimer('byebyeVine', 2.5);
    end
end

function onTimerCompleted(tag)
	if tag == 'byebyeVine' then
		objectPlayAnimation('BlackVines', Rnum, true);
	end
end