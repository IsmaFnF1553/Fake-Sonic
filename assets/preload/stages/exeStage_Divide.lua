missPenalty = false;
currentpausepos = 0;
drain = 0;
RunOnce = true;

function onCreate()
	precacheImage('exedeath')
	
	setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')+1)
	setObjectOrder('girlfriendGroup', getObjectOrder('dadGroup')-1)
	
	setProperty('skipCountdown', true);
	------------------
	--	  EXE BG    --
	------------------
	makeLuaSprite('bg', 'exe/divide/sky', -600, -600);
	setScrollFactor('bg', 0.5, 0.5);
	
	makeLuaSprite('sun', 'exe/divide/ground', -600, -600);
	setScrollFactor('sun', 0.65, 0.65);
	
	makeLuaSprite('mountains', 'exe/divide/backtrees', -600, -600);
	setScrollFactor('mountains', 0.7, 0.7);
	
	makeLuaSprite('middle_ground', 'exe/divide/trees', -600, -600);
	setScrollFactor('middle_ground', 0.75, 0.75);
	
	makeAnimatedLuaSprite('exe_stage', 'exe/divide/ExeAnimatedBG_Assets', -1050, -1000);
	addAnimationByPrefix('exe_stage', 'idle', 'ExeBGAnim', 24, true);
	objectPlayAnimation('exe_stage', 'idle', true);
	setScrollFactor('exe_stage', 1, 1);
	scaleObject('exe_stage', 1.25, 1.25);
	
	makeLuaSprite('tail', 'exe/divide/TailsCorpse', 500, 150);
	setScrollFactor('tail', 1, 1);
	
	addLuaSprite('bg', false);
	addLuaSprite('mountains', false);
	addLuaSprite('middle_ground', false);
	addLuaSprite('sun', false);
	addLuaSprite('scorched_trees', false);
	addLuaSprite('exe_stage', false);
	addLuaSprite('tail', false);
end

local allowCountdown = false
local soundhitplayed = false
local waitThing = false
local confirmed = 0
local bfdodged = false;
local value = 150; --using onUpdate to remove 1 every frame
local bfdedlol = false;
local phase3 = false;

function onStartCountdown()
    if not allowCountdown then
        return Function_Stop
    end
    if allowCountdown then
        return Function_Continue
    end
    return Function_Continue;
end

function onGameOver()
	return Function_Stop
end

function onPause()
	if getProperty('health') < 0.01 then
		setPropertyFromClass('flixel.FlxG', 'autoPause', false);
		return Function_Stop
	end
end

function onUpdate(elapsed)
	currentpausepos = getPropertyFromClass('Conductor', 'songPosition')
	if getProperty('health') < 0.01 then
		if bfdedlol == false then
			makeLuaSprite('asdfghjkl', 'black', 0, 0);
			setObjectCamera('asdfghjkl', 'other')
			scaleObject('asdfghjkl', 512, 512)
			addLuaSprite('asdfghjkl', true)
			makeAnimatedLuaSprite('exedeathlol', 'exedeath', 0, 0);
			addAnimationByPrefix('exedeathlol', 'idle', 'DieLmao', 0, false);
			addAnimationByPrefix('exedeathlol', 'death', 'DieLmao', 24, false);
			setObjectCamera('exedeathlol', 'other')
			scaleObject('exedeathlol', 1, 1)
			addLuaSprite('exedeathlol', true)
			objectPlayAnimation('exedeathlol', 'idle', true);
			setProperty('boyfriend.stunned', true)
			playSound('Exe_buildUP', 1);
			runTimer('Byebyegame', 5);
			bfdedlol = true;
		end
	end
	if bfdedlol == true then
		setPropertyFromClass('Conductor', 'songPosition',currentpausepos)
		setPropertyFromClass('flixel.FlxG', 'sound.music.time',currentpausepos)
		setProperty('vocals.time',currentpausepos)
		setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0)
		setProperty('vocals.volume', 0)
	end
	
	scorin = getProperty('songScore');
	missies = getProperty('songMisses');
	
	if value > 2 then
		setTextString('scoreTxt', 'Score: ' ..scorin.. ' | Misses: ' ..missies.. ' | Accuracy: '..(string.sub(getProperty('ratingPercent')* 100,0,5)).. '% ['..getProperty('ratingFC')..']')
		setTextString('botplayTxt', 'look at this dude using botplay lmao skull emoji');
		
		setProperty('health', 2);
		setProperty('cameraSpeed', 1.25);
	end
	if value > 1 then
		value = value-1; --using onUpdate to remove 1 every frame
	end
	if value == 1 and confirmed == 0 then
		setProperty("timeBar.color",getColorFromHex("FF0000"))
        allowCountdown = true
        startCountdown();
        confirmed = 1
    end
	if getProperty('health') < 0.4 then
		makeLuaSprite('exevore', 'vore_exe', getProperty('iconP2.x'), getProperty('iconP2.y')-10);
		setProperty('exevore.scale.x', getProperty('iconP2.scale.x'));
		setProperty('exevore.scale.y', getProperty('iconP2.scale.y'));
		setProperty('exevore.antialiasing',true);
		setProperty('exevore.angle', getProperty('iconP2.angle'));
		setObjectCamera('exevore', 'camHUD');
		setObjectOrder('exevore', getObjectOrder('scoreTxt') - 1);
		addLuaSprite('exevore', true);
		setProperty('iconP2.alpha', tonumber(0));
	end
	
	for i=0,3 do
		noteTweenAlpha(i+16, i, math.floor(curStep/9999), 0.3)
		noteTweenAlpha(i+16, i, math.floor(curStep/9999), 4-7)
	end
	
	setTextString('scoreTxt', 'Score: ' ..scorin.. ' | Misses: ' ..missies.. ' | Accuracy: '..(string.sub(getProperty('ratingPercent')* 100,0,5)).. '% ['..getProperty('ratingFC')..']')
	
	if health > 1.9 then
		setProperty('vignette.alpha', 0.05);
		setProperty('tentacles.alpha', 0.05);
		setProperty('exeFace.alpha', 0);
	elseif health > 1.8 then
		setProperty('vignette.alpha', 0.1);
		setProperty('tentacles.alpha', 0.1);
		setProperty('exeFace.alpha', 0);
	elseif health > 1.7 then
		setProperty('vignette.alpha', 0.15);
		setProperty('tentacles.alpha', 0.15);
		setProperty('exeFace.alpha', 0);
	elseif health > 1.6 then
		setProperty('vignette.alpha', 0.2);
		setProperty('tentacles.alpha', 0.2);
		setProperty('exeFace.alpha', 0);
	elseif health > 1.5 then
		setProperty('vignette.alpha', 0.25);
		setProperty('tentacles.alpha', 0.25);
		setProperty('exeFace.alpha', 0);
	elseif health > 1.4 then
		setProperty('vignette.alpha', 0.3);
		setProperty('tentacles.alpha', 0.3);
		setProperty('exeFace.alpha', 0);
	elseif health > 1.3 then
		setProperty('vignette.alpha', 0.35);
		setProperty('tentacles.alpha', 0.35);
		setProperty('exeFace.alpha', 0);
	elseif health > 1.2 then
		setProperty('vignette.alpha', 0.4);
		setProperty('tentacles.alpha', 0.4);
		setProperty('exeFace.alpha', 0);
	elseif health > 1.1 then
		setProperty('vignette.alpha', 0.45);
		setProperty('tentacles.alpha', 0.45);
		setProperty('exeFace.alpha', 0);
	elseif health > 1 then
		setProperty('vignette.alpha', 0.5);
		setProperty('tentacles.alpha', 0.5);
		setProperty('exeFace.alpha', 0);
	elseif health > 0.9 then
		setProperty('vignette.alpha', 0.55);
		setProperty('tentacles.alpha', 0.55);
		setProperty('exeFace.alpha', 0.1);
	elseif health > 0.8 then
		setProperty('vignette.alpha', 0.6);
		setProperty('tentacles.alpha', 0.6);
		setProperty('exeFace.alpha', 0.2);
	elseif health > 0.7 then
		setProperty('vignette.alpha', 0.65);
		setProperty('tentacles.alpha', 0.65);
		setProperty('exeFace.alpha', 0.3);
	elseif health > 0.6 then
		setProperty('vignette.alpha', 0.7);
		setProperty('tentacles.alpha', 0.7);
		setProperty('exeFace.alpha', 0.4);
	elseif health > 0.5 then
		setProperty('vignette.alpha', 0.75);
		setProperty('tentacles.alpha', 0.75);
		setProperty('exeFace.alpha', 0.5);
	elseif health > 0.4 then
		setProperty('vignette.alpha', 0.8);
		setProperty('tentacles.alpha', 0.8);
		setProperty('exeFace.alpha', 0.6);
	elseif health > 0.3 then
		setProperty('vignette.alpha', 0.85);
		setProperty('tentacles.alpha', 0.85);
		setProperty('exeFace.alpha', 0.7);
	elseif health > 0.2 then
		setProperty('vignette.alpha', 0.9);
		setProperty('tentacles.alpha', 0.9);
		setProperty('exeFace.alpha', 0.8);
	elseif health > 0.15 then
		setProperty('exeFace.alpha', 0.9);
	elseif health > 0.1 then
		setProperty('vignette.alpha', 1);
		setProperty('tentacles.alpha', 1);
	end
end

local xx = 450;
local yy = -150;
local xx2 = 880;
local yy2 = 335;
local ofs = 30;
local followchars = true;
local del = 0;
local del2 = 0;

function onUpdatePost()
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
			setProperty('defaultCamZoom', 0.6);
			if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
				triggerEvent('Camera Follow Pos',xx-ofs,yy)
			end
			if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
				triggerEvent('Camera Follow Pos',xx+ofs,yy)
			end
			if getProperty('dad.animation.curAnim.name') == 'singUP' then
				triggerEvent('Camera Follow Pos',xx,yy-ofs)
			end
			if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
				triggerEvent('Camera Follow Pos',xx,yy+ofs)
			end
			if getProperty('dad.animation.curAnim.name') == 'idle' then
				triggerEvent('Camera Follow Pos',xx,yy)
			end
        else
			setProperty('defaultCamZoom', 0.85);
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
end

function opponentNoteHit()
	health = getProperty('health')
	setProperty('health', health- 0.00075);
end

function goodNoteHit(noteType)
	health = getProperty('health')
	setProperty('health', health- 0.023);
	if drain > 0.0001 then
		drain=drain-0.000001
	end
	if noteType == 'Ring_Note' then
		drain=drain-0.00023
	end
end

function noteMiss()
	triggerEvent('Play Animation', 'sad', 'gf')
	
	drain=drain+0.00023
	runTimer('Stop',50);
	missPenalty=true;
end

function onStepHit()
	if missPenalty == true then
		health = getProperty('health')
		setProperty('health', getProperty('health')-drain);
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'Byebyegame' then
		objectPlayAnimation('exedeathlol', 'death', true);
		playSound('Exe_die', 2);
		runTimer('DieLmao', 0.35);
	end
	if tag =='DieLmao' then		--no legit way to crash psych engine sadly.
		exitSong();
	end
	if tag == 'Stop' then
        missPenalty=false;
    end
end

function onDestroy()
	setPropertyFromClass('flixel.FlxG', 'autoPause', true);
end