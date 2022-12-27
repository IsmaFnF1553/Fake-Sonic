poison = false;
drain = 0.003;
wireValue = 0;

function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'HEX Note' then 	--Check if the note on the chart is a Bullet Note
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'HEXNOTE_assets');	--Change texture
			setPropertyFromGroup('unspawnNotes', i, 'lowPriority', true) 			--lowPriority means it has less of a chance to be hit.
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true); 			--Makes it so original character doesn't sing these notes
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then 			--Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); 		--Miss has no penalties
			end
		end
	end
	makeLuaSprite('barbedWire1', 'barbedWire/1', 0, 0)
	makeLuaSprite('barbedWire2', 'barbedWire/2', 0, 0)
	makeLuaSprite('barbedWire3', 'barbedWire/3', 0, 0)
	makeLuaSprite('barbedWire4', 'barbedWire/4', 0, 0)
	makeLuaSprite('barbedWire5', 'barbedWire/5', 0, 0)
	makeLuaSprite('barbedWire6', 'barbedWire/6', 0, 0)
	addLuaSprite('barbedWire1', false)
	addLuaSprite('barbedWire2', false)
	addLuaSprite('barbedWire3', false)
	addLuaSprite('barbedWire4', false)
	addLuaSprite('barbedWire5', false)
	addLuaSprite('barbedWire6', false)
	setObjectCamera('barbedWire1', 'other')
	setObjectCamera('barbedWire2', 'other')
	setObjectCamera('barbedWire3', 'other')
	setObjectCamera('barbedWire4', 'other')
	setObjectCamera('barbedWire5', 'other')
	setObjectCamera('barbedWire6', 'other')
	setProperty('barbedWire1.alpha', 0)
	setProperty('barbedWire2.alpha', 0)
	setProperty('barbedWire3.alpha', 0)
	setProperty('barbedWire4.alpha', 0)
	setProperty('barbedWire5.alpha', 0)
	setProperty('barbedWire6.alpha', 0)
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'HEX Note' then
		drain=drain+0.0023
		runTimer('poisonStop',10);
		poison=true;
		playSound('hitWire', 1);
		cameraShake('camGame', 0.01, 0.2);
		wireValue = wireValue + 1;

		if wireValue > 0 and wireValue < 2 then --1
			doTweenAlpha('barbedWireTween1', 'barbedWire1', 1, 1, 'linear');
			runTimer('Wire1', 10);
		end
		if wireValue > 1 and wireValue < 3 then --2
			doTweenAlpha('barbedWireTween2', 'barbedWire2', 1, 1, 'linear');
			runTimer('Wire2', 10);
		end
		if wireValue > 2 and wireValue < 4 then --3
			doTweenAlpha('barbedWireTween3', 'barbedWire3', 1, 1, 'linear');
			runTimer('Wire3', 10);
		end
		if wireValue > 3 and wireValue < 5 then --4
			doTweenAlpha('barbedWireTween4', 'barbedWire4', 1, 1, 'linear');
			runTimer('Wire4', 10);
		end
		if wireValue > 4 and wireValue < 6 then --5
			doTweenAlpha('barbedWireTween5', 'barbedWire5', 1, 1, 'linear');
			runTimer('Wire5', 10);
		end
		if wireValue > 5 and wireValue < 7 then --6
			doTweenAlpha('barbedWireTween6', 'barbedWire6', 1, 1, 'linear');
			runTimer('Wire6', 10);
		end
	end
end
	
function onStepHit()
    if poison==true then
		health = getProperty('health')
		setProperty('health', getProperty('health')-drain);
    end
end

function onUpdate()
	if curStep > 1103 then
		cancelTimer('Wire1')
		cancelTimer('Wire2')
		cancelTimer('Wire3')
		cancelTimer('Wire4')
		cancelTimer('Wire5')
		cancelTimer('Wire6')
		cancelTimer('poisonStop')
		doTweenAlpha('barbedWireTween1', 'barbedWire1', 0, 0.5, 'linear')
		doTweenAlpha('barbedWireTween2', 'barbedWire2', 0, 0.5, 'linear')
		doTweenAlpha('barbedWireTween3', 'barbedWire3', 0, 0.5, 'linear')
		doTweenAlpha('barbedWireTween4', 'barbedWire4', 0, 0.5, 'linear')
		doTweenAlpha('barbedWireTween5', 'barbedWire5', 0, 0.5, 'linear')
		doTweenAlpha('barbedWireTween6', 'barbedWire6', 0, 0.5, 'linear')
		poison=false
	end
	if wireValue > 6 then --resetting value back to 0
		wireValue = 0;
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'poisonStop' then
        poison=false;
    end
	if tag == 'Wire1' then
		doTweenAlpha('barbedWireTween1', 'barbedWire1', 0, 0.5, 'linear');
	end
	if tag == 'Wire2' then
		doTweenAlpha('barbedWireTween2', 'barbedWire2', 0, 0.5, 'linear');
	end
	if tag == 'Wire3' then
		doTweenAlpha('barbedWireTween3', 'barbedWire3', 0, 0.5, 'linear');
	end
	if tag == 'Wire4' then
		doTweenAlpha('barbedWireTween4', 'barbedWire4', 0, 0.5, 'linear');
	end
	if tag == 'Wire5' then
		doTweenAlpha('barbedWireTween5', 'barbedWire5', 0, 0.5, 'linear');
	end
	if tag == 'Wire6' then
		doTweenAlpha('barbedWireTween6', 'barbedWire6', 0, 0.5, 'linear');
	end
end