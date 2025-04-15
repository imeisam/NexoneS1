local Translations = {
    error = {
        not_online = 'Player not online',
        wrong_format = 'Incorrect format',
        missing_args = 'Not every argument has been entered (x, y, z)',
        missing_args2 = 'All arguments must be filled out!',
        no_access = 'No access to this command',
        company_too_poor = 'Your employer is broke',
        item_not_exist = 'Item does not exist',
        too_heavy = 'Inventory too full',
        duplicate_identifer = 'Duplicate Identifiers Found',
        no_valid_cl  = 'No Valid FiveM Client Found',
        dont_spam = 'Do not Spam The Connect Button.',
    },
    success = {},
    info = {
        received_paycheck = 'You received your paycheck of $%{value}',
        job_info = 'Job: %{value} | Grade: %{value2} | Duty: %{value3}',
        gang_info = 'Gang: %{value} | Grade: %{value2}',
        on_duty = 'You are now on duty!',
        off_duty = 'You are now off duty!',
        checking_ident = 'Hello %s. We are checking your identifiers...',
        checking_ban = 'Checking your identifiers in our database...',
        join_server = 'Welcome to NexOne.',
        admin_report = "Report - ",
        reply_to_report = "Reply To A Report (Admin Only)",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
