GPIO4  = 2
GPIO13 = 7
GPIO12 = 6

id  = 0
sda = GPIO12
scl = GPIO13

-- initialize i2c, set pin1 as sda, set pin2 as scl
i2c.setup(id, sda, scl, i2c.SLOW)

-- user defined function: read from reg_addr content of dev_addr
function read_reg(dev_addr, reg_addr, bytes)
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.TRANSMITTER)
    i2c.write(id, reg_addr)
    i2c.stop(id)
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.RECEIVER)
    c = i2c.read(id, bytes)
    i2c.stop(id)
    return c
end

function str2val(s, len)
    if len == 2 then
        return string.byte(s, 1)*256 + string.byte(s, 2)
    else
        return string.byte(s, 1)
    end
end

function getCap()
    res = read_reg(0x20, 0, 2)
    cap = str2val(res, 2)
    return cap
end
