function onCreatePost()
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
	makeLuaSprite('bg', 'faker/divide/sky', -700, -600);
	setScrollFactor('bg', 0.5, 0.5);
	
	makeLuaSprite('middle_ground', 'faker/divide/mountains', -700, -600);
	setScrollFactor('middle_ground', 0.75, 0.75);
	
	makeLuaSprite('faker_pillar1', 'faker/divide/pillar1', -700, -600);
	setScrollFactor('faker_pillar1', 1, 1);
	
	makeLuaSprite('faker_pillar2', 'faker/divide/pillar2', -700, -600);
	setScrollFactor('faker_pillar2', 1, 1);
	
	makeLuaSprite('faker_plant', 'faker/divide/plant', -700, -600);
	setScrollFactor('faker_plant', 1, 1);
	
	makeLuaSprite('faker_flower1', 'faker/divide/flower1', -700, -600);
	setScrollFactor('faker_flower1', 1, 1);
	
	makeLuaSprite('faker_flower2', 'faker/divide/flower2', -700, -600);
	setScrollFactor('faker_flower2', 1, 1);
	
	makeLuaSprite('faker_tree1', 'faker/divide/tree1', -700, -600);
	setScrollFactor('faker_tree1', 1, 1);
	
	makeLuaSprite('faker_tree2', 'faker/divide/tree2', -700, -600);
	setScrollFactor('faker_tree1', 1, 1);
	
	makeLuaSprite('faker_stage', 'faker/divide/grass', -700, -600);
	setScrollFactor('faker_stage', 1, 1);
	
	addLuaSprite('bg', false)
	addLuaSprite('mountains', false)
	addLuaSprite('middle_ground', false)
	addLuaSprite('faker_stage', false)
	addLuaSprite('faker_pillar1', false)
	addLuaSprite('faker_pillar2', false)
	addLuaSprite('faker_plant', false)
	addLuaSprite('faker_flower1', false)
	addLuaSprite('faker_flower2', false)
	addLuaSprite('faker_tree1', false)
	addLuaSprite('faker_tree2', false)
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
		triggerEvent('Change Character', 'dad', 'Faker_Transformation_Divide')
		triggerEvent('Change Character', 'dad', 'Faker_Divide')
		
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
			if dadName == 'Faker_Divide' then
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
					triggerEvent('Camera Follow Pos',xx-ofs,yy-150)
					setProperty('defaultCamZoom', 0.75)
				end
				if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
					triggerEvent('Camera Follow Pos',xx+ofs,yy-100)
					setProperty('defaultCamZoom', 0.75)
				end
				if getProperty('dad.animation.curAnim.name') == 'singUP' then
					triggerEvent('Camera Follow Pos',xx,yy-200-ofs)
					setProperty('defaultCamZoom', 0.7)
				end
				if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
					triggerEvent('Camera Follow Pos',xx+175,yy-100+ofs)
					setProperty('defaultCamZoom', 0.8)
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