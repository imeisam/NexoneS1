local Locales = {
    ['ui_cre'] = "Create",
	['ui_grp'] = "Groups",
	['ui_set'] = "Settings",
	['ui_mbr'] = "members",
	['ui_sjr'] = "Send Join Request",
	['ui_ngr'] = "No group has been created yet, so feel free to create one ...",
	['ui_own'] = "Owner",
	['ui_acc'] = "Accepted",
	['ui_pen'] = "Pending",
	['ui_gna'] = "Group name :",
	['ui_gri'] = "Group image :",
	['ui_des'] = "Form a group of friends to work together on a shared mission and have fun.",
	['ui_frn'] = "First name:",
	['ui_lsn'] = "Last name:",
	['ui_mya'] = "My avatar:",
	['ui_cgd'] = "Change your username and avatar before creating or joining groups to remain anonymous.",
	['ui_sve'] = "Save",
}

function _U(entry)
	return Locales[entry] 
end

function GetLocales()
	return Locales
end
