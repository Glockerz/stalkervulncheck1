-- Decompiled with Potassium's decompiler.

local u1 = {
    First = { "Aleksei", "Dmitri", "Yuri", "Viktor", "Pavel", "Nikolai", "Anton", "Sergei", "Mikhail", "Leonid", "Roman", "Kirill", "Andrei", "Maksim", "Ivan", "Grigori", "Oleg", "Timur", "Denis", "Artem", "Vadim", "Ilya", "Ruslan", "Stepan", "Yegor", "Bogdan", "Taras", "Oleksandr", "Mykola", "Volodymyr", "Petro", "Danylo", "Ihor", "Vasyl", "Semyon", "Konstantin", "Lev", "Boris", "Zakhar", "Gennady" },
    Last = { "Petrov", "Sidorov", "Volkov", "Morozov", "Antonov", "Kozlov", "Baranov", "Melnik", "Kovalenko", "Bondarenko", "Shevchenko", "Marchenko", "Romanov", "Orlov", "Dragunov", "Makarov", "Reznikov", "Belov", "Zaitsev", "Chernov", "Karpov", "Vasiliev", "Sorokin", "Medvedev", "Pavlenko", "Doroshenko", "Malenkov", "Klimov", "Fedorov", "Grekov", "Tarasenko", "Voronin", "Kolesnikov", "Kalashnikov", "Rogov", "Litvinov", "Dubrovsky", "Kravchenko", "Sokolov", "Belyaev" }
};

function u1.Random(p2) -- Line: 33
    -- upvalues: u1 (copy)
    local v3, v4;

    if p2 then
        v3 = u1.First[p2:NextInteger(1, #u1.First)];
        v4 = u1.Last[p2:NextInteger(1, #u1.Last)];
    else
        v3 = u1.First[math.random(1, #u1.First)];
        v4 = u1.Last[math.random(1, #u1.Last)];
    end;

    return v3 .. " " .. v4;
end;

return u1;