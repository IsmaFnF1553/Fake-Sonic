local speedy = 1;

function onCreatePost()
	precacheSound('rawr')
	precacheImage('EXE_Jumpscare_Rawr')
	
	makeLuaSprite('EXE_Jumpscare', 'EXE_Jumpscare_Rawr', 0, 0)
	setObjectCamera('EXE_Jumpscare', 'other');
	setProperty('EXE_Jumpscare.antialiasing', false);
	scaleObject('EXE_Jumpscare', 1, 1);
	addLuaSprite('EXE_Jumpscare', false);
	setProperty('EXE_Jumpscare.alpha', tonumber(0));
end

function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Jumpscare_Note' then --Check if the note on the chart is a Bullet Note
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'EXE_arrows_2'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'lowPriority', true) --lowPriority means it has less of a chance to be hit.
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'spwecial_weddy_spwoosh');
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has penalties
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'Jumpscare_Note' then
		playSound('rawr', 1);
		playSound('rawr', 1);
		cancelTween('tweenygobrrrrr');
		speedy = speedy + 0.1;
		setProperty('EXE_Jumpscare.alpha', tonumber(1));
		triggerEvent('Change Scroll Speed', speedy, 1);
		cameraShake('camGame', 0.01, 0.2);
		runTimer('byebye', 0.25);
    end
end

function onTimerCompleted(tag)
	if tag == 'byebye' then
		doTweenAlpha('tweenygobrrrrr', 'EXE_Jumpscare', 0, 0.25, 'linear');
	end
end