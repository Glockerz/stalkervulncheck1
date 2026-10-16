-- Decompiled with Potassium's decompiler.

return {
    resolveDefaultProps = function(p1: any, p2: table) -- Line: 14, Name: resolveDefaultProps
        if not (p1 and (typeof(p1) == "table" and p1.defaultProps)) then
            return p2;
        end;

        local table_clone_ret = table.clone(p2);
        local defaultProps = p1.defaultProps;

        for i, _ in defaultProps do
            if table_clone_ret[i] == nil then
                table_clone_ret[i] = defaultProps[i];
            end;
        end;

        return table_clone_ret;
    end
};