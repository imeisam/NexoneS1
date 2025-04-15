QBShared = QBShared or {}
QBShared.Jobs = {
	['unemployed'] = {
		label = 'Civilian',
		grades = {
            ['0'] = {
                name = 'No Garde',
                salary = 50
            },
        },
	},
	['police'] = {
		label = 'Law Enforcement',
        category = 'leo',
        division = {
            ['fr'] = true,
            ['hr'] = true,
            ['db'] = true,
            ['fa'] = true,
            ['mp '] = true,
            ['air'] = true,
            ['k9'] = true,
            ['hc'] = true,
            ['bp'] = true,
            ['dispatch'] = true
        },
		grades = {
			['0'] = {
                name = 'Officer I',
                dep = 'police',
                salary = 230
            },
			['1'] = {
                name = 'Officer II',
                dep = 'police',
                salary = 250
            },
            ['2'] = {
                name = 'Officer III',
                dep = 'police',
                salary = 270
            },
			['3'] = {
                name = 'Senior Officer',
                dep = 'police',
                salary = 290
            },
			['4'] = {
                name = 'Detective I',
                dep = 'police',
                salary = 310
            },
            ['5'] = {
                name = 'Detective II',
                dep = 'police',
                salary = 330
            },
            ['6'] = {
                name = 'Detective III',
                dep = 'police',
                salary = 350
            },
            ['7'] = {
                name = 'Sergeant I',
                dep = 'police',
                salary = 370
            },
            ['8'] = {
                name = 'Sergeant II',
                dep = 'police',
                salary = 390
            },
            ['9'] = {
                name = 'Lieutenant I',
                dep = 'police',
                salary = 410
            },
            ['10'] = {
                name = 'Lieutenant II',
                dep = 'police',
                salary = 430
            },
            ['11'] = {
                name = 'Captain I',
                dep = 'police',
                salary = 450
            },
            ['12'] = {
                name = 'Captain II',
                dep = 'police',
                salary = 470
            },
            ['13'] = {
                name = 'Captain III',
                dep = 'police',
                salary = 490
            },
            ['14'] = {
                name = 'Commander',
                dep = 'police',
                salary = 510
            },
            ['15'] = {
                name = 'Assistant Chief of Police',
                dep = 'police',
                salary = 520
            },
			['16'] = {
                name = 'Chief of Police',
                isboss = true,
                dep = 'police',
                salary = 550
            },
        },
	},
    ['ambulance'] = {
        label = 'EMS',
        category = 'ems',
        division = {
            ['hr'] = true,
            ['air'] = true,
            ['hc'] = true,
            ['fr'] = true,
            ['co'] = true,
            ['fto'] = true,
            ['ems'] = true,
        },
        grades = {
            ['0'] = {
                name = "Intern",
                salary = 255
            },
            ['1'] = {
                name = "Resident",
                salary = 310
            },
            ['2'] = {
                name = "Staff Doctor",
                salary = 390
            },
            ['3'] = {
                name = "Senior Staff Doctor",
                salary = 460
            },
            ['4'] = {
                name = "Attending Doctor",
                salary = 490
            },
            ['5'] = {
                name = "Head Doctor",
                salary = 550
            },
            ['6'] = {
                name = "Trainee",
                salary = 255
            },
            ['7'] = {
                name = "Solo Trainee",
                salary = 280
            },
            ['8'] = {
                name = "Emergency Medical Technician",
                salary = 315
            },
            ['9'] = {
                name = "Advanced EMT",
                salary = 350
            },
            ['10'] = {
                name = "Paramedic",
                salary = 385
            },
            ['11'] = {
                name = "Lieutenant",
                salary = 420
            },
            ['12'] = {
                name = "Captain",
                salary = 455
            },
            ['13'] = {
                name = "Deputy Chief",
                ismanager = true,
                salary = 490
            },
            ['14'] = {
                name = "Chief of EMS",
                isboss = true,
                salary = 550
            },
        },
    },
    ['justice'] = {
		label = 'Department of Justice',
        category = 'leo',
        division = {
            ['hr'] = true,
            ['air'] = true,
            ['hc'] = true,
            ['marshal'] = true,
            ['fa'] = true,
        },
		grades = {
            ['0'] = {
                name = "Employee",
                dep = 'justice',
                salary = 250
            },
            ['1'] = {
                name = "Marshal",
                dep = 'marshal',
                salary = 270
            },
            ['2'] = {
                name = "SOG",
                dep = 'marshal',
                salary = 290
            },
            ['3'] = {
                name = "Associate Director",
                dep = 'marshal',
                salary = 310
            },
            ['4'] = {
                name = "Director",
                dep = 'marshal',
                isboss = true,
                salary = 330
            },
			['5'] = {
                name = 'Prosecutor',
                dep = 'justice',
                salary = 380
            },
            ['6'] = {
                name = 'Judge',
                dep = 'justice',
                salary = 480
            },
            ['7'] = {
                name = 'Adviser',
                dep = 'justice',
                salary = 500
            },
            ['8'] = {
                name = 'Attorney General',
                dep = 'marshal',
                isboss = true,
                salary = 550
            },
        },
	},
    ['goverment'] = {
		label = 'Goverment',
		grades = {
            ['0'] = {
                name = 'Guard',
                salary = 250
            },
            ['1'] = {
                name = 'Employee',
                salary = 280
            },
            ['2'] = {
                name = 'Agent',
                salary = 330
            },
            ['3'] = {
                name = 'Deputy mayor',
                salary = 380
            },
            ['4'] = {
                name = 'Mayor',
                isboss = true,
                salary = 550
            },
        },
	},
    ['lsnews'] = {
		label = 'LSNEWS',
		grades = {
            ['0'] = {
                name = 'Reporter',
                salary = 110,
            },
            ['1'] = {
                name = 'Camera operator',
                salary = 150,
            },
            ['2'] = {
                name = 'Journalist',
                salary = 200,
            },
            ['3'] = {
                name = 'Boss',
                isboss = true,
                salary = 250,
            },
        },
	},
    ['snrsmoothie'] = {
		label = 'Fresh Fruit',
		grades = {
            ['0'] = {
                name = 'Recruit',
                salary = 200,
            },
            ['1'] = {
                name = 'Novice',
                salary = 250,
            },
            ['2'] = {
                name = 'Experienced',
                salary = 300,
            },
            ['3'] = {
                name = 'Advanced',
                salary = 350,
            },
            ['4'] = {
                name = 'Boss',
                isboss = true,
                salary = 400,
            },
        },
	},
    ['snrpizza'] = {
		label = 'Snr Pizza',
		grades = {
            ['0'] = {
                name = 'Recruit',
                salary = 200,
            },
            ['1'] = {
                name = 'Novice',
                salary = 250,
            },
            ['2'] = {
                name = 'Experienced',
                salary = 300,
            },
            ['3'] = {
                name = 'Advanced',
                salary = 350,
            },
            ['4'] = {
                name = 'Boss',
                isboss = true,
                salary = 400,
            },
        },
	},
    ['yellowjack'] = {
		label = 'Yellow Jack',
		grades = {
            ['0'] = {
                name = 'Recruit',
                salary = 200,
            },
            ['1'] = {
                name = 'Novice',
                salary = 250,
            },
            ['2'] = {
                name = 'Experienced',
                salary = 300,
            },
            ['3'] = {
                name = 'Advanced',
                salary = 350,
            },
            ['4'] = {
                name = 'Boss',
                isboss = true,
                salary = 400,
            },
        },
	},
    ['lawyer'] = {
		label = 'Lawyer',
		grades = {
            ['0'] = {
                name = 'Lawyer',
                salary = 200,
            },
            ['1'] = {
                name = 'HR Lawyer',
                isboss = true,
                salary = 250,
            },
        },
	},
    ["tuner"] = {
		label = "Tuner",
		grades = {
			['0'] = {
				name = "Apprentice",
                salary = 250,
			},
			['1'] = {
				name = "Mechanic",
                salary = 250,
			},
			['2'] = {
				name = "Technician",
                ismanager = true,
                salary = 350,
			},
			['3'] = {
				name = "Boss",
				isboss = true,
                salary = 400,
			},
		},
	},
    ["mechanic"] = {
		label = "Mosley Auto Service",
        defaultDuty = false,
		grades = {
            ['0'] = {
				name = "Apprentice",
                salary = 250,
			},
			['1'] = {
				name = "Mechanic",
                salary = 250,
			},
			['2'] = {
				name = "Co-Owner",
                salary = 350,
			},
			['3'] = {
				name = "Owner",
				isboss = true,
                salary = 400,
			},
		},
	},
    ["cardealer"] = {
		label = "Mosley Auto Dealer",
		grades = {
            ['0'] = {
                name = "Employee",
                salary = 250,
            },
            ['1'] = {
				name = "Supervisor",
                salary = 250,
            },
            ['2'] = {
				name = "Manager",
                ismanager = true,
                salary = 350,
            },
            ['3'] = {
				name = "Boss",
				isboss = true,
                salary = 400,
            },
        },
	},
    ["taxi"] = {
		label = "Taxi",
		grades = {
            ['0'] = {
                name = 'Driver',
                salary = 250,
            },
            ['1'] = {
                name = 'Manager',
                salary = 250,
                ismanager = true,
            },
            ['2'] = {
                name = 'Boss',
                salary = 300,
                isboss = true,
            },
        },
	},
    ['realestate'] = {
		label = 'Real Estate',
		grades = {
			['0'] = {
                name = 'Document Writer',
                salary = 250,
            },
			['1'] = {
                name = 'Advisor',
                salary = 250,
            },
			['2'] = {
                name = 'Broker',
                salary = 300,
				isboss = true,
            },
        },
	},
    ['wine'] = {
        label = 'Winemaker',
        grades = {
            ['0'] = {
                name = 'Recruit',
            },
            ['1'] = {
                name = 'Novice',
            },
            ['2'] = {
                name = 'Experienced',
            },
            ['3'] = {
                name = 'Advanced',
            },
            ['4'] = {
                name = 'Manager',
            },
            ['5'] = {
                name = 'Boss',
                isboss = true,
            },
        },
    },
    ['unicorn'] = {
        label = 'Vanilla Unicorn',
        grades = {
            ['0'] = {
                name = 'Restroom attendant',
                salary = 300
            },
            ['1'] = {
                name = 'Bouncer',
                salary = 300
            },
            ['2'] = {
                name = 'Bartender',
                salary = 300
            },
            ['3'] = {
                name = 'DJ',
                salary = 300
            },
            ['4'] = {
                name = 'Manager',
                salary = 350,
                ismanager = true
            },
            ['5'] = {
                name = 'Boss',
                isboss = true,
                salary = 400
            },
        },
    },
    ['snrbuns'] = {
        label = "Snr Buns",
        grades = {
            ['0'] = {
                name = "Chef",
                salary = 300,
            },
            ['1'] = {
                name = "Master Chef",
                salary = 300,
            },
            ['2'] = {
                name = "Manager",
                salary = 350,
            },
            ['3'] = {
                name = "Boss",
                isboss = true,
                salary = 400
            },
        },
    },
    ["vangelico"] = {
		label = "Vangelico",
		grades = {
            ['0'] = {
                name = "Employee",
                salary = 300,
            },
            ['1'] = {
				name = "Supervisor",
                salary = 300,
            },
            ['2'] = {
				name = "Manager",
                ismanager = true,
                salary = 350,
            },
            ['3'] = {
				name = "Boss",
				isboss = true,
                salary = 400,
            },
        },
	},
    ["taco"] = {
		label = "Taco",
		grades = {
            ['0'] = {
                name = "Chef",
                salary = 70,
            },
            ['1'] = {
				name = "Boss",
                salary = 70,
                isboss = true,
            },
        },
	},
    ["toolshop"] = {
		label = "Tool Shop",
		grades = {
            ['0'] = {
                name = "Employee",
                salary = 300,
            },
            ['1'] = {
				name = "Supervisor",
                salary = 300,
            },
            ['2'] = {
				name = "Manager",
                ismanager = true,
                salary = 350,
            },
            ['3'] = {
				name = "Boss",
				isboss = true,
                salary = 400,
            },
        },
	},
    ["pawnshop"] = {
		label = "Pawnshop",
		grades = {
            ['0'] = {
                name = "Employee",
                salary = 300,
            },
            ['1'] = {
				name = "Supervisor",
                salary = 300,
            },
            ['2'] = {
				name = "Manager",
                ismanager = true,
                salary = 350,
            },
            ['3'] = {
				name = "Boss",
				isboss = true,
                salary = 400,
            },
        },
	},
    ["clicklovers"] = {
		label = "Clicklovers",
		grades = {
            ['0'] = {
                name = "Employee",
                salary = 50,
            },
            ['1'] = {
				name = "Supervisor",
                salary = 50,
            },
            ['2'] = {
				name = "Manager",
                salary = 50,
                ismanager = true,
            },
            ['3'] = {
				name = "Boss",
                salary = 50,
				isboss = true,
            },
        },
	},
    ["church"] = {
		label = "Church",
		grades = {
            ['0'] = {
                name = "Youth pastor",
                salary = 200,
            },
            ['1'] = {
				name = "Pastor",
                salary = 200,
            },
            ['2'] = {
				name = "Chaplain",
                salary = 250,
                ismanager = true,
            },
            ['3'] = {
				name = "Worship leader",
                salary = 300,
				isboss = true,
            },
        },
	},
    ["digitalden"] = {
		label = "Digitalden",
		grades = {
            ['0'] = {
                name = "Employee",
                salary = 300,
            },
            ['1'] = {
				name = "Supervisor",
                salary = 300,
            },
            ['2'] = {
				name = "Manager",
                ismanager = true,
                salary = 350,
            },
            ['3'] = {
				name = "Boss",
				isboss = true,
                salary = 400,
            },
        },
	},
    ["yoga"] = {
		label = "Happy Yoga",
		grades = {
            ['0'] = {
                name = "Employee",
                salary = 200,
            },
            ['1'] = {
				name = "Supervisor",
                salary = 200,
            },
            ['2'] = {
				name = "Manager",
                ismanager = true,
                salary = 250,
            },
            ['3'] = {
				name = "Boss",
				isboss = true,
                salary = 300,
            },
        },
	},
    ["therapy"] = {
		label = "Sweet Relife",
		grades = {
            ['0'] = {
                name = "Employee",
                salary = 200,
            },
            ['1'] = {
				name = "Supervisor",
                salary = 200,
            },
            ['2'] = {
				name = "Manager",
                salary = 250,
                ismanager = true,
            },
            ['3'] = {
				name = "Boss",
                salary = 300,
				isboss = true,
            },
        },
	},
    ["cashexchange"] = {
		label = "Cash Exchange",
		grades = {
            ['0'] = {
                name = "Employee",
                salary = 200,
            },
            ['1'] = {
				name = "Supervisor",
                salary = 200,
            },
            ['2'] = {
				name = "Manager",
                salary = 250,
                ismanager = true,
            },
            ['3'] = {
				name = "Boss",
                salary = 300,
				isboss = true,
            },
        },
	},
    ["gallery"] = {
		label = "Art Gallery",
		grades = {
            ['0'] = {
                name = "Employee",
                salary = 200,
            },
            ['1'] = {
				name = "Supervisor",
                salary = 200,
            },
            ['2'] = {
				name = "Manager",
                salary = 250,
                ismanager = true,
            },
            ['3'] = {
				name = "Boss",
                salary = 300,
				isboss = true,
            },
        },
	},
    ["catcafe"] = {
		label = "UWU Cafe",
		grades = {
            ['0'] = {
                name = "Employee",
                salary = 300,
            },
            ['1'] = {
				name = "Supervisor",
                salary = 300,
            },
            ['2'] = {
				name = "Manager",
                salary = 350,
                ismanager = true,
            },
            ['3'] = {
				name = "Boss",
                salary = 400,
				isboss = true,
            },
        },
	},
    ["snrhotdog"] = {
		label = "Snr Hotdog",
		grades = {
            ['0'] = {
                name = "Employee",
                salary = 300,
            },
            ['1'] = {
				name = "Supervisor",
                salary = 300,
            },
            ['2'] = {
				name = "Manager",
                salary = 350,
                ismanager = true,
            },
            ['3'] = {
				name = "Boss",
                salary = 400,
				isboss = true,
            },
        },
	},
    ["hotdog"] = {
		label = "Hotdog",
		grades = {
            ['0'] = {
                name = "Employee",
                salary = 200,
            },
            ['1'] = {
				name = "Boss",
                salary = 200,
				isboss = true,
            },
        },
	},
    ["snrsushi"] = {
		label = "Snr Sushi",
		grades = {
            ['0'] = {
                name = "Employee",
                salary = 300,
            },
            ['1'] = {
				name = "Supervisor",
                salary = 300,
            },
            ['2'] = {
				name = "Manager",
                salary = 350,
                ismanager = true,
            },
            ['3'] = {
				name = "Boss",
                salary = 400,
				isboss = true,
            },
        },
	},
    ["snrcoffee"] = {
		label = "Snr Coffee",
		grades = {
            ['0'] = {
                name = "Employee",
                salary = 300,
            },
            ['1'] = {
				name = "Supervisor",
                salary = 300,
            },
            ['2'] = {
				name = "Manager",
                salary = 350,
                ismanager = true,
            },
            ['3'] = {
				name = "Boss",
                salary = 400,
				isboss = true,
            },
        },
	},
    ['tequilala'] = {
        label = 'Tequilala',
        grades = {
            ['0'] = {
                name = 'DJ',
                salary = 300
            },
            ['1'] = {
                name = 'Restroom attendant',
                salary = 300
            },
            ['2'] = {
                name = 'Bouncer',
                salary = 300
            },
            ['3'] = {
                name = 'Bartender',
                salary = 300
            },
            ['4'] = {
                name = 'Manager',
                salary = 350,
                ismanager = true
            },
            ['5'] = {
                name = 'Boss',
                isboss = true,
                salary = 400
            },
        },
    },
    
}