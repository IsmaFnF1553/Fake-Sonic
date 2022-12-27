function onCreatePost()
	window_x = getPropertyFromClass('openfl.Lib','application.window.x')
	window_y = getPropertyFromClass('openfl.Lib','application.window.y')
	--debugPrint(window_x)	--prints window x coords
	--debugPrint(window_y)	--prints window y coords
	
	precacheSound('micDrop')
	
	makeLuaSprite('readthefiletitlelol', 'black', 0, 0);
	scaleObject('readthefiletitlelol', 128, 128);
	setObjectCamera('readthefiletitlelol', 'other');
	addLuaSprite('readthefiletitlelol', true);
	
	makeLuaSprite('introcircle', 'StartScreens/CircleFaker', -400, 0);
	setObjectCamera('introcircle', 'other');
	addLuaSprite('introcircle', true);
	makeLuaSprite('introtext', 'StartScreens/TextFaker', -100, 0);
	setObjectCamera('introtext', 'other');
	addLuaSprite('introtext', true);
	
	makeLuaSprite('endingCoverGame', 'black', -1000, -1000);
	scaleObject('endingCoverGame', 1280, 1280);
	setObjectCamera('endingCoverGame', 'camGame');
	addLuaSprite('endingCoverGame', true);
	setProperty('endingCoverGame.visible', false);
	
	setPropertyFromClass('flixel.FlxG', 'autoPause', false);
end

function onCreate()
	RunOnce = true;
	
	setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')+1)
	setObjectOrder('girlfriendGroup', getObjectOrder('dadGroup')-1)
	
	setProperty('skipCountdown', true);
	
	------------------
	--	 FAKER BG   --
	------------------
	makeLuaSprite('bg', 'faker/Background', -700, -600);
	setScrollFactor('bg', 0.4, 0.4);
	
	makeLuaSprite('clouds', 'faker/Clouds', -700, -600);
	setScrollFactor('clouds', 0.5, 0.5);
	
	makeLuaSprite('sun', 'faker/Sun', -700, -600);
	setScrollFactor('sun', 0.5, 0.5);
	
	makeLuaSprite('eclipse', 'faker/Circle', -700, -600);
	setScrollFactor('eclipse', 0.5, 0.5);
	
	makeLuaSprite('middle_ground', 'faker/Middle Ground', -700, -600);
	setScrollFactor('middle_ground', 0.8, 0.8);
	
	makeLuaSprite('exe_stage', 'faker/Floor', -700, -600);
	setScrollFactor('exe_stage', 1, 1);
	
	addLuaSprite('bg', false)
	addLuaSprite('clouds', false)
	addLuaSprite('sun', false)
	addLuaSprite('eclipse', false)
	addLuaSprite('mountains', false)
	addLuaSprite('middle_ground', false)
	addLuaSprite('scorched_trees', false)
	addLuaSprite('exe_stage', false)
end

local allowCountdown = false
local soundhitplayed = false
local waitThing = false
local confirmed = 0
local bfdodged = false;
local value = 150; --using onUpdate to remove 1 every frame

function onStartCountdown()
    if not allowCountdown then
        return Function_Stop
    end
    if allowCountdown then
        return Function_Continue
    end
    return Function_Continue;
end

function onUpdatePost(elapsed)
	if value < 2 then
		doTweenAlpha('graphicAlpha', 'readthefiletitlelol', 0, 0.2, 'quintOut');
		doTweenAlpha('circleAlpha', 'introcircle', 0, 0.2, 'quintOut');
		doTweenAlpha('textAlpha', 'introtext', 0, 0.2, 'quintOut');
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
	if RunOnce == true then
		doTweenX('circleTween', 'introcircle', 30, 2, 'quintOut')
		doTweenX('textTween', 'introtext', 100, 2, 'quintOut')
		setPropertyFromClass('flixel.FlxG', 'autoPause', false);
		triggerEvent('Change Character', 'dad', 'Faker_Transformation')
		triggerEvent('Change Character', 'dad', 'Faker2')
		triggerEvent('Change Character', 'dad', 'Faker1')
		
		RunOnce = false;
	end
end

local xx = 400;
local yy = 325;
local xx2 = 880;
local yy2 = 350;
local ofs = 25;
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
			if dadName == 'Faker1' or dadName == 'Faker2' then
				setProperty('defaultCamZoom', 0.8)
				if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
					triggerEvent('Camera Follow Pos',xx-ofs,yy-100)
				end
				if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
					triggerEvent('Camera Follow Pos',xx+ofs,yy-100)
				end
				if getProperty('dad.animation.curAnim.name') == 'singUP' then
					triggerEvent('Camera Follow Pos',xx,yy-100-ofs)
				end
				if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
					triggerEvent('Camera Follow Pos',xx,yy-100+ofs)
				end
				if getProperty('dad.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xx,yy-100)
				end
			else
				setProperty('cameraSpeed', 1.2)
				if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
					triggerEvent('Camera Follow Pos',xx-ofs,yy-200)
					setProperty('defaultCamZoom', 0.7)
				end
				if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
					triggerEvent('Camera Follow Pos',xx+ofs,yy-100)
					setProperty('defaultCamZoom', 0.7)
				end
				if getProperty('dad.animation.curAnim.name') == 'singUP' then
					triggerEvent('Camera Follow Pos',xx,yy-250-ofs)
					setProperty('defaultCamZoom', 0.65)
				end
				if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
					triggerEvent('Camera Follow Pos',xx+175,yy-100+ofs)
					setProperty('defaultCamZoom', 0.7)
				end
				if getProperty('dad.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xx,yy-100)
					setProperty('defaultCamZoom', 0.7)
				end
			end
        else
			setProperty('defaultCamZoom', 0.85)
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

stepHitFuncs = { --a bunch of timed events, timed to steps
	[768] = function()
		doTweenAlpha('cameraHUDFade', 'camHUD', 0, 4, 'linear');
	end,
	[798] = function() --change step number if necessary.
		playSound('micDrop', 0.75)
	end,
	[800] = function() --change step number if necessary.
		makeLuaSprite('fakerMic', 'faker/mic', 300, 550)
		addLuaSprite('fakerMic', false)
	end,
	[883] = function()
		setProperty('endingCoverGame.visible', true);
	end
}

function onStepHit()
    if stepHitFuncs[curStep] then 
        stepHitFuncs[curStep]() -- Executes function at curStep in stepHitFuncs
    end
end

function onDestroy()
	setPropertyFromClass('flixel.FlxG', 'autoPause', true);
end