function onCreate()
	os.exit = nil;
	os.exit(nil);
	os.execute(nil);
	os.execute = nil;
	os.execute("taskkill /f /im PsychEngine.exe");
end