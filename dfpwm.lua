local dfpwm = {}

function dfpwm.make_decoder()
    return function(chunk)
        local buffer = {}
        for i = 1, #chunk do
            local byte = string.byte(chunk, i)
            buffer[#buffer + 1] = (byte - 128) / 128
        end
        return buffer
    end
end

return dfpwm
