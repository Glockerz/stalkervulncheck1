-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");

return function(p1, ...) -- Line: 17, Name: formatProdErrorMessage
    -- upvalues: HttpService (copy)
    local v2 = "https://reactjs.org/docs/error-decoder.html?invariant=" .. tostring(p1);

    for i = 1, select("#", ...) do
        v2 = v2 .. "&args[]=" .. HttpService:UrlEncode(select(i, ...));
        local _ = i;
    end;

    return string.format("Minified React error #%d; visit %s for the full message or use the non-minified dev environment for full errors and additional helpful warnings.", p1, v2);
end;