-- Decompiled with Potassium's decompiler.

local function AwaitCondition(p1, p2) -- Line: 1
    local os_clock_ret = os.clock();
    local v3 = p2 or 10;

    while not p1() do
        if v3 < os.clock() - os_clock_ret then
            return false;
        end;

        task.wait();
    end;

    return true;
end;

return function() -- Line: 15
    -- upvalues: AwaitCondition (copy)
    local script_Parent = require(script.Parent);
    local u4 = nil;

    local function NumConns(p5) -- Line: 20
        -- upvalues: u4 (ref)
        return #(p5 or u4):GetConnections();
    end;

    beforeEach(function() -- Line: 25
        -- upvalues: u4 (ref), script_Parent (copy)
        u4 = script_Parent.new();
    end);
    afterEach(function() -- Line: 29
        -- upvalues: u4 (ref)
        u4:Destroy();
    end);
    describe("Constructor", function() -- Line: 33
        -- upvalues: script_Parent (copy), u4 (ref), AwaitCondition (ref)
        it("should create a new signal and fire it", function() -- Line: 34
            -- upvalues: script_Parent (ref), u4 (ref)
            expect(script_Parent.Is(u4)).to.equal(true);
            task.defer(function() -- Line: 36
                -- upvalues: u4 (ref)
                u4:Fire(10, 20);
            end);
            local v6, v7 = u4:Wait();
            expect(v6).to.equal(10);
            expect(v7).to.equal(20);
        end);
        it("should create a proxy signal and connect to it", function() -- Line: 44
            -- upvalues: script_Parent (ref), AwaitCondition (ref)
            local v8 = script_Parent.Wrap(game:GetService("RunService").Heartbeat);
            expect(script_Parent.Is(v8)).to.equal(true);
            local u9 = false;
            v8:Connect(function() -- Line: 48
                -- upvalues: u9 (ref)
                u9 = true;
            end);
            expect(AwaitCondition(function() -- Line: 51
                -- upvalues: u9 (ref)
                return u9;
            end, 2)).to.equal(true);
            v8:Destroy();
        end);
    end);
    describe("FireDeferred", function() -- Line: 58
        -- upvalues: u4 (ref), AwaitCondition (ref)
        it("should be able to fire primitive argument", function() -- Line: 59
            -- upvalues: u4 (ref), AwaitCondition (ref)
            local u10 = nil;
            u4:Connect(function(p11) -- Line: 62
                -- upvalues: u10 (ref)
                u10 = p11;
            end);
            u4:FireDeferred(10);
            expect(AwaitCondition(function() -- Line: 66
                -- upvalues: u10 (ref)
                return u10 == 10;
            end, 1)).to.equal(true);
        end);
        it("should be able to fire a reference based argument", function() -- Line: 71
            -- upvalues: u4 (ref), AwaitCondition (ref)
            local u12 = { 10, 20 };
            local u13 = nil;
            u4:Connect(function(p14) -- Line: 74
                -- upvalues: u13 (ref)
                u13 = p14;
            end);
            u4:FireDeferred(u12);
            expect(AwaitCondition(function() -- Line: 78
                -- upvalues: u12 (copy), u13 (ref)
                return u12 == u13;
            end, 1)).to.equal(true);
        end);
    end);
    describe("Fire", function() -- Line: 84
        -- upvalues: u4 (ref)
        it("should be able to fire primitive argument", function() -- Line: 85
            -- upvalues: u4 (ref)
            local u15 = nil;
            u4:Connect(function(p16) -- Line: 88
                -- upvalues: u15 (ref)
                u15 = p16;
            end);
            u4:Fire(10);
            expect(u15).to.equal(10);
        end);
        it("should be able to fire a reference based argument", function() -- Line: 95
            -- upvalues: u4 (ref)
            local v17 = { 10, 20 };
            local u18 = nil;
            u4:Connect(function(p19) -- Line: 98
                -- upvalues: u18 (ref)
                u18 = p19;
            end);
            u4:Fire(v17);
            expect(u18).to.equal(v17);
        end);
    end);
    describe("ConnectOnce", function() -- Line: 106
        -- upvalues: u4 (ref)
        it("should only capture first fire", function() -- Line: 107
            -- upvalues: u4 (ref)
            local u20 = nil;
            local v22 = u4:ConnectOnce(function(p21) -- Line: 109
                -- upvalues: u20 (ref)
                u20 = p21;
            end);
            expect(v22.Connected).to.equal(true);
            u4:Fire(10);
            expect(v22.Connected).to.equal(false);
            u4:Fire(20);
            expect(u20).to.equal(10);
        end);
    end);
    describe("Wait", function() -- Line: 120
        -- upvalues: u4 (ref)
        it("should be able to wait for a signal to fire", function() -- Line: 121
            -- upvalues: u4 (ref)
            task.defer(function() -- Line: 122
                -- upvalues: u4 (ref)
                u4:Fire(10, 20, 30);
            end);
            local v23, v24, v25 = u4:Wait();
            expect(v23).to.equal(10);
            expect(v24).to.equal(20);
            expect(v25).to.equal(30);
        end);
    end);
    describe("DisconnectAll", function() -- Line: 132
        -- upvalues: u4 (ref)
        it("should disconnect all connections", function() -- Line: 133
            -- upvalues: u4 (ref)
            u4:Connect(function() -- Line: 134
            end);
            u4:Connect(function() -- Line: 135
            end);
            expect(#(nil or u4):GetConnections()).to.equal(2);
            u4:DisconnectAll();
            expect(#(nil or u4):GetConnections()).to.equal(0);
        end);
    end);
    describe("Disconnect", function() -- Line: 142
        -- upvalues: u4 (ref), AwaitCondition (ref)
        it("should disconnect connection", function() -- Line: 143
            -- upvalues: u4 (ref)
            local v26 = u4:Connect(function() -- Line: 144
            end);
            expect(#(nil or u4):GetConnections()).to.equal(1);
            v26:Disconnect();
            expect(#(nil or u4):GetConnections()).to.equal(0);
        end);
        it("should still work if connections disconnected while firing", function() -- Line: 150
            -- upvalues: u4 (ref)
            local u27 = 0;
            local u28 = nil;
            u4:Connect(function() -- Line: 153
                -- upvalues: u27 (ref)
                u27 = u27 + 1;
            end);
            u28 = u4:Connect(function() -- Line: 156
                -- upvalues: u28 (ref), u27 (ref)
                u28:Disconnect();
                u27 = u27 + 1;
            end);
            u4:Connect(function() -- Line: 160
                -- upvalues: u27 (ref)
                u27 = u27 + 1;
            end);
            u4:Fire();
            expect(u27).to.equal(3);
        end);
        it("should still work if connections disconnected while firing deferred", function() -- Line: 167
            -- upvalues: u4 (ref), AwaitCondition (ref)
            local u29 = 0;
            local u30 = nil;
            u4:Connect(function() -- Line: 170
                -- upvalues: u29 (ref)
                u29 = u29 + 1;
            end);
            u30 = u4:Connect(function() -- Line: 173
                -- upvalues: u30 (ref), u29 (ref)
                u30:Disconnect();
                u29 = u29 + 1;
            end);
            u4:Connect(function() -- Line: 177
                -- upvalues: u29 (ref)
                u29 = u29 + 1;
            end);
            u4:FireDeferred();
            expect(AwaitCondition(function() -- Line: 181
                -- upvalues: u29 (ref)
                return u29 == 3;
            end)).to.equal(true);
        end);
    end);
end;