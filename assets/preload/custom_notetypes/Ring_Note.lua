function onCreatePost()
	precacheSound('Ring')
	precacheImage('Ring_Note')
end

function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Ring_Note' then --Check if the note on the chart is a Bullet Note
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'Ring_Note'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'lowPriority', true) --lowPriority means it has less of a chance to be hit.
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'ring_sploosh');
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has penalties
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	health = getProperty('health')
	if noteType == 'Ring_Note' then
		setProperty('health', 2);
		playSound('Ring', 2);
    end
end