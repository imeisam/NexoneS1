INSTALL QUIDE

1. Download all dependencies!
    Dependencies:
    ox_lib | https://github.com/overextended/ox_lib
    es_extended / qb-core
    qtarget / qb-target / ox_target


2. Add experience system to your server
    Use this insert in your database!


3. Add jobs to your server (make sure to use correct framework)

ESX JOB INSERT!

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_gardener', 'gardener', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_gardener', 'gardener', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_gardener', 'gardener', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('gardener', 'gardener')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('gardener',0,'worker','Worker',120,'{}','{}')
;




QB JOB INSERT!

qb-core > shared.lua
['gardener'] = {
    label = 'Gardener',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
        ['0'] = {
            name = 'Worker',
            payment = 50
        },
    },
},




4. add ensure drc_gardener into your server.cfg (make sure to start it after ox_lib and your target system!)

5. Enjoy your new gardener job script from DRC SCRIPTS!
