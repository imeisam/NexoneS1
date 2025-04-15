Logger = {

  enableDebug = false,

  info = function(message, ...)
    -- print(('[^4INFO^7] ' .. message):format(...))
  end,

  warn = function(message, ...)
    print(('[^3WARNING^7] ' .. message):format(...))
  end,

  error = function(message, ...)
    error((message):format(...))
  end,

  debug = function(message, ...)
    if not Logger.enableDebug then return end

    print(('[^6DEBUG^7] ' .. message):format(...))
  end,
}