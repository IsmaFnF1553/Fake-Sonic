--Watermark Script by MasterDirector99
currentDifficulty = '';

function onCreate()

    makeLuaText('songText', songName .. ' - ' .. currentDifficulty .. " - EXEMerge", 0, 2, 701);
    setTextAlignment('songText', 'left');
    setTextSize('songText', 15);
    setTextBorder('songText', 1, '000000');
    addLuaText('songText');
end

function onUpdate()
    setObjectCamera('VHS', 'camHUD')
    setObjectCamera('songText', 'camHUD')

    currentDifficulty = getProperty('storyDifficultyText');
    setTextString('songText', songName .. " - EXEMerge");
end