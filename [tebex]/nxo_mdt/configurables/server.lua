Config = {
  -- --[[    
  --   Command: 'mdt'
  --   Description: Enables or disables the MDT command.
  --   Set to false to disable the command.
  -- ]]
  Command = 'mdt',

  --[[
    Configuration for handling photos in the MDT.
  ]]
  Photo = {
    method = 'discord', -- The method for handling photos, can be 'imgur' or 'discord'.
    imgur = {
      clientId = '', -- The client ID for Imgur API.
    },
    discord = {
      webhook = 'https://discord.com/api/webhooks/1250602979040559126/TIFP0jRMWZwtlNPLDv1wqv7u6opMjQK3L8pItKom0H8aiIPvav5JXITPeGd6S8OfovOn' -- The webhook URL for Discord API.
    }
  },

  --[[
    This variable controls whether security checks are enabled or disabled.
    Set it to true to enable security checks, or false to disable them.
    Currently it does not work properly, so leave it as false.
  ]]
  SecurityChecks = false,
  
  --[[
    DepartmentViews table stores the configuration for different department views in the MDT.
    Each department view can be enabled or disabled by setting the corresponding value to true or false.
    The 'shared' sub-table defines the access permissions between different departments.
    For example, if shared[0][1] is defined, it means department 0 has access to department 1.
    Similarly, if shared[1][0] is defined, it means department 1 has access to department 0.
  ]]
  DepartmentViews = {
    incidents = true,
    reports = true,
    evidence = true,
    staff = true,
    announcements = true,
    recent = true,

    shared = {
      [0] = { 2, 3 },
      [1] = {  },
      [2] = { 0, 3 },
      [3] = { 0, 2 }
    }
  },

  --[[
    Defines the available genders for characters.
    @field [0] "Male" - Represents a male character.
    @field [1] "Female" - Represents a female character.
    @field [2] "Helicopter" - Represents a helicopter (just for fun!).
  ]]
  Genders = {
    [0] = "Male",
    [1] = "Female",
  },

  --[[
    This file contains the configuration for the staff tables in the MDT.
    The staff tables define the columns and default values for different staff categories such as roster, academy, and database.
    Each staff category has its own set of columns with different types (checkbox, input, select, etc.) and default values.
    The options for select type columns are also defined here.
  ]]
  StaffTables = {

    -- Roster staff table configuration
    roster = {
      { column = "apu",              label = "APU",              type = "checkbox",     default = false },
      { column = "air",              label = "AIR",              type = "checkbox",     default = false },
      { column = "mc",               label = "MC",               type = "checkbox",     default = false },
      { column = "k9",               label = "K9",               type = "checkbox",     default = false },
      { column = "fto",              label = "FTO",              type = "checkbox",     default = false },
      { column = "strikes",          label = "Strikes",          type = "input-number", default = 0 },
      { column = "responsibilities", label = "Responsibilities", type = "input",        default = "Default Text" },
      {
        column = "status",
        label = "Status",
        type = "select",
        default = 0,
        options = {
          { value = 0, label = "Pending" },
          { value = 1, label = "Resolved" },
          { value = 2, label = "Under Review " }
        }
      },
      { column = "notes", label = "Notes", type = "input-textarea", default = "" }
    },

    -- Academy staff table configuration
    academy = {
      { column = "intro_course",      label = "Intro course",      type = "checkbox",       default = false },
      { column = "mdt_access",        label = "MDT Access",        type = "checkbox",       default = false },
      { column = "driving",           label = "Driving",           type = "checkbox",       default = false },
      { column = "shooting_training", label = "Shooting Training", type = "checkbox",       default = false },
      { column = "writing",           label = "Writing",           type = "checkbox",       default = false },
      { column = "rights",            label = "Rights",            type = "checkbox",       default = false },
      { column = "theory_test",       label = "Theory Test",       type = "checkbox",       default = false },
      { column = "practical_test",    label = "Practical Test",    type = "checkbox",       default = false },
      { column = "notes",             label = "Notes",             type = "input-textarea", default = "" }
    },

    -- Database staff table configuration
    database = {
      { column = "description_of_infaction",  label = "Description of Infraction", type = "input-textarea", default = "" },
      { column = "disciplinary_action_taken", label = "Disciplinary Action Taken", type = "input",          default = "" },
      {
        column = "status",
        label = "Status",
        type = "select",
        default = 0,
        options = {
          { value = 0, label = "Pending" },
          { value = 1, label = "Resolved" },
          { value = 2, label = "Under Review " }
        }
      },
      {
        column = "severity_level",
        label = "Severity Level",
        type = "select",
        default = 0,
        options = {
          { value = 0, label = "Minor" },
          { value = 1, label = "Moderate" },
          { value = 2, label = "Serious" }
        }
      },
      { column = "supervisor",         label = "Supervisor",         type = "input",          default = "" },
      { column = "notes",              label = "Notes",              type = "input-textarea", default = "" }
    }

  },

  --[[
    The Cron table defines various settings related to cron jobs.
    The prints table controls the printing of debug messages for different cron job events.
    The timers table specifies the durations (in minutes) for different cron jobs.
  ]]
  Cron = {
    prints = {
      start = true,
      execute = true,
      wait = true,
      expired = true,
      update = true
    },
    timers = {
      bolos = 5,
      warrants = 5,
      announcements = 30,
      officers = 1
    }
  },

  --[[
    VehicleColor table stores the names of different vehicle colors.
    The keys represent the color index, and the values represent the color name.
  ]]
  VehicleColor = {
    [0] = "Metallic Black",
    [1] = "Metallic Graphite Black",
    [2] = "Metallic Black Steal",
    [3] = "Metallic Dark Silver",
    [4] = "Metallic Silver",
    [5] = "Metallic Blue Silver",
    [6] = "Metallic Steel Gray",
    [7] = "Metallic Shadow Silver",
    [8] = "Metallic Stone Silver",
    [9] = "Metallic Midnight Silver",
    [10] = "Metallic Gun Metal",
    [11] = "Metallic Anthracite Grey",
    [12] = "Matte Black",
    [13] = "Matte Grey",
    [14] = "Matte Light Grey",
    [15] = "Util Black",
    [16] = "Util Black Poly",
    [17] = "Util Dark silver",
    [18] = "Util Silver",
    [19] = "Util Gun Metal",
    [20] = "Util Shadow Silver",
    [21] = "Worn Black",
    [22] = "Worn Graphite",
    [23] = "Worn Silver Grey",
    [24] = "Worn Silver",
    [25] = "Worn Blue Silver",
    [26] = "Worn Shadow Silver",
    [27] = "Metallic Red",
    [28] = "Metallic Torino Red",
    [29] = "Metallic Formula Red",
    [30] = "Metallic Blaze Red",
    [31] = "Metallic Graceful Red",
    [32] = "Metallic Garnet Red",
    [33] = "Metallic Desert Red",
    [34] = "Metallic Cabernet Red",
    [35] = "Metallic Candy Red",
    [36] = "Metallic Sunrise Orange",
    [37] = "Metallic Classic Gold",
    [38] = "Metallic Orange",
    [39] = "Matte Red",
    [40] = "Matte Dark Red",
    [41] = "Matte Orange",
    [42] = "Matte Yellow",
    [43] = "Util Red",
    [44] = "Util Bright Red",
    [45] = "Util Garnet Red",
    [46] = "Worn Orange",
    [47] = "Worn Light Orange",
    [48] = "Metallic Securicor Green",
    [49] = "Metallic Dark Green",
    [50] = "Metallic Gasoline Blue Green",
    [51] = "Matte Lime Green",
    [52] = "Util Dark Green",
    [53] = "Util Green",
    [54] = "Worn Dark Green",
    [55] = "Worn Green",
    [56] = "Worn Sea Wash",
    [57] = "Metallic Midnight Blue",
    [58] = "Metallic Dark Blue",
    [59] = "Metallic Saxony Blue",
    [60] = "Metallic Blue",
    [61] = "Metallic Mariner Blue",
    [62] = "Metallic Harbor Blue",
    [63] = "Metallic Diamond Blue",
    [64] = "Metallic Surf Blue",
    [65] = "Metallic Nautical Blue",
    [66] = "Metallic Bright Blue",
    [67] = "Metallic Purple Blue",
    [68] = "Metallic Spinnaker Blue",
    [69] = "Metallic Ultra Blue",
    [70] = "Metallic Bright Midnight Blue",
    [71] = "Gloss Black",
    [72] = "Worn Dark Red",
    [73] = "Worn Red",
    [74] = "Worn Golden Red",
    [75] = "Worn Dark Brown",
    [76] = "Worn Brown",
    [77] = "Worn Straw Beige",
    [78] = "Worn Dark Blue",
    [79] = "Worn Blue",
    [80] = "Worn Light Blue",
    [81] = "Metallic Taxi Yellow",
    [82] = "Metallic Race Yellow",
    [83] = "Metallic Bronze",
    [84] = "Metallic Yellow Bird",
    [85] = "Metallic Lime",
    [86] = "Metallic Champagne",
    [87] = "Metallic Pueblo Beige",
    [88] = "Metallic Dark Ivory",
    [89] = "Metallic Choco Brown",
    [90] = "Metallic Golden Brown",
    [91] = "Metallic Light Brown",
    [92] = "Metallic Straw Beige",
    [93] = "Metallic Moss Brown",
    [94] = "Metallic Biston Brown",
    [95] = "Metallic Beechwood",
    [96] = "Metallic Dark Beechwood",
    [97] = "Metallic Choco Orange",
    [98] = "Metallic Beach Sand",
    [99] = "Metallic Sun Bleeched Sand",
    [100] = "Metallic Cream",
    [101] = "Util Brown",
    [102] = "Util Medium Brown",
    [103] = "Util Light Brown",
    [104] = "Metallic White",
    [105] = "Metallic Frost White",
    [106] = "Worn Honey Beige",
    [107] = "Worn Brown",
    [108] = "Worn Dark Brown",
    [109] = "Worn straw beige",
    [110] = "Brushed Steel",
    [111] = "Brushed Black steel",
    [112] = "Brushed Aluminium",
    [113] = "Chrome",
    [114] = "Worn Off White",
    [115] = "Util Off White",
    [116] = "Worn Orange",
    [117] = "Worn Light Orange",
    [118] = "Metallic Securicor Green",
    [119] = "Worn Taxi Yellow",
    [120] = "police car blue",
    [121] = "Matte Green",
    [122] = "Matte Brown",
    [123] = "Matte White",
    [124] = "Worn White",
    [125] = "Worn Olive Army Green",
    [126] = "Metallic Pea Green",
    [127] = "Metallic Bright Blue",
    [128] = "Metallic Olive Drab Green",
    [129] = "Metallic Dark Earth",
    [130] = "Metallic Desert Tan",
    [131] = "Metallic Foilage Green",
    [132] = "DEFAULT ALLOY COLOR",
    [133] = "Epsilon Blue",
    [134] = "Pure Gold",
    [135] = "Brushed Gold",
    [136] = "Secret Gold",
    [137] = "Dark Green",
    [138] = "Metallic Racing Green",
    [139] = "Sea Green",
    [140] = "Olive Green",
    [141] = "Green",
    [142] = "Matte Lime Green",
    [143] = "Yellow",
    [144] = "Metallic Off White",
    [145] = "Yellow",
    [146] = "Lime Green",
    [147] = "Forest Green",
    [148] = "Lime Green",
    [149] = "Dark Green",
    [150] = "Bright Purple",
    [151] = "Muted Pink",
    [152] = "Bright Pink",
    [153] = "Currant Pink",
    [154] = "Fuchsia",
    [155] = "Hot Pink",
    [156] = "Pinky",
    [157] = "Bright Pink",
    [158] = "Purple",
    [159] = "Muted Pink"
  },
}
