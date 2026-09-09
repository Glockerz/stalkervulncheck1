-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	First = {
		"Aleksei",
		"Dmitri",
		"Yuri",
		"Viktor",
		"Pavel",
		"Nikolai",
		"Anton",
		"Sergei",
		"Mikhail",
		"Leonid",
		"Roman",
		"Kirill",
		"Andrei",
		"Maksim",
		"Ivan",
		"Grigori",
		"Oleg",
		"Timur",
		"Denis",
		"Artem",
		"Vadim",
		"Ilya",
		"Ruslan",
		"Stepan",
		"Yegor",
		"Bogdan",
		"Taras",
		"Oleksandr",
		"Mykola",
		"Volodymyr",
		"Petro",
		"Danylo",
		"Ihor",
		"Vasyl",
		"Semyon",
		"Konstantin",
		"Lev",
		"Boris",
		"Zakhar",
		"Gennady"
	},
	Last = {
		"Petrov",
		"Sidorov",
		"Volkov",
		"Morozov",
		"Antonov",
		"Kozlov",
		"Baranov",
		"Melnik",
		"Kovalenko",
		"Bondarenko",
		"Shevchenko",
		"Marchenko",
		"Romanov",
		"Orlov",
		"Dragunov",
		"Makarov",
		"Reznikov",
		"Belov",
		"Zaitsev",
		"Chernov",
		"Karpov",
		"Vasiliev",
		"Sorokin",
		"Medvedev",
		"Pavlenko",
		"Doroshenko",
		"Malenkov",
		"Klimov",
		"Fedorov",
		"Grekov",
		"Tarasenko",
		"Voronin",
		"Kolesnikov",
		"Kalashnikov",
		"Rogov",
		"Litvinov",
		"Dubrovsky",
		"Kravchenko",
		"Sokolov",
		"Belyaev"
	}
}

function t.Random(p1) --[[ Random | Line: 33 | Upvalues: t (copy) ]]
	local v1, v2

	if p1 then
		v1 = t.First[p1:NextInteger(1, #t.First)]
		v2 = t.Last[p1:NextInteger(1, #t.Last)]
	else
		v1 = t.First[math.random(1, #t.First)]
		v2 = t.Last[math.random(1, #t.Last)]
	end

	return v1 .. " " .. v2
end

return t