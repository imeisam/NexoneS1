INSTALL QUIDE

1. Download all dependencies!
    Dependencies:
    ox_lib | https://github.com/overextended/ox_lib
    es_extended / qb-core
    qtarget / qb-target / ox_target
    calibrate-minihgame - https://github.com/dolaji-op/calibrate-distributor
    ultra-voltlab - https://github.com/ultrahacx/ultra-voltlab


2. Add experience system to your server
    Use this insert in your database!



CREATE TABLE IF NOT EXISTS `drc_electrician` (
  `identifier` varchar(255) NOT NULL,
  `experience` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



3. Add this if you want to require job IF USE ESX !



INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_electrician', 'electrician', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_electrician', 'electrician', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_electrician', 'electrician', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('electrician', 'electrician')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('electrician',0,'worker','Worker',120,'{}','{}')
;


 IF U USING QB CORE USE THIS !

    qb-core > shared.lua
    ['electrician'] = {
        label = 'Electrician',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Worker',
                payment = 50
            },
        },
    },


4. add ensure drc_electrician into your server.cfg (make sure to start it after ox_lib and your target system!)

5. Enjoy your new electrician job script from DRC SCRIPTS!
