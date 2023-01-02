

Config = {
		-- Key used to take a hit of the vape (51)"E" by default.
	DragControl = 51,

		-- Key used to reset to the resting vape position (58)"G" by default.
	RestingAnim = 58,

		-- The amount of time in (ms) you will need to hold the button in order to commit to the action. (250) by default.
	ButtonHoldTime = 250,

		-- Size of the vape clouds. (0.5) by default.
	SmokeSize = 2.5,

		-- the Odds of your Mod exploding in your face. (10594) by default. lower the number to increase the chance you have to explode.
	FailureOdds = 10594, -- 10594 = 0.0001% chance

		-- The amount of time in (ms) the player has to wait before the can hit the vape again. (4000) by default.
	VapeCoolDownTime = 4000,

		-- The amount of time in (ms) the smoke from the vape will linger. (2800) by default.
	VapeHangTime = 3000,

		-- Whether or not you want ace permissions to be enabled, False = Everyone Can vape, 
	VapePermission = false,

		-- Ace permissions group to allow access. **REQUIRED IF YOU HAVE PERMISSIONS ENABLED**
	PermissionsGroup = "ADD_ACE_GROUP_HERE",

		-- If permissions are enabled you can set the denied access message here. **REQUIRED IF YOU HAVE PERMISSIONS ENABLED**
	InsufficientMessage = "^3You do not have permission to do this.",

		-- This will Enable and disable the debug commands. 
	Debug = false,

		-- The Transparency of the help text when it starts. (0) by default. Just leave this alone...
	HelpTextStartingAlpha = 0,

		-- Hold long in (ms) will the help message appear for. (8000) by default.
	HelpTextLength = 8000,
}