local floor = math.floor

function dfpwm.make_decoder()
    local charge = 0
    local strength = 0

    return function(chunk)
        local buffer = {}

        for i = 1, #chunk do
            local byte = string.byte(chunk, i)

            for j = 0, 7 do
                local bit = (byte >> j) & 1

                local target = bit == 1 and 127 or -128
                local diff = target - charge

                charge = charge + floor(diff * strength / 256 + 0.5)

                if bit == (charge > 0 and 1 or 0) then
                    strength = strength + (255 - strength) / 8
                else
                    strength = strength - strength / 8
                end

                buffer[#buffer + 1] = charge
            end
        end

        return buffer
    end
end

return dfpwm
