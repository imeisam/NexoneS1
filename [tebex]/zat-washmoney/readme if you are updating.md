Make sure you have updated the sql, if you do not want to lose data please add this to the washmachines sql table.
ALTER TABLE washmachines ADD rot varchar(255),
ALTER TABLE washmachines ADD bucket int(11)