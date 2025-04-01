local settings = ({...})[1] or nil

if settings then
    for q,v in pairs(settings) do
        print(q,v)
    end
else
    print("is nil")
end
