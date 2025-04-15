Config = {}
Config.Debug = false -- script debug
Config.DrawMarker = false -- Draws a marker while riding the horse to show where the animal is being told to go
Config.CoreName = 'qb-core' -- You cane change this if your core file name is differnt 
Config.Input = 'qb-input' -- (can be changed to ps-ui) only change if you have changed your input menu script name
Config.Menu = 'qb-menu' -- (can be changed to ps-ui) only change if you have changed your menu script name or want to use ps-ui
----------
----------
Config.ScholPed = 'a_m_y_salton_01' -- school ped model
Config.ScholPedLoc = vector4(418.2, 6471.51, 27.81, 44.42) -- school ped location
----------
Config.HorseLocation = vector4(425.56, 6462.89, 27.78, 319.04) -- Location for horse viewing
----------
Config.TrainingPrice = 2500 -- how much it cost to train on day 1
Config.TrainingPrice2 = 3500 -- how much it cost to train on day 2
Config.TrainingPrice3 = 4500 -- how much it cost to train on day 3
----------
Config.HorsePrice = 120000 -- price for the horse
Config.CowPrice = 75000 -- price for the cow
----------
Config.JumpForce = 22.0 -- (must be a decimal) Jump force on animal when walking normally
Config.RunningJumpForce = 22.0 -- (must be a decimal) Jump force on animal when running
Config.RunSpeed = 1.3 -- (must be a decimal) What speed is considered running for Config.RunningJumpForce to be new jump force
----------
Config.AmountOfCircles = 1 -- Amount circles on minigame when trying to stay on the animal
Config.SpeedOfcircles = 5 -- Speed of the circle minigame when trying to stay on the animal
----------
Config.WhistleCommand = "whistel" -- Name the command to call your animal
----------
----------
Config.TransLate = {
	-- Notification Text
	SpamJump = "You can not spam jump",
	MissingMoney = "You are missing $",
	TrainingDayCap = "You can only do 1 training session a day",
	AlreadyownAnimal = "You already own this animal",
	PurchasedAnimal = "Successfully purchased animal! :)",
	RoadNotFound = "Road not found",
	AnimalMarked = "Your animal has been marked..",
	CompletedTraining = "You have completed todays training! :)",
	ArnoldBeatYou = "Arnold beat you in todays training! :(",
	PlusTaiming = "+1 Taiming :)",
	MinusTaiming = "-1 Taiming :(",
	MinusPoints = "-1 points :(",
	ShowLove = "Show your horse love before you train with him",
	TrainingCanceled = "Your training has been canceled",
	TrainingAbandoned = "You have abandoned your training",
	-- Menu Text
	GoBack = "ESC or click to go close",
	CallAnimal = "Call your animal ",
	DismissAnimal = "Dismiss your animal",
	NoAnimals = "You dont have any animals",
	Call = "Call your ",
	SchoolName = "Northern Animal Training School",
	SchoolNameTxt = "Train a horse or cow and bond with them!",
	PurchaseHorse = "Puchase horse $",
	PurchaseCow = "Puchase cow $",
	SwapAnimal = "Swap Animal",
	Day1Training = "Do day 1 of training",
	Day2Training = "Do day 2 of training",
	Day3Training = "Do day 3 of training",
	DoingDay1Training = "Day 1: Animal Training",
	DoingDay2Training = "Day 2: Animal Training",
	DoingDay3Training = "Day 3: Animal Training",
	BeatArnold = "Beat Arnold To complete todays training ",
	-- Target
	ViewSchool = "View School",
	Ride = "Ride",
}
----------
----------
-- Day 1 Berricade spawns
Config.Day1TrainingBerricades = {
	vector3(345.01, 6524.25, 28.91),
	vector3(272.09, 6491.06, 30.47),
	vector3(342.56, 6512.01, 28.91),
	vector3(364.97, 6511.78, 28.43),
	vector3(305.36, 6524.9, 29.35),
	vector3(267.57, 6522.8, 30.58),
	vector3(220.47, 6517.1, 31.38),
	vector3(218.32, 6505.73, 31.4),
	vector3(262.77, 6510.85, 30.7),
	vector3(342.7, 6446.01, 30.53),
	vector3(460.5, 6508.16, 29.33),
	vector3(556.76, 6522.09, 29.44),
	vector3(672.33, 6495.98, 29.38),
	vector3(761.7, 6462.26, 31.6),
	vector3(699.68, 6451.21, 31.13),
	vector3(581.18, 6452.9, 30.43),
	vector3(189.82, 6483.76, 31.69),
	vector3(271.69, 6416.09, 32.08),
	vector3(512.29, 6452.33, 30.99),
}
----------
----------
-- Day 2 race vectors
Config.Day2RacePositions = {
	vector3(350.43, 6547.91, 28.11),
	vector3(253.88, 6541.49, 30.58),
	vector3(159.46, 6497.05, 31.89),
	vector3(254.43, 6414.98, 32.09),
	vector3(315.99, 6446.55, 31.23),
	vector3(395.48, 6471.64, 29.46),
	vector3(402.65, 6491.49, 28.1),
	vector3(441.22, 6480.33, 29.38),
	vector3(501.27, 6451.67, 30.72),
	vector3(567.61, 6453.24, 30.57),
	vector3(659.03, 6451.89, 31.65),
	vector3(750.64, 6447.41, 32.03),
	vector3(758.59, 6476.1, 29.62),
	vector3(707.35, 6489.09, 28.87),
	vector3(627.02, 6505.84, 29.66),
	vector3(584.18, 6516.79, 29.6),
	vector3(521.36, 6529.17, 29.66),
	vector3(464.41, 6512.22, 29.22),
	vector3(436.49, 6491.16, 29.21),
	vector3(422.83, 6506.45, 27.84),
	vector3(427.01, 6544.75, 27.68),
	vector3(397.78, 6547.06, 27.44),
}
----------
----------
-- Day 3 race vectors
Config.Day3RacePositions = {
	vector3(2198.11, 5388.67, 156.56),
	vector3(2161.37, 5379.24, 165.46),
	vector3(2103.74, 5375.28, 164.51),
	vector3(2033.2, 5379.65, 174.52),
	vector3(1985.62, 5388.33, 173.08),
	vector3(1924.45, 5393.78, 191.22),
	vector3(1871.69, 5400.72, 221.99),
	vector3(1810.57, 5420.9, 250.82),
	vector3(1767.65, 5439.22, 265.37),
	vector3(1717.8, 5446.96, 293.29),
	vector3(1669.65, 5470.07, 318.04),
	vector3(1636.93, 5484.99, 338.31),
	vector3(1576.39, 5495.75, 375.23),
	vector3(1533.22, 5518.79, 402.75),
	vector3(1477.06, 5535.55, 435.71),
	vector3(1407.76, 5547.59, 461.48),
	vector3(1318.27, 5556.81, 479.23),
	vector3(1243.43, 5560.54, 501.28),
	vector3(1199.14, 5568.32, 523.59),
	vector3(1147.37, 5581.63, 549.24),
	vector3(1077.99, 5593.03, 582.97),
	vector3(1019.78, 5615.27, 608.25),
	vector3(956.54, 5640.88, 636.34),
	vector3(919.03, 5642.21, 655.46),
	vector3(856.14, 5663.46, 680.62),
	vector3(782.13, 5693.46, 696.03),
	vector3(722.75, 5703.0, 711.51),
	vector3(651.48, 5690.97, 733.46),
	vector3(622.5, 5683.44, 744.34),
	vector3(571.29, 5661.77, 763.65),
	vector3(527.78, 5625.89, 780.19),
	vector3(516.69, 5580.37, 782.05),
	vector3(491.27, 5561.24, 784.95),
	vector3(497.07, 5593.83, 795.23),
}