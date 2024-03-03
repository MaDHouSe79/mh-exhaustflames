--[[ ===================================================== ]] --
--[[           MH Exhaust Flames Script by MaDHouSe        ]] --
--[[ ===================================================== ]] --
Config = {}

-- Global enable or disable exhaust flames.
Config.Enable = true

-- Min and max rpm before flames are actived.
Config.RPM = { min = 0.75, max = 0.93}

-- Min modkit before this works (0/1/2/3)
Config.MinModkit = 2 

-- don't edit below.
Config.FlameSize = 1.4
Config.ParticleSize = 1.4

Config.exhaust_location = {
    "exhaust",
    "exhaust_2",
    "exhaust_3",
    "exhaust_4",
    "exhaust_5",
    "exhaust_6",
    "exhaust_7",
    "exhaust_8",
    "exhaust_9",
    "exhaust_10",
    "exhaust_11",
    "exhaust_12",
    "exhaust_13",
    "exhaust_14",
    "exhaust_15",
    "exhaust_16",
}

Config.IgnoreVehicles = {
    [0] = true, -- Compacts
    [1] = true, -- Sedans
    [2] = false, -- SUVs
    [3] = false, -- Coupes
    [4] = false, -- Muscle
    [5] = false, -- Sports Classics
    [6] = false, -- Sports
    [7] = false, -- Super
    [8] = true, -- Motorcycles
    [9] = false, -- Off-road
    [10] = true, -- Industrial
    [11] = true, -- Utility
    [12] = true, -- Vans
    [13] = true, -- Cycles
    [14] = true, -- Boats
    [15] = true, -- Helicopters
    [16] = true, -- Planes
    [17] = true, -- Service
    [18] = true, -- Emergency
    [19] = true, -- Military
    [20] = true, -- Commercial
    [21] = true-- Trains
}
