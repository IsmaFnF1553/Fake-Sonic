missPenalty = false;
currentpausepos = 0;
drain = 0;
RunOnce = true;
phase2 = false;
phaseRW = false;
phase3 = false;
singingIdle = true;
singingUp = false;
singingLeft = false;
singingRight = false;
singingDown = false;
singingStart = false;

function onCreatePost()
	window_x = getPropertyFromClass('openfl.Lib','application.window.x')
	window_y = getPropertyFromClass('openfl.Lib','application.window.y')
	--debugPrint(window_x)	--prints window x coords
	--debugPrint(window_y)	--prints window y coords
	
	setPropertyFromClass('GameOverSubstate', 'characterName', 'exedeath');
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'Exe_buildUP');
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'exe_gameover');
end

function onCreate()
	precacheImage('EXE_PHASE_3_ICONS');
	precacheImage('noEXEMerging');
	precacheImage('vore');
	precacheImage('vore 2');
	precacheImage('vore 3 no cap');
	precacheSound('vineBoom');
	
	setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')+1)
	setObjectOrder('girlfriendGroup', getObjectOrder('dadGroup')-1)
	
	setProperty('skipCountdown', true);
	
	makeAnimatedLuaSprite('exeFace', 'EXE_FACE', 0, 0);
	addAnimationByPrefix('exeFace', 'idle', 'EXE FACE FLICKER', 24, true);
	addLuaSprite('exeFace', false)
	setObjectCamera('exeFace', 'other')
	setProperty('exeFace.alpha', tonumber(0));
	
	makeLuaSprite('vignette', 'black_vignette');
	addLuaSprite('vignette', false)
	setObjectCamera('vignette', 'other')
	setProperty('vignette.alpha', tonumber(0));
	
	makeLuaSprite('tentacles', 'tentacles_black');
	addLuaSprite('tentacles', false)
	setObjectCamera('tentacles', 'other')
	setProperty('tentacles.alpha', tonumber(0));
	
	makeLuaSprite('red_lol', 'red', -700, -1200);
	scaleObject('red_lol', 700, 6000);
	addLuaSprite('red_lol', false)
	
	makeLuaSprite('exemerge', 'noEXEMerging', 0, 0);
	addLuaSprite('exemerge', false)
	setObjectCamera('exemerge', 'other')
	setProperty('exemerge.alpha', tonumber(0));
	
	------------------
	--	  EXE BG    --
	------------------
	makeLuaSprite('bg', 'exe/Background', -700, -600);
	setScrollFactor('bg', 0.4, 0.4);
	
	makeLuaSprite('clouds', 'exe/Clouds', -700, -600);
	setScrollFactor('clouds', 0.5, 0.5);
	
	makeLuaSprite('sun', 'exe/The Black Sun', -700, -600);
	setScrollFactor('sun', 0.5, 0.5);
	
	makeLuaSprite('mountains', 'exe/Background_Mountains', -700, -600);
	setScrollFactor('mountains', 0.7, 0.7);
	
	makeLuaSprite('middle_ground', 'exe/Middle Ground', -700, -600);
	setScrollFactor('middle_ground', 0.8, 0.8);
	
	makeLuaSprite('exe_stage', 'exe/stage', -700, -600);
	setScrollFactor('exe_stage', 1, 1);
	
	--Corpses lol
	makeLuaSprite('amy', 'exe/Corpses/Amy', -700, -600);
	setScrollFactor('amy', 1, 1);
	
	makeLuaSprite('tail', 'exe/Corpses/Tails', -700, -600);
	setScrollFactor('tail', 1, 1);
	
	makeLuaSprite('knux', 'exe/Corpses/Knuckles', -700, -600);
	setScrollFactor('knux', 1, 1);
	
	------------------
	--	LAST STAND  --
	------------------
	makeLuaSprite('persp_bg', 'exe/persp/Sky', -700, -600);
	setScrollFactor('persp_bg', 0.4, 0.4);
	scaleObject('persp_bg', 1.1, 1.1);
	
	makeLuaSprite('persp_sun', 'exe/persp/The Black Sun', -700, -600);
	setScrollFactor('persp_sun', 0.4, 0.4);
	
	makeLuaSprite('persp_souls', 'exe/persp/Souls', -700, -600);
	setScrollFactor('persp_souls', 0.4, 0.4);
	
	makeLuaSprite('persp_drip', 'exe/persp/Dripping', -700, -600);
	setScrollFactor('persp_drip', 0.4, 0.4);
	
	makeLuaSprite('persp_pillar6', 'exe/persp/Parts/Pillars/Pillar 6', -700, -600);
	setScrollFactor('persp_pillar6', 0.5, 0.5);
	
	makeLuaSprite('persp_pillar5', 'exe/persp/Parts/Pillars/Pillar 5', -700, -600);
	setScrollFactor('persp_pillar5', 0.55, 0.55);
	
	makeLuaSprite('persp_pillar4', 'exe/persp/Parts/Pillars/Pillar 4', -700, -600);
	setScrollFactor('persp_pillar4', 0.6, 0.6);
	
	makeLuaSprite('persp_pillar3', 'exe/persp/Parts/Pillars/Pillar 3', -700, -600);
	setScrollFactor('persp_pillar3', 0.65, 0.65);
	
	makeLuaSprite('persp_pillar2', 'exe/persp/Parts/Pillars/Pillar 2', -700, -600);
	setScrollFactor('persp_pillar2', 0.7, 0.7);
	
	makeLuaSprite('persp_pillar1', 'exe/persp/Parts/Pillars/Pillar 1', -700, -600);
	setScrollFactor('persp_pillar1', 0.7, 0.7);
	
	makeLuaSprite('persp_spikes2', 'exe/persp/Parts/Spikes/Spikes 2', -700, -600);
	setScrollFactor('persp_spikes2', 0.75, 0.75);
	
	makeLuaSprite('persp_spikes1', 'exe/persp/Parts/Spikes/Spikes 1', -700, -600);
	setScrollFactor('persp_spikes1', 0.75, 0.75);
	
	makeLuaSprite('persp_exeplatform', 'exe/persp/Parts/EXE_Platform', -700, -600);
	setScrollFactor('persp_exeplatform', 1, 1);
	
	makeLuaSprite('red_light', 'exe/persp/Parts/Red Lighting', -700, -600);
	setScrollFactor('red_light', 1, 1);
	
	makeLuaSprite('persp_bfplatform', 'exe/persp/Parts/BF_Platform', -700, -600);
	setScrollFactor('persp_bfplatform', 1, 1);
	
	addLuaSprite('bg', false);
	addLuaSprite('clouds', false);
	addLuaSprite('sun', false);
	addLuaSprite('mountains', false);
	addLuaSprite('middle_ground', false);
	addLuaSprite('scorched_trees', false);
	addLuaSprite('exe_stage', false);
	
	addLuaSprite('amy', false);
	addLuaSprite('tail', false);
	addLuaSprite('knux', false);
	
	addLuaSprite('persp_bg', false);
	addLuaSprite('persp_sun', false);
	addLuaSprite('persp_souls', false);
	addLuaSprite('persp_drip', false);
	addLuaSprite('persp_pillar6', false);
	addLuaSprite('persp_pillar5', false);
	addLuaSprite('persp_pillar4', false);
	addLuaSprite('persp_pillar3', false);
	addLuaSprite('persp_pillar2', false);
	addLuaSprite('persp_pillar1', false);
	addLuaSprite('persp_spikes2', false);
	addLuaSprite('persp_spikes1', false);
	addLuaSprite('persp_exeplatform', false);
	addLuaSprite('red_light', false);
	addLuaSprite('persp_bfplatform', false);
	
	setProperty('persp_bg.visible', false);
	setProperty('persp_sun.visible', false);
	setProperty('persp_souls.visible', false);
	setProperty('persp_drip.visible', false);
	setProperty('persp_pillar6.visible', false);
	setProperty('persp_pillar5.visible', false);
	setProperty('persp_pillar4.visible', false);
	setProperty('persp_pillar3.visible', false);
	setProperty('persp_pillar2.visible', false);
	setProperty('persp_pillar1.visible', false);
	setProperty('persp_spikes2.visible', false);
	setProperty('persp_spikes1.visible', false);
	setProperty('persp_exeplatform.visible', false);
	setProperty('red_light.visible', false);
	setProperty('persp_bfplatform.visible', false);
	
	setProperty('red_lol.visible', false);
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

function onUpdatePost(elapsed)
	currentpausepos = getPropertyFromClass('Conductor', 'songPosition')
	if getProperty('health') < 0.01 then
		if bfdedlol == false then
			makeLuaSprite('asdfghjkl', 'black', 0, 0);
			setObjectCamera('asdfghjkl', 'other')
			scaleObject('asdfghjkl', 512, 512)
			addLuaSprite('asdfghjkl', true)
			makeAnimatedLuaSprite('exedeathlol', 'EXE_GAMEOVER', 25, 0);
			addAnimationByPrefix('exedeathlol', 'idle', 'EXE_GAMEOVER Stare', 0, false);
			addAnimationByPrefix('exedeathlol', 'death', 'EXE_GAMEOVER DieLmao', 24, false);
			setObjectCamera('exedeathlol', 'other')
			scaleObject('exedeathlol', 1.5, 1.5)
			addLuaSprite('exedeathlol', true)
			objectPlayAnimation('exedeathlol', 'idle', true);
			setProperty('boyfriend.stunned', true)
			playSound('Exe_buildUP', 1);
			runTimer('Byebyegame', 5);
			bfdedlol = true;
		end
	end
	if bfdedlol then
		setPropertyFromClass('Conductor', 'songPosition',currentpausepos)
		setPropertyFromClass('flixel.FlxG', 'sound.music.time',currentpausepos)
		setProperty('vocals.time',currentpausepos)
		setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0)
		setProperty('vocals.volume', 0)
	end
	
	scorin = getProperty('songScore');
	missies = getProperty('songMisses');
	
	if value > 2 then
		setProperty('iconP2.alpha', tonumber(0));
		
		setTextString('scoreTxt', 'Score: ' ..scorin.. ' | Misses: ' ..missies.. ' | Accuracy: '..(string.sub(getProperty('ratingPercent')* 100,0,5)).. '% ['..getProperty('ratingFC')..']')
		setTextString('botplayTxt', 'look at this dude using botplay lmao skull emoji');
		
		--funni icons
		makeAnimatedLuaSprite('exePhase1', 'animated_icons/1/EXE_ICON', getProperty('iconP2.x'), getProperty('iconP2.y')-10)
		addAnimationByPrefix('exePhase1', 'idle', 'EXE_ICON IDLE', 24, true);
		addAnimationByPrefix('exePhase1', 'up', 'EXE_ICON UP', 24, true);
		addAnimationByPrefix('exePhase1', 'down', 'EXE_ICON DOWN', 24, true);
		addAnimationByPrefix('exePhase1', 'left', 'EXE_ICON LEFT', 24, true);
		addAnimationByPrefix('exePhase1', 'right', 'EXE_ICON RIGHT', 24, true);
		addAnimationByPrefix('exePhase1', 'idle_win', 'EXE_ICON WINIDLE', 24, true);
		addAnimationByPrefix('exePhase1', 'up_win', 'EXE_ICON WINUP', 24, true);
		addAnimationByPrefix('exePhase1', 'down_win', 'EXE_ICON WINDOWN', 24, true);
		addAnimationByPrefix('exePhase1', 'left_win', 'EXE_ICON WINLEFT', 24, true);
		addAnimationByPrefix('exePhase1', 'right_win', 'EXE_ICON WINRIGHT', 24, true);
		setObjectCamera('exePhase1', 'camHUD')
		addLuaSprite('exePhase1', true)
		
		makeAnimatedLuaSprite('exePhase3', 'animated_icons/3/EXE_ICON', getProperty('iconP2.x'), getProperty('iconP2.y')-10)
		addAnimationByPrefix('exePhase3', 'idle', 'EXE_ICON IDLE', 24, true);
		addAnimationByPrefix('exePhase3', 'up', 'EXE_ICON UP', 24, true);
		addAnimationByPrefix('exePhase3', 'down', 'EXE_ICON DOWN', 24, true);
		addAnimationByPrefix('exePhase3', 'left', 'EXE_ICON LEFT', 24, true);
		addAnimationByPrefix('exePhase3', 'right', 'EXE_ICON RIGHT', 24, true);
		setObjectCamera('exePhase3', 'camHUD')
		addLuaSprite('exePhase3', true)
		setProperty('exePhase3.alpha', tonumber(0));
		
		setProperty('health', 2);
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
	
	for i=0,3 do
		noteTweenAlpha(i+16, i, math.floor(curStep/9999), 0.3)
		noteTweenAlpha(i+16, i, math.floor(curStep/9999), 4-7)
	end
	
	setTextString('scoreTxt', 'Score: ' ..scorin.. ' | Misses: ' ..missies.. ' | Accuracy: '..(string.sub(getProperty('ratingPercent')* 100,0,5)).. '% ['..getProperty('ratingFC')..']')
	
	if RunOnce == true then
		--Making sure all characters are loaded since Psych Engine lags when a different character is loaded beforehand.
		triggerEvent('Change Character', 'dad', 'BF_FINAL');
		triggerEvent('Change Character', 'dad', 'Ethereal_EXE');
		triggerEvent('Change Character', 'dad', 'exe_phase2');
		triggerEvent('Change Character', 'dad', 'exe_phase2_alt');
		triggerEvent('Change Character', 'dad', 'exe_phase2_rw');
		triggerEvent('Change Character', 'dad', 'exeBf_rw');
		
		triggerEvent('Change Character', 'dad', 'exe');
		
		setProperty('cameraSpeed', 1.25);
		
		RunOnce = false;
	end
	
	setProperty('exePhase3.x', getProperty('iconP2.x'));
	setProperty('exePhase3.y', getProperty('iconP2.y')-15);
	
	setProperty('exePhase1.x', getProperty('iconP2.x'));
	setProperty('exePhase1.y', getProperty('iconP2.y')-10);
	
	--Psych Engine has a hissy fit if I use elseif statements, so if statements it is.
	if phase3 == true then
		setProperty('exePhase3.scale.x', getProperty('iconP2.scale.x'));
		setProperty('exePhase3.scale.y', getProperty('iconP2.scale.y'));
		setProperty('exePhase3.antialiasing',true);
		setProperty('exePhase3.angle', getProperty('iconP2.angle'));
		setObjectCamera('exePhase3', 'camHUD');
		setObjectOrder('exePhase3', getObjectOrder('scoreTxt') - 1);
		setProperty('exePhase3.alpha', tonumber(1));
		removeLuaSprite('exevore');
		removeLuaSprite('exevore2');
		removeLuaSprite('exevore3');
		setProperty('iconP2.alpha', tonumber(0));
		
		if getProperty('dad.animation.curAnim.name') == 'singLEFT' and singingStart == true then
			objectPlayAnimation('exePhase3', 'left');
		end
		if getProperty('dad.animation.curAnim.name') == 'singRIGHT' and singingStart == true then
			objectPlayAnimation('exePhase3', 'right');
		end
		if getProperty('dad.animation.curAnim.name') == 'singUP' and singingStart == true then
			objectPlayAnimation('exePhase3', 'up');
		end
		if getProperty('dad.animation.curAnim.name') == 'singDOWN' and singingStart == true then
			objectPlayAnimation('exePhase3', 'down');
		end
		if getProperty('dad.animation.curAnim.name') == 'idle' then
			objectPlayAnimation('exePhase3', 'idle');
		end
	end
	if phase2 == true then
		if getProperty('health') < 0.4 then
			makeLuaSprite('exevore2', 'vore 2', getProperty('iconP2.x'), getProperty('iconP2.y')-10);
			setProperty('exevore2.scale.x', getProperty('iconP2.scale.x'));
			setProperty('exevore2.scale.y', getProperty('iconP2.scale.y'));
			setProperty('exevore2.antialiasing',true);
			setProperty('exevore2.angle', getProperty('iconP2.angle'));
			setObjectCamera('exevore2', 'camHUD');
			setObjectOrder('exevore2', getObjectOrder('scoreTxt') - 1);
			addLuaSprite('exevore2', true);
			removeLuaSprite('exevore');
			removeLuaSprite('exevore3');
			setProperty('iconP2.alpha', tonumber(0));
		end
	end
	if phaseRW == true then
		if getProperty('health') < 0.4 then
			makeLuaSprite('exevore3', 'vore 3 no cap', getProperty('iconP2.x'), getProperty('iconP2.y')-10);
			setProperty('exevore3.scale.x', getProperty('iconP2.scale.x'));
			setProperty('exevore3.scale.y', getProperty('iconP2.scale.y'));
			setProperty('exevore3.antialiasing',true);
			setProperty('exevore3.angle', getProperty('iconP2.angle'));
			setObjectCamera('exevore3', 'camHUD');
			setObjectOrder('exevore3', getObjectOrder('scoreTxt') - 1);
			addLuaSprite('exevore3', true);
			removeLuaSprite('exevore');
			removeLuaSprite('exevore2');
			setProperty('iconP2.alpha', tonumber(0));
		end
	end
	if phase2 == false and phaseRW == false and phase3 == false then	--There's probably an easier way to write this, but here I go overcomplecating it.
		--singing icons go brrrr
		if curStep > 255 and curStep < 512 or curStep > 639 and curStep < 896 then
			if getProperty('dad.animation.curAnim.name') == 'singLEFT' and singingStart == true then
				if getProperty('health') < 0.4 then
					objectPlayAnimation('exePhase1', 'left_win');
				else
					objectPlayAnimation('exePhase1', 'left');
				end
			end
			if getProperty('dad.animation.curAnim.name') == 'singRIGHT' and singingStart == true then
				if getProperty('health') < 0.4 then
					objectPlayAnimation('exePhase1', 'right_win');
				else
					objectPlayAnimation('exePhase1', 'right');
				end
			end
			if getProperty('dad.animation.curAnim.name') == 'singUP' and singingStart == true then
				if getProperty('health') < 0.4 then
					objectPlayAnimation('exePhase1', 'up_win');
				else
					objectPlayAnimation('exePhase1', 'up');
				end
			end
			if getProperty('dad.animation.curAnim.name') == 'singDOWN' and singingStart == true then
				if getProperty('health') < 0.4 then
					objectPlayAnimation('exePhase1', 'down_win');
				else
					objectPlayAnimation('exePhase1', 'down');
				end
			end
		else
			if getProperty('health') < 0.4 then
				objectPlayAnimation('exePhase1', 'idle_win');
			else
				objectPlayAnimation('exePhase1', 'idle');
			end
		end
		if getProperty('health') > 0.4 then
			setProperty('exePhase1.scale.x', getProperty('iconP2.scale.x'));
			setProperty('exePhase1.scale.y', getProperty('iconP2.scale.y'));
			setProperty('exePhase1.antialiasing',true);
			setProperty('exePhase1.angle', getProperty('iconP2.angle'));
			setObjectCamera('exePhase1', 'camHUD');
			setObjectOrder('exePhase1', getObjectOrder('scoreTxt') - 1);
			setProperty('exePhase1.alpha', tonumber(1));
			removeLuaSprite('exevore');
			removeLuaSprite('exevore2');
			removeLuaSprite('exevore3');
			setProperty('iconP2.alpha', tonumber(0));
		end
	end
	
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
local yy = 50;
local xx2 = 880;
local yy2 = 335;
local ofs = 30;
local followchars = true;
local del = 0;
local del2 = 0;

function onUpdate()
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
			if curStep < 2112 then
				setProperty('defaultCamZoom', 0.6);
			else
				setProperty('defaultCamZoom', 0.55);
			end
			if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
				triggerEvent('Camera Follow Pos',xx-ofs,yy-100)
			end
			if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
				triggerEvent('Camera Follow Pos',xx+ofs,yy-100)
			end
			if getProperty('dad.animation.curAnim.name') == 'singUP' then
				triggerEvent('Camera Follow Pos',xx,yy-150-ofs)
			end
			if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
				triggerEvent('Camera Follow Pos',xx,yy-100+ofs)
			end
			if getProperty('dad.animation.curAnim.name') == 'idle' then
				triggerEvent('Camera Follow Pos',xx,yy-100)
			end
        else
			if curStep < 2112 then
				setProperty('defaultCamZoom', 0.85);
			else
				setProperty('defaultCamZoom', 0.9);
			end
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
	if curStep > 2111 then
		xx = 600;
		xx2 = 600;
		ofs = 45;
	end
end

function opponentNoteHit()
	singingStart = true;
	health = getProperty('health')
	if dadName == 'Ethereal_EXE' then
		setProperty('health', health- 0.001);
	else
		setProperty('health', health- 0.00075);
	end
	runTimer('resetSingAnim', 0.05);
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

stepHitFuncs = { --a bunch of timed events, timed to steps
	[960] = function()
		setProperty('exePhase1.alpha', tonumber(0));
		setProperty('iconP2.alpha', tonumber(1));
		phase2 = true;
	end,
	[1728] = function()
		phase2 = false;
		phaseRW = true;
		
		setProperty('red_lol.visible', true);
		setProperty('gf.visible', false);
		
		setProperty('bg.visible', false);
		setProperty('clouds.visible', false);
		setProperty('sun.visible', false);
		setProperty('mountains.visible', false);
		setProperty('middle_ground.visible', false);
		setProperty('scorched_trees.visible', false);
		setProperty('exe_stage.visible', false);
		setProperty('amy.visible', false);
		setProperty('tail.visible', false);
		setProperty('knux.visible', false);
	end,
	[2032] = function()
		phase2 = true;
		phaseRW = false;
		
		setProperty('red_lol.visible', false);
		setProperty('gf.visible', true);
		
		setProperty('bg.visible', true);
		setProperty('clouds.visible', true);
		setProperty('sun.visible', true);
		setProperty('mountains.visible', true);
		setProperty('middle_ground.visible', true);
		setProperty('scorched_trees.visible', true);
		setProperty('exe_stage.visible', true);
		setProperty('amy.visible', true);
		setProperty('tail.visible', true);
		setProperty('knux.visible', true);
	end,
	[2112] = function()
		phase2 = false;
		phaseRW = false;
		phase3 = true;
		setProperty('iconP2.alpha', tonumber(0));
		
		setProperty('red_lol.visible', false);
		setProperty('gf.visible', false);
		
		setProperty('persp_bg.visible', true);
		setProperty('persp_sun.visible', true);
		setProperty('persp_souls.visible', true);
		setProperty('persp_drip.visible', true);
		setProperty('persp_pillar6.visible', true);
		setProperty('persp_pillar5.visible', true);
		setProperty('persp_pillar4.visible', true);
		setProperty('persp_pillar3.visible', true);
		setProperty('persp_pillar2.visible', true);
		setProperty('persp_pillar1.visible', true);
		setProperty('persp_spikes2.visible', true);
		setProperty('persp_spikes1.visible', true);
		setProperty('persp_exeplatform.visible', true);
		setProperty('red_light.visible', true);
		setProperty('persp_bfplatform.visible', true);
		
		addLuaScript('scripts/ui/fakeyfaketimebar');
	end,
	[2678] = function()	--no bitches? no EXEMerging?
		setProperty('exemerge.alpha', tonumber(1));
		
		playSound('vineBoom', 1);
		playSound('vineBoom', 1);
	end
}

function onStepHit()
    if stepHitFuncs[curStep] then 
        stepHitFuncs[curStep]() -- Executes function at curStep in stepHitFuncs
    end
	if missPenalty == true then
		health = getProperty('health')
		setProperty('health', getProperty('health')-drain);
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'resetSingAnim' then
		singingStart = false;
	end
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