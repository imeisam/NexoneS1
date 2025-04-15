config={}
config.pedcoord=vector4(901.18438720703, 6558.8637695312, 10.274426460266, 201.42295837402)
config.pedmodel='ig_djblamryans'
config.pedScenario='WORLD_HUMAN_SMOKING_POT'
config.containermodel='tr_prop_tr_container_01a'
config.ammorackmodel='ex_prop_crate_ammo_sc'
config.timeout=3600000
config.emptychance=40
config.policerequire=8
config.globalcooldown=120 --min
config.itemrequire="grinder"
config.guard={
    vector4(1107.39, -3184.84, 5.9, 191.85),
    vector4(1109.58, -3199.47, 5.9, 19.0),
    vector4(1092.43, -3183.35, 15.97, 189.34),
    vector4(1109.51, -3204.22, 15.96, 174.28),
}
config.guardmodel='g_m_m_chicold_01'
config.containerlocation={
    {
        {
        container=vector4(1103.55, -3199.0, 4.9, 180.0),
        lock=vector4(1103.5380859375, -3197.185546875, 6.0404802894592, 180.0),                         
        ammorack=vector4(1103.55, -3199.80, 4.9, 180.0),
        },
        {
        container=vector4(1099.44, -3199.0, 4.9, 180.0),
        lock=vector4(1099.4384570312, -3197.185546875, 6.0404802894592, 180.0),
        ammorack=vector4(1099.44, -3199.80, 4.9, 180.0),
        },
        {
        container=vector4(1095.22, -3199.0, 4.9, 180.0),
        lock=vector4(1095.2110595703, -3197.185546875, 6.0404802894592, 180.0),
        ammorack=vector4(1095.22, -3199.80, 4.9, 180.0),
        },
        {
        container=vector4(1091.22, -3199.0, 4.9, 180.0),
        lock=vector4(1091.2110595703, -3197.185546875, 6.0404802894592, 180.0),
        ammorack=vector4(1091.22, -3199.80, 4.9, 180.0),
        },
        {
        container=vector4(1087.22, -3199.0, 4.9, 180.0),
        lock=vector4(1087.2110595703, -3197.185546875, 6.0404802894592, 180.0),
        ammorack=vector4(1087.22, -3199.80, 4.9, 180.0),
        },
        {
        container=vector4(1103.55, -3189.0, 4.9, 0.0),
        lock=vector4(1103.5518994141, -3190.814453125, 6.0404802894592, 0.0),
        ammorack=vector4(1103.55, -3188.20, 4.9, 0.0),
        },
        -- {
        -- container=vector4(1099.44, -3189.0, 4.9, 0.0),
        -- lock=vector4(1099.4432666016, -3190.814453125, 6.0404802894592, 0.0),
        -- ammorack=vector4(1099.44, -3188.20, 4.9, 0.0),
        -- },
        -- {
        -- container=vector4(1095.22, -3189.0, 4.9, 0.0),
        -- lock=vector4(1095.2325927734, -3190.814453125, 6.0404802894592, 0.0),
        -- ammorack=vector4(1099.44, -3188.20, 4.9, 0.0),
        -- },
        -- {
        -- container=vector4(1091.22, -3189.0, 4.9, 0.0),
        -- lock=vector4(1091.2325927734, -3190.814453125, 6.0404802894592, 0.0),
        -- ammorack=vector4(1091.22, -3188.20, 4.9, 0.0),
        -- },
        -- {
        -- container=vector4(1087.22, -3189.0, 4.9, 0.0),
        -- lock=vector4(1087.2325927734, -3190.814453125, 6.0404802894592, 0.0),
        -- ammorack=vector4(1087.22, -3188.20, 4.9, 0.0),
        -- },
        
    },
}
config.reward={
    {name='blueprint',count=math.random(0,1),info={type = 'heavypistol'}},
    {name='blueprint',count=math.random(0,1),info={type = 'pistol50'}},
    {name='heavyarmor',count=math.random(0,2)},
}

containerAnimation = {
    ['objects'] = {
        'tr_prop_tr_grinder_01a',
        'ch_p_m_bag_var02_arm_s'
    },
    ['animations'] = {
        {'action', 'action_container', 'action_lock', 'action_angle_grinder', 'action_bag'}
    },
    ['scenes'] = {},
    ['sceneObjects'] = {}
}
