Config={}
Config.closeprop='ch_prop_ch_laundry_machine_01a'
Config.spainprop='bkr_prop_prtmachine_dryer_spin'
Config.openprop='bkr_prop_prtmachine_dryer_op'
Config.itemneed='markedbills'
Config.giveitem='washedmoney'
Config.washedmoneydelivery=10
Config.additemdelivery='moneyorder'
Config.additemdeliverycount=1
Config.moneyformoneyorder=500
Config.Deliverytimeout=3600000
Config.moneypropmodel='h4_prop_h4_cash_bon_01a'
Config.deliverycarspawn={
    vector4(-465.94506835938, 1136.2409667969, 325.90454101562, 261.87979125977),
    vector4(-462.46801757812, 1142.7491455078, 325.90454101562, 260.11712646484),
    vector4(-454.38543701172, 1139.9912109375, 325.90417480469, 227.30714416504),
}
Config.delivery={
vector4(-424.64700317383, 1109.6558837891, 327.68231201172, 251.18215942383),
   vector4(-397.83773803711, 1101.3770751953, 325.83972167969, 169.14654541016),
  vector4(-387.88079833984, 1125.0430908203, 322.62405395508, 246.01942443848),
}

Config.deliverycarmodel={
    'calico','sultanrs'
}


function Config.GiveKey(plate)
    TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
end

function Config.SetFuel(vehicle, fuel)
    exports['qb-fuel']:SetFuel(vehicle, fuel)
end
