local RanNumMin = 0;
local RanNumSec = 0;
local RanBarLen = 1;

function onCreate()
	math.randomseed(os.clock() * 1000);
	
	if getPropertyFromClass('ClientPrefs', 'downScroll') == false then --upscroll
		Thickness = 1 --Mess with these values until you get what you want.
		Length = 0.665
		barX = 434
		barY = 27

		textX = 594
		textY = 18 --Change "barY" to a number for more positioning options
		textSize = 33
		textColor = 'ffffff' --These colors must be in hex codes
	elseif getPropertyFromClass('ClientPrefs', 'downScroll') == true then --downscroll
		Thickness = 1 --Mess with these values until you get what you want.
		Length = 0.665
		barX = 434
		barY = 682

		textX = 594
		textY = 674 --Change "barY" to a number for more positioning options
		textSize = 33
		textColor = 'ffffff' --These colors must be in hex codes
	end

	fillingBarColor = 'ff0000' --These colors must be in hex codes
	emptyBarColor = '000000'

	makeLuaSprite('emptyBar', 'healthBar', barX, barY-1)
	makeLuaSprite('fillBar', 'healthBar', barX+5, barY)

	addLuaSprite('emptyBar', false)
	addLuaSprite('fillBar', false)

	setObjectCamera('emptyBar', 'hud')
	setObjectCamera('fillBar', 'hud')

	scaleObject('emptyBar', Length, Thickness+0.1)
	scaleObject('fillBar', Length, Thickness-50)

	doTweenColor('emptyBarColor', 'emptyBar', emptyBarColor, 0.01)
	doTweenColor('fillBarColor', 'fillBar', fillingBarColor, 0.01)

	makeLuaText("nametext", RanNumSec, 0, textX+35, textY)	--56
	makeLuaText("nametext2", RanNumMin ..':', 0, textX, textY)
	setTextSize('nametext',  textSize)
	setTextColor('nametext', textColor)
	setTextAlignment('nametext', 'center')
	setTextSize('nametext2',  textSize)
	setTextColor('nametext2', textColor)
	setTextAlignment('nametext2', 'center')
	addLuaText("nametext")
	addLuaText("nametext2")
end

function onStepHit()
    stepdev = curStep % 8;
    if stepdev == 0 then 
		RanNumMin = math.random(0,9);
		RanNumSec = math.random(0,59);
		RanBarLen = math.random(1,10);
		setProperty('fillbar.x', Length+0.1);
		scaleObject('fillBar', Length * getProperty("songPercent") / RanBarLen, Thickness);
		setTextString('nametext', RanNumSec);
		setTextString('nametext2', RanNumMin ..':');
    end
end

function onUpdate()
	if curStep < 2623 then
		if getPropertyFromClass('ClientPrefs', 'timeBarType') == 'Disabled' then
			setProperty('emptyBar.visible', false);
			setProperty('fillBar.visible', false);
			setProperty('nametext.visible', false);
			setProperty('nametext2.visible', false);
			setProperty('nametext3.visible', false);
		else
			setProperty('timeBarBG.visible', false);
			setProperty('timeBar.visible', false);
			setProperty('timeTxt.visible', false);
		end
	else
		if getPropertyFromClass('ClientPrefs', 'timeBarType') == 'Disabled' then
			setProperty('emptyBar.visible', false);
			setProperty('fillBar.visible', false);
			setProperty('nametext.visible', false);
			setProperty('nametext2.visible', false);
			setProperty('nametext3.visible', false);
		else
			setProperty('emptyBar.visible', false);
			setProperty('fillBar.visible', false);
			setProperty('nametext.visible', false);
			setProperty('nametext2.visible', false);
			setProperty('nametext3.visible', false);
			
			setProperty('timeBarBG.visible', true);
			setProperty('timeBar.visible', true);
			setProperty('timeTxt.visible', true);
		end
	end
	
	scorin = getProperty('songScore')
	missies = getProperty('songMisses')
	
	scorinRan = math.random(scorin, scorin+100000000);
	missiesRan = math.random(missies, missies+999);
	ratingRan = math.random(0, 100);
	
	if curStep < 2623 then
		setTextString('scoreTxt', 'Score: ' ..scorinRan.. ' | Misses: ' ..missiesRan.. ' | Accuracy: ' ..ratingRan.. ' % [?]')
		setTextString('botplayTxt', 'look at this dude using botplay lmao skull emoji')
	else
		setTextString('scoreTxt', 'Score: ' ..scorin.. ' | Misses: ' ..missies.. ' | Accuracy: '..(string.sub(getProperty('ratingPercent')* 100,0,5)).. '% ['..getProperty('ratingFC')..']')
		setTextString('botplayTxt', 'look at this dude using botplay lmao skull emoji')
	end
	
	if RanNumSec == 9 then
		setTextString('nametext', '09');
	elseif RanNumSec == 8 then
		setTextString('nametext', '08');
	elseif RanNumSec == 7 then
		setTextString('nametext', '07');
	elseif RanNumSec == 6 then
		setTextString('nametext', '06');
	elseif RanNumSec == 5 then
		setTextString('nametext', '05');
	elseif RanNumSec == 4 then
		setTextString('nametext', '04');
	elseif RanNumSec == 3 then
		setTextString('nametext', '03');
	elseif RanNumSec == 2 then
		setTextString('nametext', '02');
	elseif RanNumSec == 1 then
		setTextString('nametext', '01');
	elseif RanNumSec == 0 then
		setTextString('nametext', '00');
	end
end