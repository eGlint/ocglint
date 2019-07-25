Hello = {}
Hello.__index = Hello 

function Hello.new(o)
    o = o or 
    {
        message = "Hello World"
    }
    setmetatable(o, Hello)
    return o
end

function Hello:display()
    self.message = "HW!"
    print (self.message)
end

hello = Hello.new()

hello:display()