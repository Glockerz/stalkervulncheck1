-- Decompiled with Potassium's decompiler.

return function() -- Line: 1
    local script_Parent = require(script.Parent);
    script_Parent.TEST = true;
    local BindableEvent = Instance.new("BindableEvent");
    script_Parent._timeEvent = BindableEvent.Event;

    local function waitForEvents() -- Line: 8
        task.defer(coroutine.running());
        coroutine.yield();
    end;

    local u1 = 0;

    function script_Parent._getTime() -- Line: 16
        -- upvalues: u1 (ref)
        return u1;
    end;

    local function advanceTime(p2) -- Line: 20
        -- upvalues: u1 (ref), BindableEvent (copy)
        local v3 = p2 or 0.016666666666666666;
        u1 = u1 + v3;
        BindableEvent:Fire(v3);
        task.defer(coroutine.running());
        coroutine.yield();
    end;

    local function pack(...) -- Line: 29
        return select("#", ...), { ... };
    end;

    describe("Promise.Status", function() -- Line: 35
        -- upvalues: script_Parent (copy)
        it("should error if indexing nil value", function() -- Line: 36
            -- upvalues: script_Parent (ref)
            expect(function() -- Line: 37
                -- upvalues: script_Parent (ref)
                local _ = script_Parent.Status.wrong;
            end).to.throw();
        end);
    end);
    describe("Unhandled rejection signal", function() -- Line: 43
        -- upvalues: script_Parent (copy), advanceTime (ref)
        it("should call unhandled rejection callbacks", function() -- Line: 44
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local u6 = script_Parent.new(function(p4, p5) -- Line: 45
                p5(1, 2);
            end);
            local u7 = 0;
            local v11 = script_Parent.onUnhandledRejection(function(p8, p9, p10) -- Line: 51, Name: callback
                -- upvalues: u7 (ref), u6 (copy)
                u7 = u7 + 1;
                expect(p8).to.equal(u6);
                expect(p9).to.equal(1);
                expect(p10).to.equal(2);
            end);
            advanceTime();
            expect(u7).to.equal(1);
            v11();
            script_Parent.new(function(p12, p13) -- Line: 67
                p13(3, 4);
            end);
            advanceTime();
            expect(u7).to.equal(1);
        end);
    end);
    describe("Promise.new", function() -- Line: 77
        -- upvalues: script_Parent (copy)
        it("should instantiate with a callback", function() -- Line: 78
            -- upvalues: script_Parent (ref)
            local v14 = script_Parent.new(function() -- Line: 79
            end);
            expect(v14).to.be.ok();
        end);
        it("should invoke the given callback with resolve and reject", function() -- Line: 84
            -- upvalues: script_Parent (ref)
            local u15 = 0;
            local u16 = nil;
            local u17 = nil;
            local v20 = script_Parent.new(function(p18, p19) -- Line: 89
                -- upvalues: u15 (ref), u16 (ref), u17 (ref)
                u15 = u15 + 1;
                u16 = p18;
                u17 = p19;
            end);
            expect(v20).to.be.ok();
            expect(u15).to.equal(1);
            expect(u16).to.be.a("function");
            expect(u17).to.be.a("function");
            expect(v20:getStatus()).to.equal(script_Parent.Status.Started);
        end);
        it("should resolve promises on resolve()", function() -- Line: 103
            -- upvalues: script_Parent (ref)
            local u21 = 0;
            local v23 = script_Parent.new(function(p22) -- Line: 106
                -- upvalues: u21 (ref)
                u21 = u21 + 1;
                p22();
            end);
            expect(v23).to.be.ok();
            expect(u21).to.equal(1);
            expect(v23:getStatus()).to.equal(script_Parent.Status.Resolved);
        end);
        it("should reject promises on reject()", function() -- Line: 116
            -- upvalues: script_Parent (ref)
            local u24 = 0;
            local v27 = script_Parent.new(function(p25, p26) -- Line: 119
                -- upvalues: u24 (ref)
                u24 = u24 + 1;
                p26();
            end);
            expect(v27).to.be.ok();
            expect(u24).to.equal(1);
            expect(v27:getStatus()).to.equal(script_Parent.Status.Rejected);
        end);
        it("should reject on error in callback", function() -- Line: 129
            -- upvalues: script_Parent (ref)
            local u28 = 0;
            local v29 = script_Parent.new(function() -- Line: 132
                -- upvalues: u28 (ref)
                u28 = u28 + 1;
                error("hahah");
            end);
            expect(v29).to.be.ok();
            expect(u28).to.equal(1);
            expect(v29:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(tostring(v29._values[1]):find("hahah")).to.be.ok();
            expect(tostring(v29._values[1]):find("init.spec")).to.be.ok();
            expect(tostring(v29._values[1]):find("runExecutor")).to.be.ok();
        end);
        it("should work with C functions", function() -- Line: 147
            -- upvalues: script_Parent (ref)
            expect(function() -- Line: 148
                -- upvalues: script_Parent (ref)
                script_Parent.new(tick):andThen(tick);
            end).to.never.throw();
        end);
        it("should have a nice tostring", function() -- Line: 153
            -- upvalues: script_Parent (ref)
            expect(tostring(script_Parent.resolve()):gmatch("Promise(Resolved)")).to.be.ok();
        end);
        it("should allow yielding", function() -- Line: 157
            -- upvalues: script_Parent (ref)
            local BindableEvent2 = Instance.new("BindableEvent");
            local v31 = script_Parent.new(function(p30) -- Line: 159
                -- upvalues: BindableEvent2 (copy)
                BindableEvent2.Event:Wait();
                p30(5);
            end);
            expect(v31:getStatus()).to.equal(script_Parent.Status.Started);
            BindableEvent2:Fire();
            task.defer(coroutine.running());
            coroutine.yield();
            expect(v31:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v31._values[1]).to.equal(5);
        end);
        it("should preserve stack traces of resolve-chained promises", function() -- Line: 173
            -- upvalues: script_Parent (ref)
            local function nestedCall(p32) -- Line: 174
                error(p32);
            end;

            local v34 = script_Parent.new(function(p33) -- Line: 178
                -- upvalues: script_Parent (ref)
                p33(script_Parent.new(function() -- Line: 179
                    error("sample text");
                end));
            end);
            expect(v34:getStatus()).to.equal(script_Parent.Status.Rejected);
            local v35 = tostring(v34._values[1]);
            expect(v35:find("sample text")).to.be.ok();
            expect(v35:find("nestedCall")).to.be.ok();
            expect(v35:find("runExecutor")).to.be.ok();
            expect(v35:find("runPlanNode")).to.be.ok();
            expect(v35:find("...Rejected because it was chained to the following Promise, which encountered an error:")).to.be.ok();
        end);
        it("should report errors from Promises with _error (< v2)", function() -- Line: 196
            -- upvalues: script_Parent (ref)
            local v36 = script_Parent.reject();
            v36._error = "Sample error";
            local v37 = script_Parent.resolve():andThenReturn(v36);
            expect(v37:getStatus()).to.equal(script_Parent.Status.Rejected);
            local v38 = tostring(v37._values[1]);
            expect(v38:find("Sample error")).to.be.ok();
            expect(v38:find("...Rejected because it was chained to the following Promise, which encountered an error:")).to.be.ok();
            expect(v38:find("%[No stack trace available")).to.be.ok();
        end);
        it("should allow callable tables", function() -- Line: 212
            -- upvalues: script_Parent (ref)
            local v41 = script_Parent.new((setmetatable({}, {
                __call = function(p39, p40) -- Line: 214, Name: __call
                    p40(1);
                end
            })));
            local u42 = false;
            v41:andThen((setmetatable({}, {
                __call = function(p43, p44) -- Line: 221, Name: __call
                    -- upvalues: u42 (ref)
                    expect(p44).to.equal(1);
                    u42 = true;
                end
            })));
            expect(u42).to.equal(true);
        end);
        it("should close the thread after resolve", function() -- Line: 230
            -- upvalues: script_Parent (ref)
            local u45 = 0;
            script_Parent.new(function(p46) -- Line: 232
                -- upvalues: u45 (ref), script_Parent (ref)
                u45 = u45 + 1;
                p46();
                script_Parent.delay(1):await();
                u45 = u45 + 1;
            end);
            task.wait(1);
            expect(u45).to.equal(1);
        end);
    end);
    describe("Promise.defer", function() -- Line: 245
        -- upvalues: script_Parent (copy), advanceTime (ref)
        it("should execute after the time event", function() -- Line: 246
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local u47 = 0;
            local v52 = script_Parent.defer(function(p48, p49, p50, p51) -- Line: 248
                -- upvalues: u47 (ref)
                expect((type(p48))).to.equal("function");
                expect((type(p49))).to.equal("function");
                expect((type(p50))).to.equal("function");
                expect((type(p51))).to.equal("nil");
                u47 = u47 + 1;
                p48("foo");
            end);
            expect(u47).to.equal(0);
            expect(v52:getStatus()).to.equal(script_Parent.Status.Started);
            advanceTime();
            expect(u47).to.equal(1);
            expect(v52:getStatus()).to.equal(script_Parent.Status.Resolved);
            advanceTime();
            expect(u47).to.equal(1);
        end);
    end);
    describe("Promise.delay", function() -- Line: 271
        -- upvalues: script_Parent (copy), advanceTime (ref)
        it("should schedule promise resolution", function() -- Line: 272
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local v53 = script_Parent.delay(1);
            expect(v53:getStatus()).to.equal(script_Parent.Status.Started);
            advanceTime();
            expect(v53:getStatus()).to.equal(script_Parent.Status.Started);
            advanceTime(1);
            expect(v53:getStatus()).to.equal(script_Parent.Status.Resolved);
        end);
        it("should allow for delays to be cancelled", function() -- Line: 284
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local u54 = script_Parent.delay(2);
            script_Parent.delay(1):andThen(function() -- Line: 287
                -- upvalues: u54 (copy)
                u54:cancel();
            end);
            expect(u54:getStatus()).to.equal(script_Parent.Status.Started);
            advanceTime();
            expect(u54:getStatus()).to.equal(script_Parent.Status.Started);
            advanceTime(1);
            expect(u54:getStatus()).to.equal(script_Parent.Status.Cancelled);
            advanceTime(1);
        end);
    end);
    describe("Promise.resolve", function() -- Line: 300
        -- upvalues: script_Parent (copy)
        it("should immediately resolve with a value", function() -- Line: 301
            -- upvalues: script_Parent (ref)
            local v55 = script_Parent.resolve(5, 6);
            expect(v55).to.be.ok();
            expect(v55:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v55._values[1]).to.equal(5);
            expect(v55._values[2]).to.equal(6);
        end);
        it("should chain onto passed promises", function() -- Line: 310
            -- upvalues: script_Parent (ref)
            local v58 = script_Parent.resolve(script_Parent.new(function(p56, p57) -- Line: 311
                p57(7);
            end));
            expect(v58).to.be.ok();
            expect(v58:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v58._values[1]).to.equal(7);
        end);
    end);
    describe("Promise.reject", function() -- Line: 321
        -- upvalues: script_Parent (copy)
        it("should immediately reject with a value", function() -- Line: 322
            -- upvalues: script_Parent (ref)
            local v59 = script_Parent.reject(6, 7);
            expect(v59).to.be.ok();
            expect(v59:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v59._values[1]).to.equal(6);
            expect(v59._values[2]).to.equal(7);
        end);
        it("should pass a promise as-is as an error", function() -- Line: 331
            -- upvalues: script_Parent (ref)
            local v61 = script_Parent.new(function(p60) -- Line: 332
                p60(6);
            end);
            local v62 = script_Parent.reject(v61);
            expect(v62).to.be.ok();
            expect(v62:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v62._values[1]).to.equal(v61);
        end);
    end);
    describe("Promise:andThen", function() -- Line: 344
        -- upvalues: script_Parent (copy), pack (copy)
        it("should allow yielding", function() -- Line: 345
            -- upvalues: script_Parent (ref)
            local BindableEvent2 = Instance.new("BindableEvent");
            local v63 = script_Parent.resolve():andThen(function() -- Line: 347
                -- upvalues: BindableEvent2 (copy)
                BindableEvent2.Event:Wait();

                return 5;
            end);
            expect(v63:getStatus()).to.equal(script_Parent.Status.Started);
            BindableEvent2:Fire();
            task.defer(coroutine.running());
            coroutine.yield();
            expect(v63:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v63._values[1]).to.equal(5);
        end);
        it("should run andThens on a new thread", function() -- Line: 359
            -- upvalues: script_Parent (ref)
            local BindableEvent2 = Instance.new("BindableEvent");
            local u64 = nil;
            local v66 = script_Parent.new(function(p65) -- Line: 363
                -- upvalues: u64 (ref)
                u64 = p65;
            end);
            local v67 = v66:andThen(function() -- Line: 367
                -- upvalues: BindableEvent2 (copy)
                BindableEvent2.Event:Wait();

                return 5;
            end);
            local v68 = v66:andThen(function() -- Line: 372
                return "foo";
            end);
            expect(v66:getStatus()).to.equal(script_Parent.Status.Started);
            u64();
            expect(v68:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v68._values[1]).to.equal("foo");
            expect(v67:getStatus()).to.equal(script_Parent.Status.Started);
        end);
        it("should chain onto resolved promises", function() -- Line: 383
            -- upvalues: script_Parent (ref), pack (ref)
            local u69 = nil;
            local u70 = nil;
            local u71 = 0;
            local u72 = 0;
            local v73 = script_Parent.resolve(5);
            local v76 = v73:andThen(function(...) -- Line: 391
                -- upvalues: u70 (ref), u69 (ref), pack (ref), u71 (ref)
                local v74, v75 = pack(...);
                u70 = v74;
                u69 = v75;
                u71 = u71 + 1;
            end, function() -- Line: 394
                -- upvalues: u72 (ref)
                u72 = u72 + 1;
            end);
            expect(u72).to.equal(0);
            expect(u71).to.equal(1);
            expect(u70).to.equal(1);
            expect(u69[1]).to.equal(5);
            expect(v73).to.be.ok();
            expect(v73:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v73._values[1]).to.equal(5);
            expect(v76).to.be.ok();
            expect(v76).never.to.equal(v73);
            expect(v76:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(#v76._values).to.equal(0);
        end);
        it("should chain onto rejected promises", function() -- Line: 414
            -- upvalues: script_Parent (ref), pack (ref)
            local u77 = nil;
            local u78 = nil;
            local u79 = 0;
            local u80 = 0;
            local v81 = script_Parent.reject(5);
            local v84 = v81:andThen(function(...) -- Line: 422
                -- upvalues: u80 (ref)
                u80 = u80 + 1;
            end, function(...) -- Line: 424
                -- upvalues: u78 (ref), u77 (ref), pack (ref), u79 (ref)
                local v82, v83 = pack(...);
                u78 = v82;
                u77 = v83;
                u79 = u79 + 1;
            end);
            expect(u80).to.equal(0);
            expect(u79).to.equal(1);
            expect(u78).to.equal(1);
            expect(u77[1]).to.equal(5);
            expect(v81).to.be.ok();
            expect(v81:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v81._values[1]).to.equal(5);
            expect(v84).to.be.ok();
            expect(v84).never.to.equal(v81);
            expect(v84:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(#v84._values).to.equal(0);
        end);
        it("should reject on error in callback", function() -- Line: 445
            -- upvalues: script_Parent (ref)
            local u85 = 0;
            local v86 = script_Parent.resolve(1):andThen(function() -- Line: 448
                -- upvalues: u85 (ref)
                u85 = u85 + 1;
                error("hahah");
            end);
            expect(v86).to.be.ok();
            expect(u85).to.equal(1);
            expect(v86:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(tostring(v86._values[1]):find("hahah")).to.be.ok();
            expect(tostring(v86._values[1]):find("init.spec")).to.be.ok();
            expect(tostring(v86._values[1]):find("runExecutor")).to.be.ok();
        end);
        it("should chain onto asynchronously resolved promises", function() -- Line: 463
            -- upvalues: script_Parent (ref)
            local u87 = nil;
            local u88 = nil;
            local u89 = 0;
            local u90 = 0;
            local u91 = nil;
            local v93 = script_Parent.new(function(p92) -- Line: 470
                -- upvalues: u91 (ref)
                u91 = p92;
            end);
            local v94 = v93:andThen(function(...) -- Line: 474
                -- upvalues: u87 (ref), u88 (ref), u89 (ref)
                u87 = { ... };
                u88 = select("#", ...);
                u89 = u89 + 1;
            end, function() -- Line: 478
                -- upvalues: u90 (ref)
                u90 = u90 + 1;
            end);
            expect(u89).to.equal(0);
            expect(u90).to.equal(0);
            u91(6);
            expect(u90).to.equal(0);
            expect(u89).to.equal(1);
            expect(u88).to.equal(1);
            expect(u87[1]).to.equal(6);
            expect(v93).to.be.ok();
            expect(v93:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v93._values[1]).to.equal(6);
            expect(v94).to.be.ok();
            expect(v94).never.to.equal(v93);
            expect(v94:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(#v94._values).to.equal(0);
        end);
        it("should chain onto asynchronously rejected promises", function() -- Line: 503
            -- upvalues: script_Parent (ref)
            local u95 = nil;
            local u96 = nil;
            local u97 = 0;
            local u98 = 0;
            local u99 = nil;
            local v102 = script_Parent.new(function(p100, p101) -- Line: 510
                -- upvalues: u99 (ref)
                u99 = p101;
            end);
            local v103 = v102:andThen(function() -- Line: 514
                -- upvalues: u98 (ref)
                u98 = u98 + 1;
            end, function(...) -- Line: 516
                -- upvalues: u95 (ref), u96 (ref), u97 (ref)
                u95 = { ... };
                u96 = select("#", ...);
                u97 = u97 + 1;
            end);
            expect(u97).to.equal(0);
            expect(u98).to.equal(0);
            u99(6);
            expect(u98).to.equal(0);
            expect(u97).to.equal(1);
            expect(u96).to.equal(1);
            expect(u95[1]).to.equal(6);
            expect(v102).to.be.ok();
            expect(v102:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v102._values[1]).to.equal(6);
            expect(v103).to.be.ok();
            expect(v103).never.to.equal(v102);
            expect(v103:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(#v103._values).to.equal(0);
        end);
        it("should propagate errors through multiple levels", function() -- Line: 543
            -- upvalues: script_Parent (ref)
            local u104 = nil;
            local u105 = nil;
            local u106 = nil;
            script_Parent.new(function(p107, p108) -- Line: 545
                p108(1, 2, 3);
            end):andThen(function() -- Line: 547
            end):catch(function(p109, p110, p111) -- Line: 547
                -- upvalues: u104 (ref), u105 (ref), u106 (ref)
                u104 = p109;
                u105 = p110;
                u106 = p111;
            end);
            expect(u104).to.equal(1);
            expect(u105).to.equal(2);
            expect(u106).to.equal(3);
        end);
        itSKIP("should not call queued callbacks from a cancelled sub-promise", function() -- Line: 557
            -- upvalues: script_Parent (ref)
            local u112 = nil;
            local u113 = 0;
            local v115 = script_Parent.new(function(p114) -- Line: 561
                -- upvalues: u112 (ref)
                u112 = p114;
            end);
            v115:andThen(function() -- Line: 565
                -- upvalues: u113 (ref)
                u113 = u113 + 1;
            end);
            v115:andThen(function() -- Line: 570
                -- upvalues: u113 (ref)
                u113 = u113 + 1;
            end):cancel();
            u112("foo");
            expect(u113).to.equal(1);
        end);
    end);
    describe("Promise:cancel", function() -- Line: 581
        -- upvalues: script_Parent (copy), advanceTime (ref)
        it("should mark promises as cancelled and not resolve or reject them", function() -- Line: 582
            -- upvalues: script_Parent (ref)
            local u116 = 0;
            local u117 = 0;
            local v118 = script_Parent.new(function() -- Line: 585
            end):andThen(function() -- Line: 586
                -- upvalues: u116 (ref)
                u116 = u116 + 1;
            end):finally(function() -- Line: 589
                -- upvalues: u117 (ref)
                u117 = u117 + 1;
            end);
            v118:cancel();
            v118:cancel();
            expect(u116).to.equal(0);
            expect(u117).to.equal(1);
            expect(v118:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
        it("should call the cancellation hook once", function() -- Line: 601
            -- upvalues: script_Parent (ref)
            local u119 = 0;
            local v123 = script_Parent.new(function(p120, p121, p122) -- Line: 604
                -- upvalues: u119 (ref)
                p122(function() -- Line: 605
                    -- upvalues: u119 (ref)
                    u119 = u119 + 1;
                end);
            end);
            v123:cancel();
            v123:cancel();
            expect(u119).to.equal(1);
        end);
        it("should propagate cancellations", function() -- Line: 616
            -- upvalues: script_Parent (ref)
            local v124 = script_Parent.new(function() -- Line: 617
            end);
            local v125 = v124:andThen();
            local v126 = v124:andThen();
            expect(v124:getStatus()).to.equal(script_Parent.Status.Started);
            expect(v125:getStatus()).to.equal(script_Parent.Status.Started);
            expect(v126:getStatus()).to.equal(script_Parent.Status.Started);
            v125:cancel();
            expect(v124:getStatus()).to.equal(script_Parent.Status.Started);
            expect(v125:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v126:getStatus()).to.equal(script_Parent.Status.Started);
            v126:cancel();
            expect(v124:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v125:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v126:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
        it("should affect downstream promises", function() -- Line: 639
            -- upvalues: script_Parent (ref)
            local v127 = script_Parent.new(function() -- Line: 640
            end);
            local v128 = v127:andThen();
            v127:cancel();
            expect(v128:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
        it("should track consumers", function() -- Line: 648
            -- upvalues: script_Parent (ref)
            local u129 = script_Parent.new(function() -- Line: 649
            end);
            local v130 = script_Parent.resolve();
            local u131 = v130:andThen(function() -- Line: 651
                -- upvalues: u129 (copy)
                return u129;
            end);
            local v133 = script_Parent.new(function(p132) -- Line: 654
                -- upvalues: u131 (copy)
                p132(u131);
            end);
            local v134 = v133:andThen(function() -- Line: 657
            end);
            expect(u131._parent).to.never.equal(v130);
            expect(v133._parent).to.never.equal(u131);
            expect(v133._consumers[v134]).to.be.ok();
            expect(v134._parent).to.equal(v133);
        end);
        it("should cancel resolved pending promises", function() -- Line: 665
            -- upvalues: script_Parent (ref)
            local u135 = script_Parent.new(function() -- Line: 666
            end);
            local v137 = script_Parent.new(function(p136) -- Line: 668
                -- upvalues: u135 (copy)
                p136(u135);
            end):finally(function() -- Line: 670
            end);
            v137:cancel();
            expect(u135._status).to.equal(script_Parent.Status.Cancelled);
            expect(v137._status).to.equal(script_Parent.Status.Cancelled);
        end);
        it("should close the promise thread", function() -- Line: 678
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local u138 = 0;
            script_Parent.new(function() -- Line: 680
                -- upvalues: u138 (ref), script_Parent (ref)
                u138 = u138 + 1;
                script_Parent.delay(1):await();
                u138 = u138 + 1;
            end):cancel();
            advanceTime(2);
            expect(u138).to.equal(1);
        end);
    end);
    describe("Promise:finally", function() -- Line: 693
        -- upvalues: script_Parent (copy)
        it("should be called upon resolve, reject, or cancel", function() -- Line: 694
            -- upvalues: script_Parent (ref)
            local u139 = 0;

            local function finally() -- Line: 697
                -- upvalues: u139 (ref)
                u139 = u139 + 1;
            end;

            script_Parent.new(function(p140, p141) -- Line: 702
                p140();
            end):finally(finally);
            script_Parent.resolve():andThen(function() -- Line: 707
            end):finally(finally):finally(finally);
            script_Parent.reject():finally(finally);
            script_Parent.new(function() -- Line: 712
            end):finally(finally):cancel();
            expect(u139).to.equal(5);
        end);
        itSKIP("should not forward return values", function() -- Line: 719
            -- upvalues: script_Parent (ref)
            local u142 = nil;
            script_Parent.resolve(2):finally(function() -- Line: 723
                return 1;
            end):andThen(function(p143) -- Line: 726
                -- upvalues: u142 (ref)
                u142 = p143;
            end);
            expect(u142).to.equal(2);
        end);
        itSKIP("should not consume rejections", function() -- Line: 734
            -- upvalues: script_Parent (ref)
            local u144 = false;
            local u145 = false;
            script_Parent.reject(5):finally(function() -- Line: 738
                return 42;
            end):andThen(function() -- Line: 741
                -- upvalues: u145 (ref)
                u145 = true;
            end):catch(function(p146) -- Line: 744
                -- upvalues: u144 (ref)
                u144 = true;
                expect(p146).to.equal(5);
            end);
            expect(u144).to.equal(true);
            expect(u145).to.equal(false);
        end);
        itSKIP("should wait for returned promises", function() -- Line: 754
            -- upvalues: script_Parent (ref)
            local u147 = nil;
            local v149 = script_Parent.reject("foo"):finally(function() -- Line: 756
                -- upvalues: script_Parent (ref), u147 (ref)
                return script_Parent.new(function(p148) -- Line: 757
                    -- upvalues: u147 (ref)
                    u147 = p148;
                end);
            end);
            expect(v149:getStatus()).to.equal(script_Parent.Status.Started);
            u147();
            expect(v149:getStatus()).to.equal(script_Parent.Status.Rejected);
            local _, v150 = v149:_unwrap();
            expect(v150).to.equal("foo");
        end);
        it("should reject with a returned rejected promise\'s value", function() -- Line: 771
            -- upvalues: script_Parent (ref)
            local u151 = nil;
            local v154 = script_Parent.reject("foo"):finally(function() -- Line: 773
                -- upvalues: script_Parent (ref), u151 (ref)
                return script_Parent.new(function(p152, p153) -- Line: 774
                    -- upvalues: u151 (ref)
                    u151 = p153;
                end);
            end);
            expect(v154:getStatus()).to.equal(script_Parent.Status.Started);
            u151("bar");
            expect(v154:getStatus()).to.equal(script_Parent.Status.Rejected);
            local _, v155 = v154:_unwrap();
            expect(v155).to.equal("bar");
        end);
        it("should reject when handler errors", function() -- Line: 788
            -- upvalues: script_Parent (ref)
            local u156 = {};
            local v157, v158 = script_Parent.reject("bar"):finally(function() -- Line: 790
                -- upvalues: u156 (copy)
                error(u156);
            end):_unwrap();
            expect(v157).to.equal(false);
            expect(v158).to.equal(u156);
        end);
        itSKIP("should not prevent cancellation", function() -- Line: 801
            -- upvalues: script_Parent (ref)
            local v159 = script_Parent.new(function() -- Line: 802
            end);
            local u160 = false;
            v159:finally(function() -- Line: 805
                -- upvalues: u160 (ref)
                u160 = true;
            end);
            v159:andThen(function() -- Line: 809
            end):cancel();
            expect(v159:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(u160).to.equal(true);
        end);
        it("should propagate cancellation downwards", function() -- Line: 817
            -- upvalues: script_Parent (ref)
            local u161 = false;
            local v162 = script_Parent.new(function() -- Line: 820
            end);
            local v163 = v162:finally(function() -- Line: 822
                -- upvalues: u161 (ref)
                u161 = true;
            end);
            v162:cancel();
            expect(v162:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v163:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(u161).to.equal(true);
            expect(false).to.equal(false);
        end);
        it("should propagate cancellation upwards", function() -- Line: 835
            -- upvalues: script_Parent (ref)
            local u164 = false;
            local v165 = script_Parent.new(function() -- Line: 838
            end);
            local v166 = v165:finally(function() -- Line: 840
                -- upvalues: u164 (ref)
                u164 = true;
            end);
            v166:cancel();
            expect(v165:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v166:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(u164).to.equal(true);
            expect(false).to.equal(false);
        end);
        it("should cancel returned promise if cancelled", function() -- Line: 853
            -- upvalues: script_Parent (ref)
            local u167 = script_Parent.new(function() -- Line: 854
            end);
            script_Parent.resolve():finally(function() -- Line: 856
                -- upvalues: u167 (copy)
                return u167;
            end):cancel();
            expect(u167:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
    end);
    describe("Promise.all", function() -- Line: 866
        -- upvalues: script_Parent (copy), pack (copy)
        it("should error if given something other than a table", function() -- Line: 867
            -- upvalues: script_Parent (ref)
            expect(function() -- Line: 868
                -- upvalues: script_Parent (ref)
                script_Parent.all(1);
            end).to.throw();
        end);
        it("should resolve instantly with an empty table if given no promises", function() -- Line: 873
            -- upvalues: script_Parent (ref)
            local v168 = script_Parent.all({});
            local v169, v170 = v168:_unwrap();
            expect(v169).to.equal(true);
            expect(v168:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v170).to.be.a("table");
            expect(next(v170)).to.equal(nil);
        end);
        it("should error if given non-promise values", function() -- Line: 883
            -- upvalues: script_Parent (ref)
            expect(function() -- Line: 884
                -- upvalues: script_Parent (ref)
                script_Parent.all({ {}, {}, {} });
            end).to.throw();
        end);
        it("should wait for all promises to be resolved and return their values", function() -- Line: 889
            -- upvalues: pack (ref), script_Parent (ref)
            local v171, u172 = pack(1, "A string", nil, false);
            local u173 = {};
            local v174 = {};

            for i = 1, v171 do
                v174[i] = script_Parent.new(function(p175) -- Line: 897
                    -- upvalues: u173 (copy), i (copy), u172 (copy)
                    u173[i] = { p175, u172[i] };
                end);
                local _ = i;
            end;

            local v176 = script_Parent.all(v174);

            for _, v in ipairs(u173) do
                expect(v176:getStatus()).to.equal(script_Parent.Status.Started);
                v[1](v[2]);
            end;

            local v177, v178 = pack(v176:_unwrap());
            local v179, v180 = unpack(v178, 1, v177);
            expect(v177).to.equal(2);
            expect(v179).to.equal(true);
            expect(v180).to.be.a("table");
            expect(#v180).to.equal(#v174);

            for i = 1, v171 do
                expect(v180[i]).to.equal(u172[i]);
                local _ = i;
            end;
        end);
        it("should reject if any individual promise rejected", function() -- Line: 922
            -- upvalues: script_Parent (ref), pack (ref)
            local u181 = nil;
            local u182 = nil;
            local v185 = script_Parent.new(function(p183, p184) -- Line: 926
                -- upvalues: u181 (ref)
                u181 = p184;
            end);
            local v187 = script_Parent.new(function(p186) -- Line: 930
                -- upvalues: u182 (ref)
                u182 = p186;
            end);
            local v188 = script_Parent.all({ v185, v187 });
            expect(v188:getStatus()).to.equal(script_Parent.Status.Started);
            u181("baz", "qux");
            u182("foo", "bar");
            local v189, v190 = pack(v188:_unwrap());
            local v191, v192, v193 = unpack(v190, 1, v189);
            expect(v189).to.equal(3);
            expect(v191).to.equal(false);
            expect(v192).to.equal("baz");
            expect(v193).to.equal("qux");
            expect(v187:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
        it("should not resolve if resolved after rejecting", function() -- Line: 951
            -- upvalues: script_Parent (ref), pack (ref)
            local u194 = nil;
            local u195 = nil;
            local v199 = { script_Parent.new(function(p196, p197) -- Line: 955
                    -- upvalues: u194 (ref)
                    u194 = p197;
                end), (script_Parent.new(function(p198) -- Line: 959
                    -- upvalues: u195 (ref)
                    u195 = p198;
                end)) };
            local v200 = script_Parent.all(v199);
            expect(v200:getStatus()).to.equal(script_Parent.Status.Started);
            u194("baz", "qux");
            u195("foo", "bar");
            local v201, v202 = pack(v200:_unwrap());
            local v203, v204, v205 = unpack(v202, 1, v201);
            expect(v201).to.equal(3);
            expect(v203).to.equal(false);
            expect(v204).to.equal("baz");
            expect(v205).to.equal("qux");
        end);
        it("should only reject once", function() -- Line: 979
            -- upvalues: script_Parent (ref), pack (ref)
            local u206 = nil;
            local u207 = nil;
            local v212 = { script_Parent.new(function(p208, p209) -- Line: 983
                    -- upvalues: u206 (ref)
                    u206 = p209;
                end), (script_Parent.new(function(p210, p211) -- Line: 987
                    -- upvalues: u207 (ref)
                    u207 = p211;
                end)) };
            local v213 = script_Parent.all(v212);
            expect(v213:getStatus()).to.equal(script_Parent.Status.Started);
            u206("foo", "bar");
            expect(v213:getStatus()).to.equal(script_Parent.Status.Rejected);
            u207("baz", "qux");
            local v214, v215 = pack(v213:_unwrap());
            local v216, v217, v218 = unpack(v215, 1, v214);
            expect(v214).to.equal(3);
            expect(v216).to.equal(false);
            expect(v217).to.equal("foo");
            expect(v218).to.equal("bar");
        end);
        itSKIP("should error if a non-array table is passed in", function() -- Line: 1011
            -- upvalues: script_Parent (ref)
            local success, result = pcall(function() -- Line: 1012
                -- upvalues: script_Parent (ref)
                script_Parent.all(script_Parent.new(function() -- Line: 1013
                end));
            end);
            expect(success).to.be.ok();
            expect(result:find("Non%-promise")).to.be.ok();
        end);
        it("should cancel pending promises if one rejects", function() -- Line: 1020
            -- upvalues: script_Parent (ref)
            local v219 = script_Parent.new(function() -- Line: 1021
            end);
            expect(script_Parent.all({ script_Parent.resolve(), script_Parent.reject(), v219 }):getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v219:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
        it("should cancel promises if it is cancelled", function() -- Line: 1030
            -- upvalues: script_Parent (ref)
            local v220 = script_Parent.new(function() -- Line: 1031
            end);
            v220:andThen(function() -- Line: 1032
            end);
            local v221 = { script_Parent.new(function() -- Line: 1035
                end), script_Parent.new(function() -- Line: 1036
                end), v220 };
            script_Parent.all(v221):cancel();
            expect(v221[1]:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v221[2]:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v221[3]:getStatus()).to.equal(script_Parent.Status.Started);
        end);
    end);
    describe("Promise.fold", function() -- Line: 1048
        -- upvalues: script_Parent (copy), advanceTime (ref)
        it("should return the initial value in a promise when the list is empty", function() -- Line: 1049
            -- upvalues: script_Parent (ref)
            local v222 = {};
            local v223 = script_Parent.fold({}, function() -- Line: 1051
                error("should not be called");
            end, v222);
            expect(script_Parent.is(v223)).to.equal(true);
            expect(v223:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v223:expect()).to.equal(v222);
        end);
        it("should accept promises in the list", function() -- Line: 1060
            -- upvalues: script_Parent (ref)
            local u224 = nil;
            local v228 = script_Parent.fold({ script_Parent.new(function(p225) -- Line: 1063
                    -- upvalues: u224 (ref)
                    u224 = p225;
                end), 2, 3 }, function(p226, p227) -- Line: 1065
                return p226 + p227;
            end, 0);
            u224(1);
            expect(script_Parent.is(v228)).to.equal(true);
            expect(v228:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v228:expect()).to.equal(6);
        end);
        it("should always return a promise even if the list or reducer don\'t use them", function() -- Line: 1076
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local v232 = script_Parent.fold({ 1, 2, 3 }, function(p229, p230, p231) -- Line: 1077
                -- upvalues: script_Parent (ref)
                if p231 == 2 then
                    return script_Parent.delay(1):andThenReturn(p229 + p230);
                end;

                return p229 + p230;
            end, 0);
            expect(script_Parent.is(v232)).to.equal(true);
            expect(v232:getStatus()).to.equal(script_Parent.Status.Started);
            advanceTime(2);
            expect(v232:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v232:expect()).to.equal(6);
        end);
        it("should return the first rejected promise", function() -- Line: 1091
            -- upvalues: script_Parent (ref)
            local v236 = script_Parent.fold({ 1, 2, 3 }, function(p233, p234, p235) -- Line: 1093
                -- upvalues: script_Parent (ref)
                if p235 == 2 then
                    return script_Parent.reject("foo");
                end;

                return p233 + p234;
            end, 0);
            expect(script_Parent.is(v236)).to.equal(true);
            local v237, v238 = v236:awaitStatus();
            expect(v237).to.equal(script_Parent.Status.Rejected);
            expect(v238).to.equal("foo");
        end);
        it("should return the first canceled promise", function() -- Line: 1106
            -- upvalues: script_Parent (ref)
            local u239 = nil;
            local v243 = script_Parent.fold({ 1, 2, 3 }, function(p240, p241, p242) -- Line: 1108
                -- upvalues: u239 (ref), script_Parent (ref)
                if p242 == 1 then
                    return p240 + p241;
                end;

                if p242 == 2 then
                    u239 = script_Parent.delay(1):andThenReturn(p240 + p241);

                    return u239;
                end;

                error("this should not run if the promise is cancelled");
            end, 0);
            expect(script_Parent.is(v243)).to.equal(true);
            expect(v243:getStatus()).to.equal(script_Parent.Status.Started);
            u239:cancel();
            expect(v243:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
    end);
    describe("Promise.race", function() -- Line: 1125
        -- upvalues: script_Parent (copy)
        it("should resolve with the first settled value", function() -- Line: 1126
            -- upvalues: script_Parent (ref)
            local v245 = script_Parent.race({ script_Parent.resolve(1), script_Parent.resolve(2) }):andThen(function(p244) -- Line: 1130
                expect(p244).to.equal(1);
            end);
            expect(v245:getStatus()).to.equal(script_Parent.Status.Resolved);
        end);
        it("should cancel other promises", function() -- Line: 1137
            -- upvalues: script_Parent (ref)
            local v246 = script_Parent.new(function() -- Line: 1138
            end);
            v246:andThen(function() -- Line: 1139
            end);
            local v248 = { v246, script_Parent.new(function() -- Line: 1142
                end), script_Parent.new(function(p247) -- Line: 1143
                    p247(2);
                end) };
            local v249 = script_Parent.race(v248);
            expect(v249:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v249._values[1]).to.equal(2);
            expect(v248[1]:getStatus()).to.equal(script_Parent.Status.Started);
            expect(v248[2]:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v248[3]:getStatus()).to.equal(script_Parent.Status.Resolved);
            local v250 = script_Parent.new(function() -- Line: 1156
            end);
            expect(script_Parent.race({ script_Parent.reject(), script_Parent.resolve(), v250 }):getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v250:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
        it("should error if a non-array table is passed in", function() -- Line: 1165
            -- upvalues: script_Parent (ref)
            local success, result = pcall(function() -- Line: 1166
                -- upvalues: script_Parent (ref)
                script_Parent.race(script_Parent.new(function() -- Line: 1167
                end));
            end);
            expect(success).to.be.ok();
            expect(result:find("Non%-promise")).to.be.ok();
        end);
        it("should cancel promises if it is cancelled", function() -- Line: 1174
            -- upvalues: script_Parent (ref)
            local v251 = script_Parent.new(function() -- Line: 1175
            end);
            v251:andThen(function() -- Line: 1176
            end);
            local v252 = { script_Parent.new(function() -- Line: 1179
                end), script_Parent.new(function() -- Line: 1180
                end), v251 };
            script_Parent.race(v252):cancel();
            expect(v252[1]:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v252[2]:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v252[3]:getStatus()).to.equal(script_Parent.Status.Started);
        end);
    end);
    describe("Promise.promisify", function() -- Line: 1192
        -- upvalues: script_Parent (copy)
        it("should wrap functions", function() -- Line: 1193
            -- upvalues: script_Parent (ref)
            local v254 = script_Parent.promisify(function(p253) -- Line: 1194, Name: test
                return p253 + 1;
            end)(1);
            local v255, v256 = v254:_unwrap();
            expect(v255).to.equal(true);
            expect(v254:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v256).to.equal(2);
        end);
        it("should catch errors after a yield", function() -- Line: 1207
            -- upvalues: script_Parent (ref)
            local BindableEvent2 = Instance.new("BindableEvent");
            local v257 = script_Parent.promisify(function() -- Line: 1209
                -- upvalues: BindableEvent2 (copy)
                BindableEvent2.Event:Wait();
                error("errortext");
            end)();
            expect(v257:getStatus()).to.equal(script_Parent.Status.Started);
            BindableEvent2:Fire();
            task.defer(coroutine.running());
            coroutine.yield();
            expect(v257:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(tostring(v257._values[1]):find("errortext")).to.be.ok();
        end);
    end);
    describe("Promise.tap", function() -- Line: 1224
        -- upvalues: script_Parent (copy)
        it("should thread through values", function() -- Line: 1225
            -- upvalues: script_Parent (ref)
            local u258 = nil;
            local u259 = nil;
            script_Parent.resolve(1):andThen(function(p260) -- Line: 1229
                return p260 + 1;
            end):tap(function(p261) -- Line: 1232
                -- upvalues: u258 (ref)
                u258 = p261;

                return p261 + 1;
            end):andThen(function(p262) -- Line: 1236
                -- upvalues: u259 (ref)
                u259 = p262;
            end);
            expect(u258).to.equal(2);
            expect(u259).to.equal(2);
        end);
        it("should chain onto promises", function() -- Line: 1244
            -- upvalues: script_Parent (ref)
            local u263 = nil;
            local u264 = nil;
            local v267 = script_Parent.resolve(1):tap(function() -- Line: 1248
                -- upvalues: script_Parent (ref), u263 (ref)
                return script_Parent.new(function(p265) -- Line: 1249
                    -- upvalues: u263 (ref)
                    u263 = p265;
                end);
            end):andThen(function(p266) -- Line: 1253
                -- upvalues: u264 (ref)
                u264 = p266;
            end);
            expect(v267:getStatus()).to.equal(script_Parent.Status.Started);
            expect(u264).to.never.be.ok();
            u263(1);
            expect(v267:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(u264).to.equal(1);
        end);
    end);
    describe("Promise.try", function() -- Line: 1267
        -- upvalues: script_Parent (copy)
        it("should catch synchronous errors", function() -- Line: 1268
            -- upvalues: script_Parent (ref)
            local u268 = nil;
            script_Parent.try(function() -- Line: 1270
                error("errortext");
            end):catch(function(p269) -- Line: 1272
                -- upvalues: u268 (ref)
                u268 = tostring(p269);
            end);
            expect(u268:find("errortext")).to.be.ok();
        end);
        it("should reject with error objects", function() -- Line: 1279
            -- upvalues: script_Parent (ref)
            local u270 = {};
            local v271, v272 = script_Parent.try(function() -- Line: 1281
                -- upvalues: u270 (copy)
                error(u270);
            end):_unwrap();
            expect(v271).to.equal(false);
            expect(v272).to.equal(u270);
        end);
        it("should catch asynchronous errors", function() -- Line: 1289
            -- upvalues: script_Parent (ref)
            local BindableEvent2 = Instance.new("BindableEvent");
            local v273 = script_Parent.try(function() -- Line: 1291
                -- upvalues: BindableEvent2 (copy)
                BindableEvent2.Event:Wait();
                error("errortext");
            end);
            expect(v273:getStatus()).to.equal(script_Parent.Status.Started);
            BindableEvent2:Fire();
            task.defer(coroutine.running());
            coroutine.yield();
            expect(v273:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(tostring(v273._values[1]):find("errortext")).to.be.ok();
        end);
    end);
    describe("Promise:andThenReturn", function() -- Line: 1304
        -- upvalues: script_Parent (copy)
        it("should return the given values", function() -- Line: 1305
            -- upvalues: script_Parent (ref)
            local u274 = nil;
            local u275 = nil;
            script_Parent.resolve():andThenReturn(1, 2):andThen(function(p276, p277) -- Line: 1308
                -- upvalues: u274 (ref), u275 (ref)
                u274 = p276;
                u275 = p277;
            end);
            expect(u274).to.equal(1);
            expect(u275).to.equal(2);
        end);
    end);
    describe("Promise:doneReturn", function() -- Line: 1318
        -- upvalues: script_Parent (copy)
        it("should return the given values", function() -- Line: 1319
            -- upvalues: script_Parent (ref)
            local u278 = nil;
            local u279 = nil;
            script_Parent.resolve():doneReturn(1, 2):andThen(function(p280, p281) -- Line: 1322
                -- upvalues: u278 (ref), u279 (ref)
                u278 = p280;
                u279 = p281;
            end);
            expect(u278).to.equal(1);
            expect(u279).to.equal(2);
        end);
    end);
    describe("Promise:andThenCall", function() -- Line: 1332
        -- upvalues: script_Parent (copy)
        it("should call the given function with arguments", function() -- Line: 1333
            -- upvalues: script_Parent (ref)
            local u282 = nil;
            local u283 = nil;
            script_Parent.resolve():andThenCall(function(p284, p285) -- Line: 1335
                -- upvalues: u282 (ref), u283 (ref)
                u282 = p284;
                u283 = p285;
            end, 3, 4);
            expect(u282).to.equal(3);
            expect(u283).to.equal(4);
        end);
    end);
    describe("Promise:andThenAsync", function() -- Line: 1345
        -- upvalues: script_Parent (copy), advanceTime (ref), pack (copy)
        it("should allow yielding", function() -- Line: 1346
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local BindableEvent2 = Instance.new("BindableEvent");
            local v286 = script_Parent.fromEvent(BindableEvent2.Event):andThenAsync(function() -- Line: 1348
                return 5;
            end);
            expect(v286:getStatus()).to.equal(script_Parent.Status.Started);
            BindableEvent2:Fire();
            expect(v286:getStatus()).to.equal(script_Parent.Status.Started);
            advanceTime();
            expect(v286:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v286._values[1]).to.equal(5);
        end);
        it("should run andThenAsync on a new thread", function() -- Line: 1362
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local BindableEvent2 = Instance.new("BindableEvent");
            local u287 = nil;
            local v289 = script_Parent.new(function(p288) -- Line: 1366
                -- upvalues: u287 (ref)
                u287 = p288;
            end);
            local v290 = v289:andThenAsync(function() -- Line: 1370
                -- upvalues: BindableEvent2 (copy)
                BindableEvent2.Event:Wait();

                return 5;
            end);
            local v291 = v289:andThenAsync(function() -- Line: 1375
                return "foo";
            end);
            expect(v289:getStatus()).to.equal(script_Parent.Status.Started);
            u287();
            expect(v291:getStatus()).to.equal(script_Parent.Status.Started);
            expect(v290:getStatus()).to.equal(script_Parent.Status.Started);
            advanceTime();
            expect(v291:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v291._values[1]).to.equal("foo");
            expect(v290:getStatus()).to.equal(script_Parent.Status.Started);
        end);
        it("should chain onto resolved promises", function() -- Line: 1392
            -- upvalues: script_Parent (ref), pack (ref), advanceTime (ref)
            local u292 = nil;
            local u293 = nil;
            local u294 = 0;
            local u295 = 0;
            local v296 = script_Parent.resolve(5);
            local v299 = v296:andThenAsync(function(...) -- Line: 1400
                -- upvalues: u293 (ref), u292 (ref), pack (ref), u294 (ref)
                local v297, v298 = pack(...);
                u293 = v297;
                u292 = v298;
                u294 = u294 + 1;
            end, function() -- Line: 1403
                -- upvalues: u295 (ref)
                u295 = u295 + 1;
            end);
            expect(u295).to.equal(0);
            expect(u294).to.equal(0);
            expect(v299).to.be.ok();
            expect(v299).never.to.equal(v296);
            expect(v299:getStatus()).to.equal(script_Parent.Status.Started);
            expect(v296).to.be.ok();
            expect(v296:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v296._values[1]).to.equal(5);
            advanceTime();
            expect(u294).to.equal(1);
            expect(u293).to.equal(1);
            expect(u292[1]).to.equal(5);
            expect(v299:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(#v299._values).to.equal(0);
        end);
        it("should chain onto rejected promises", function() -- Line: 1428
            -- upvalues: script_Parent (ref), pack (ref), advanceTime (ref)
            local u300 = nil;
            local u301 = nil;
            local u302 = 0;
            local u303 = 0;
            local v304 = script_Parent.reject(5);
            local v307 = v304:andThenAsync(function(...) -- Line: 1436
                -- upvalues: u303 (ref)
                u303 = u303 + 1;
            end, function(...) -- Line: 1438
                -- upvalues: u301 (ref), u300 (ref), pack (ref), u302 (ref)
                local v305, v306 = pack(...);
                u301 = v305;
                u300 = v306;
                u302 = u302 + 1;
            end);
            expect(u303).to.equal(0);
            expect(u302).to.equal(0);
            expect(v304).to.be.ok();
            expect(v304:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v304._values[1]).to.equal(5);
            expect(v307).to.be.ok();
            expect(v307).never.to.equal(v304);
            expect(v307:getStatus()).to.equal(script_Parent.Status.Started);
            advanceTime();
            expect(u302).to.equal(1);
            expect(u301).to.equal(1);
            expect(u300[1]).to.equal(5);
            expect(v307:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(#v307._values).to.equal(0);
        end);
        it("should reject on error in callback", function() -- Line: 1465
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local u308 = 0;
            local v309 = script_Parent.resolve(1):andThenAsync(function() -- Line: 1468
                -- upvalues: u308 (ref)
                u308 = u308 + 1;
                error("hahah");
            end);
            expect(v309).to.be.ok();
            expect(v309:getStatus()).to.equal(script_Parent.Status.Started);
            expect(u308).to.equal(0);
            advanceTime();
            expect(u308).to.equal(1);
            expect(v309:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(tostring(v309._values[1]):find("hahah")).to.be.ok();
            expect(tostring(v309._values[1]):find("init.spec")).to.be.ok();
            expect(tostring(v309._values[1]):find("runExecutor")).to.be.ok();
        end);
        it("should chain onto asynchronously resolved promises", function() -- Line: 1488
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local u310 = nil;
            local u311 = nil;
            local u312 = 0;
            local u313 = 0;
            local u314 = nil;
            local v316 = script_Parent.new(function(p315) -- Line: 1495
                -- upvalues: u314 (ref)
                u314 = p315;
            end);
            local v317 = v316:andThenAsync(function(...) -- Line: 1499
                -- upvalues: u310 (ref), u311 (ref), u312 (ref)
                u310 = { ... };
                u311 = select("#", ...);
                u312 = u312 + 1;
            end, function() -- Line: 1503
                -- upvalues: u313 (ref)
                u313 = u313 + 1;
            end);
            expect(u312).to.equal(0);
            expect(u313).to.equal(0);
            u314(6);
            expect(u312).to.equal(0);
            expect(u313).to.equal(0);
            expect(v316).to.be.ok();
            expect(v316:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v317).to.be.ok();
            expect(v317).never.to.equal(v316);
            expect(v317:getStatus()).to.equal(script_Parent.Status.Started);
            advanceTime();
            expect(u313).to.equal(0);
            expect(u312).to.equal(1);
            expect(u311).to.equal(1);
            expect(u310[1]).to.equal(6);
            expect(v316:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v316._values[1]).to.equal(6);
            expect(v317:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(#v317._values).to.equal(0);
        end);
        it("should chain onto asynchronously rejected promises", function() -- Line: 1537
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local u318 = nil;
            local u319 = nil;
            local u320 = 0;
            local u321 = 0;
            local u322 = nil;
            local v325 = script_Parent.new(function(p323, p324) -- Line: 1544
                -- upvalues: u322 (ref)
                u322 = p324;
            end);
            local v326 = v325:andThenAsync(function() -- Line: 1548
                -- upvalues: u321 (ref)
                u321 = u321 + 1;
            end, function(...) -- Line: 1550
                -- upvalues: u318 (ref), u319 (ref), u320 (ref)
                u318 = { ... };
                u319 = select("#", ...);
                u320 = u320 + 1;
            end);
            expect(u320).to.equal(0);
            expect(u321).to.equal(0);
            u322(6);
            expect(u320).to.equal(0);
            expect(u321).to.equal(0);
            expect(v325).to.be.ok();
            expect(v325:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v326).to.be.ok();
            expect(v326).never.to.equal(v325);
            expect(v326:getStatus()).to.equal(script_Parent.Status.Started);
            advanceTime();
            expect(u321).to.equal(0);
            expect(u320).to.equal(1);
            expect(u319).to.equal(1);
            expect(u318[1]).to.equal(6);
            expect(v326:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v325._values[1]).to.equal(6);
            expect(#v326._values).to.equal(0);
        end);
        it("should propagate errors through multiple levels", function() -- Line: 1584
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local u327 = nil;
            local u328 = nil;
            local u329 = nil;
            script_Parent.new(function(p330, p331) -- Line: 1586
                p331(1, 2, 3);
            end):andThenAsync(function() -- Line: 1588
            end):catch(function(p332, p333, p334) -- Line: 1588
                -- upvalues: u327 (ref), u328 (ref), u329 (ref)
                u327 = p332;
                u328 = p333;
                u329 = p334;
            end);
            expect(u327).to.equal(nil);
            expect(u328).to.equal(nil);
            expect(u329).to.equal(nil);
            advanceTime();
            expect(u327).to.equal(1);
            expect(u328).to.equal(2);
            expect(u329).to.equal(3);
        end);
        it("should propagate errors asynchronously through multiple levels", function() -- Line: 1603
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local u335 = nil;
            local u336 = nil;
            local u337 = nil;

            local function handleErrors(p338, p339, p340) -- Line: 1606
                -- upvalues: u335 (ref), u336 (ref), u337 (ref), script_Parent (ref)
                u335 = p338;
                u336 = p339;
                u337 = p340;

                return script_Parent.reject(p338 * 10, p339 * 10, p340 * 10);
            end;

            script_Parent.new(function(p341, p342) -- Line: 1610
                p342(1, 2, 3);
            end):andThenAsync(function() -- Line: 1613
            end, handleErrors):andThenAsync(function() -- Line: 1614
            end, handleErrors):andThenAsync(function() -- Line: 1615
            end, handleErrors):catch(function(p343, p344, p345) -- Line: 1616
                -- upvalues: u335 (ref), u336 (ref), u337 (ref)
                local v346 = "caught " .. tostring(p343);
                local v347 = "caught " .. tostring(p344);
                local v348 = "caught " .. tostring(p345);
                u335 = v346;
                u336 = v347;
                u337 = v348;
            end);
            expect(u335).to.equal(nil);
            expect(u336).to.equal(nil);
            expect(u337).to.equal(nil);
            advanceTime();
            expect(u335).to.equal(1);
            expect(u336).to.equal(2);
            expect(u337).to.equal(3);
            advanceTime();
            expect(u335).to.equal(10);
            expect(u336).to.equal(20);
            expect(u337).to.equal(30);
            advanceTime();
            expect(u335).to.equal("caught 1000");
            expect(u336).to.equal("caught 2000");
            expect(u337).to.equal("caught 3000");
        end);
        it("should NOT propagate errors if error handler is provided", function() -- Line: 1644
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local u349 = nil;
            local u350 = nil;
            local u351 = nil;
            script_Parent.new(function(p352, p353) -- Line: 1646
                p353(1, 2, 3);
            end):andThenAsync(function() -- Line: 1648
            end, function() -- Line: 1648
            end):catch(function(p354, p355, p356) -- Line: 1648
                -- upvalues: u349 (ref), u350 (ref), u351 (ref)
                u349 = p354;
                u350 = p355;
                u351 = p356;
            end);
            expect(u349).to.equal(nil);
            expect(u350).to.equal(nil);
            expect(u351).to.equal(nil);
            advanceTime();
            expect(u349).to.equal(nil);
            expect(u350).to.equal(nil);
            expect(u351).to.equal(nil);
        end);
    end);
    describe("Promise:doneCall", function() -- Line: 1664
        -- upvalues: script_Parent (copy)
        it("should call the given function with arguments", function() -- Line: 1665
            -- upvalues: script_Parent (ref)
            local u357 = nil;
            local u358 = nil;
            script_Parent.resolve():doneCall(function(p359, p360) -- Line: 1667
                -- upvalues: u357 (ref), u358 (ref)
                u357 = p359;
                u358 = p360;
            end, 3, 4);
            expect(u357).to.equal(3);
            expect(u358).to.equal(4);
        end);
    end);
    describe("Promise:done", function() -- Line: 1677
        -- upvalues: script_Parent (copy)
        it("should trigger on resolve or cancel", function() -- Line: 1678
            -- upvalues: script_Parent (ref)
            local v361 = script_Parent.new(function() -- Line: 1679
            end);
            local u362 = nil;
            local v363 = v361:done(function() -- Line: 1682
                -- upvalues: u362 (ref)
                u362 = true;
            end);
            expect(u362).to.never.be.ok();
            v361:cancel();
            expect(v363:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(u362).to.equal(true);
            local u364 = nil;
            local u365 = nil;
            script_Parent.reject():done(function() -- Line: 1692
                -- upvalues: u364 (ref)
                u364 = true;
            end):finally(function() -- Line: 1694
                -- upvalues: u365 (ref)
                u365 = true;
            end);
            expect(u364).to.never.be.ok();
            expect(u365).to.be.ok();
        end);
    end);
    describe("Promise.some", function() -- Line: 1703
        -- upvalues: script_Parent (copy)
        it("should resolve once the goal is reached", function() -- Line: 1704
            -- upvalues: script_Parent (ref)
            local v366 = script_Parent.some({ script_Parent.resolve(1), script_Parent.reject(), script_Parent.resolve(2) }, 2);
            expect(v366:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v366._values[1][1]).to.equal(1);
            expect(v366._values[1][2]).to.equal(2);
        end);
        it("should error if the goal can\'t be reached", function() -- Line: 1715
            -- upvalues: script_Parent (ref)
            expect(script_Parent.some({ script_Parent.resolve(), script_Parent.reject() }, 2):getStatus()).to.equal(script_Parent.Status.Rejected);
            local u367 = nil;
            local v370 = script_Parent.some({ script_Parent.resolve(), script_Parent.new(function(p368, p369) -- Line: 1724
                    -- upvalues: u367 (ref)
                    u367 = p369;
                end) }, 2);
            expect(v370:getStatus()).to.equal(script_Parent.Status.Started);
            u367("foo");
            expect(v370:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v370._values[1]).to.equal("foo");
        end);
        it("should cancel pending Promises once the goal is reached", function() -- Line: 1735
            -- upvalues: script_Parent (ref)
            local u371 = nil;
            local v372 = script_Parent.new(function() -- Line: 1737
            end);
            local v374 = script_Parent.new(function(p373) -- Line: 1738
                -- upvalues: u371 (ref)
                u371 = p373;
            end);
            local v375 = script_Parent.some({ v372, v374, script_Parent.resolve() }, 2);
            expect(v375:getStatus()).to.equal(script_Parent.Status.Started);
            expect(v372:getStatus()).to.equal(script_Parent.Status.Started);
            expect(v374:getStatus()).to.equal(script_Parent.Status.Started);
            u371();
            expect(v375:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v372:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v374:getStatus()).to.equal(script_Parent.Status.Resolved);
        end);
        it("should error if passed a non-number", function() -- Line: 1759
            -- upvalues: script_Parent (ref)
            expect(function() -- Line: 1760
                -- upvalues: script_Parent (ref)
                script_Parent.some({}, "non-number");
            end).to.throw();
        end);
        it("should return an empty array if amount is 0", function() -- Line: 1765
            -- upvalues: script_Parent (ref)
            local v376 = script_Parent.some({ script_Parent.resolve(2) }, 0);
            expect(v376:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(#v376._values[1]).to.equal(0);
        end);
        it("should not return extra values", function() -- Line: 1774
            -- upvalues: script_Parent (ref)
            local v377 = script_Parent.some({
                script_Parent.resolve(1),
                script_Parent.resolve(2),
                script_Parent.resolve(3),
                script_Parent.resolve(4)
            }, 2);
            expect(v377:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(#v377._values[1]).to.equal(2);
            expect(v377._values[1][1]).to.equal(1);
            expect(v377._values[1][2]).to.equal(2);
        end);
        it("should cancel promises if it is cancelled", function() -- Line: 1788
            -- upvalues: script_Parent (ref)
            local v378 = script_Parent.new(function() -- Line: 1789
            end);
            v378:andThen(function() -- Line: 1790
            end);
            local v379 = { script_Parent.new(function() -- Line: 1793
                end), script_Parent.new(function() -- Line: 1794
                end), v378 };
            script_Parent.some(v379, 3):cancel();
            expect(v379[1]:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v379[2]:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v379[3]:getStatus()).to.equal(script_Parent.Status.Started);
        end);
        describe("Promise.any", function() -- Line: 1805
            -- upvalues: script_Parent (ref)
            it("should return the value directly", function() -- Line: 1806
                -- upvalues: script_Parent (ref)
                local v380 = script_Parent.any({ script_Parent.reject(), script_Parent.reject(), script_Parent.resolve(1) });
                expect(v380:getStatus()).to.equal(script_Parent.Status.Resolved);
                expect(v380._values[1]).to.equal(1);
            end);
            it("should error if all are rejected", function() -- Line: 1817
                -- upvalues: script_Parent (ref)
                expect(script_Parent.any({ script_Parent.reject(), script_Parent.reject(), script_Parent.reject() }):getStatus()).to.equal(script_Parent.Status.Rejected);
            end);
        end);
    end);
    describe("Promise.allSettled", function() -- Line: 1827
        -- upvalues: script_Parent (copy)
        it("should resolve with an array of PromiseStatuses", function() -- Line: 1828
            -- upvalues: script_Parent (ref)
            local u381 = nil;
            local v384 = script_Parent.allSettled({
                script_Parent.resolve(),
                script_Parent.reject(),
                script_Parent.resolve(),
                script_Parent.new(function(p382, p383) -- Line: 1834
                    -- upvalues: u381 (ref)
                    u381 = p383;
                end)
            });
            expect(v384:getStatus()).to.equal(script_Parent.Status.Started);
            u381();
            expect(v384:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v384._values[1][1]).to.equal(script_Parent.Status.Resolved);
            expect(v384._values[1][2]).to.equal(script_Parent.Status.Rejected);
            expect(v384._values[1][3]).to.equal(script_Parent.Status.Resolved);
            expect(v384._values[1][4]).to.equal(script_Parent.Status.Rejected);
        end);
        it("should cancel promises if it is cancelled", function() -- Line: 1848
            -- upvalues: script_Parent (ref)
            local v385 = script_Parent.new(function() -- Line: 1849
            end);
            v385:andThen(function() -- Line: 1850
            end);
            local v386 = { script_Parent.new(function() -- Line: 1853
                end), script_Parent.new(function() -- Line: 1854
                end), v385 };
            script_Parent.allSettled(v386):cancel();
            expect(v386[1]:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v386[2]:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v386[3]:getStatus()).to.equal(script_Parent.Status.Started);
        end);
    end);
    describe("Promise:await", function() -- Line: 1866
        -- upvalues: script_Parent (copy), advanceTime (ref)
        it("should return the correct values", function() -- Line: 1867
            -- upvalues: script_Parent (ref)
            local v387, v388, v389, v390, v391 = script_Parent.resolve(5, 6, nil, 7):await();
            expect(v387).to.equal(true);
            expect(v388).to.equal(5);
            expect(v389).to.equal(6);
            expect(v390).to.equal(nil);
            expect(v391).to.equal(7);
        end);
        it("should work if yielding is needed", function() -- Line: 1879
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local u392 = false;
            task.spawn(function() -- Line: 1881
                -- upvalues: script_Parent (ref), u392 (ref)
                local _, v393 = script_Parent.delay(1):await();
                expect((type(v393))).to.equal("number");
                u392 = true;
            end);
            advanceTime(2);
            expect(u392).to.equal(true);
        end);
    end);
    describe("Promise:expect", function() -- Line: 1892
        -- upvalues: script_Parent (copy)
        it("should throw the correct values", function() -- Line: 1893
            -- upvalues: script_Parent (ref)
            local v394 = {};
            local u395 = script_Parent.reject(v394);
            local success, result = pcall(function() -- Line: 1897
                -- upvalues: u395 (copy)
                u395:expect();
            end);
            expect(success).to.equal(false);
            expect(result).to.equal(v394);
        end);
    end);
    describe("Promise:now", function() -- Line: 1906
        -- upvalues: script_Parent (copy)
        it("should resolve if the Promise is resolved", function() -- Line: 1907
            -- upvalues: script_Parent (ref)
            local v396, v397 = script_Parent.resolve("foo"):now():_unwrap();
            expect(v396).to.equal(true);
            expect(v397).to.equal("foo");
        end);
        it("should reject if the Promise is not resolved", function() -- Line: 1914
            -- upvalues: script_Parent (ref)
            local v398, v399 = script_Parent.new(function() -- Line: 1915
            end):now():_unwrap();
            expect(v398).to.equal(false);
            expect(script_Parent.Error.isKind(v399, "NotResolvedInTime")).to.equal(true);
        end);
        it("should reject with a custom rejection value", function() -- Line: 1921
            -- upvalues: script_Parent (ref)
            local v400, v401 = script_Parent.new(function() -- Line: 1922
            end):now("foo"):_unwrap();
            expect(v400).to.equal(false);
            expect(v401).to.equal("foo");
        end);
    end);
    describe("Promise.each", function() -- Line: 1929
        -- upvalues: script_Parent (copy)
        it("should iterate", function() -- Line: 1930
            -- upvalues: script_Parent (ref)
            local v402, v403 = script_Parent.each({ "foo", "bar", "baz", "qux" }, function(...) -- Line: 1936
                return { ... };
            end):_unwrap();
            expect(v402).to.equal(true);
            expect(v403[1][1]).to.equal("foo");
            expect(v403[1][2]).to.equal(1);
            expect(v403[2][1]).to.equal("bar");
            expect(v403[2][2]).to.equal(2);
            expect(v403[3][1]).to.equal("baz");
            expect(v403[3][2]).to.equal(3);
            expect(v403[4][1]).to.equal("qux");
            expect(v403[4][2]).to.equal(4);
        end);
        it("should iterate serially", function() -- Line: 1951
            -- upvalues: script_Parent (ref)
            local u404 = {};
            local u405 = {};
            local v409 = script_Parent.each({ "foo", "bar", "baz" }, function(u406, p407) -- Line: 1959
                -- upvalues: u405 (copy), script_Parent (ref), u404 (copy)
                u405[p407] = (u405[p407] or 0) + 1;

                return script_Parent.new(function(u408) -- Line: 1962
                    -- upvalues: u404 (ref), u406 (copy)
                    table.insert(u404, function() -- Line: 1963
                        -- upvalues: u408 (copy), u406 (ref)
                        u408(u406:upper());
                    end);
                end);
            end);
            expect(v409:getStatus()).to.equal(script_Parent.Status.Started);
            expect(#u404).to.equal(1);
            expect(u405[1]).to.equal(1);
            expect(u405[2]).to.never.be.ok();
            table.remove(u404, 1)();
            expect(v409:getStatus()).to.equal(script_Parent.Status.Started);
            expect(#u404).to.equal(1);
            expect(u405[1]).to.equal(1);
            expect(u405[2]).to.equal(1);
            expect(u405[3]).to.never.be.ok();
            table.remove(u404, 1)();
            expect(v409:getStatus()).to.equal(script_Parent.Status.Started);
            expect(u405[1]).to.equal(1);
            expect(u405[2]).to.equal(1);
            expect(u405[3]).to.equal(1);
            table.remove(u404, 1)();
            expect(v409:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect((type(v409._values[1]))).to.equal("table");
            expect((type(v409._values[2]))).to.equal("nil");
            local v410 = v409._values[1];
            expect(v410[1]).to.equal("FOO");
            expect(v410[2]).to.equal("BAR");
            expect(v410[3]).to.equal("BAZ");
        end);
        it("should reject with the value if the predicate promise rejects", function() -- Line: 2002
            -- upvalues: script_Parent (ref)
            local v411 = script_Parent.each({ 1, 2, 3 }, function() -- Line: 2003
                -- upvalues: script_Parent (ref)
                return script_Parent.reject("foobar");
            end);
            expect(v411:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v411._values[1]).to.equal("foobar");
        end);
        it("should allow Promises to be in the list and wait when it gets to them", function() -- Line: 2011
            -- upvalues: script_Parent (ref)
            local u412 = nil;
            local v414 = { (script_Parent.new(function(p413) -- Line: 2013
                    -- upvalues: u412 (ref)
                    u412 = p413;
                end)) };
            local v416 = script_Parent.each(v414, function(p415) -- Line: 2019
                return p415 * 2;
            end);
            expect(v416:getStatus()).to.equal(script_Parent.Status.Started);
            u412(2);
            expect(v416:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v416._values[1][1]).to.equal(4);
        end);
        it("should reject with the value if a Promise from the list rejects", function() -- Line: 2031
            -- upvalues: script_Parent (ref)
            local u417 = false;
            local v419 = script_Parent.each({ 1, 2, script_Parent.reject("foobar") }, function(p418) -- Line: 2033
                -- upvalues: u417 (ref)
                u417 = true;

                return "never";
            end);
            expect(v419:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v419._values[1]).to.equal("foobar");
            expect(u417).to.equal(false);
        end);
        it("should reject immediately if there\'s a cancelled Promise in the list initially", function() -- Line: 2043
            -- upvalues: script_Parent (ref)
            local v420 = script_Parent.new(function() -- Line: 2044
            end);
            v420:cancel();
            local u421 = false;
            local v422 = script_Parent.each({ 1, 2, v420 }, function() -- Line: 2048
                -- upvalues: u421 (ref)
                u421 = true;
            end);
            expect(v422:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(u421).to.equal(false);
            expect(v422._values[1].kind).to.equal(script_Parent.Error.Kind.AlreadyCancelled);
        end);
        it("should stop iteration if Promise.each is cancelled", function() -- Line: 2057
            -- upvalues: script_Parent (ref)
            local u423 = {};
            local v426 = script_Parent.each({ "foo", "bar", "baz" }, function(p424, p425) -- Line: 2064
                -- upvalues: u423 (copy), script_Parent (ref)
                u423[p425] = (u423[p425] or 0) + 1;

                return script_Parent.new(function() -- Line: 2067
                end);
            end);
            expect(v426:getStatus()).to.equal(script_Parent.Status.Started);
            expect(u423[1]).to.equal(1);
            expect(u423[2]).to.never.be.ok();
            v426:cancel();
            expect(v426:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(u423[1]).to.equal(1);
            expect(u423[2]).to.never.be.ok();
        end);
        it("should cancel the Promise returned from the predicate if Promise.each is cancelled", function() -- Line: 2081
            -- upvalues: script_Parent (ref)
            local u427 = nil;
            script_Parent.each({ "foo", "bar", "baz" }, function(p428, p429) -- Line: 2088
                -- upvalues: u427 (ref), script_Parent (ref)
                u427 = script_Parent.new(function() -- Line: 2089
                end);

                return u427;
            end):cancel();
            expect(u427:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
        it("should cancel Promises in the list if Promise.each is cancelled", function() -- Line: 2098
            -- upvalues: script_Parent (ref)
            local v430 = script_Parent.new(function() -- Line: 2099
            end);
            script_Parent.each({ v430 }, function() -- Line: 2101
            end):cancel();
            expect(v430:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
    end);
    describe("Promise.retry", function() -- Line: 2109
        -- upvalues: script_Parent (copy)
        it("should retry N times", function() -- Line: 2110
            -- upvalues: script_Parent (ref)
            local u431 = 0;
            local v433 = script_Parent.retry(function(p432) -- Line: 2113
                -- upvalues: u431 (ref), script_Parent (ref)
                expect(p432).to.equal("foo");
                u431 = u431 + 1;

                if u431 == 5 then
                    return script_Parent.resolve("ok");
                end;

                return script_Parent.reject("fail");
            end, 5, "foo");
            expect(v433:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v433._values[1]).to.equal("ok");
        end);
        it("should reject if threshold is exceeded", function() -- Line: 2129
            -- upvalues: script_Parent (ref)
            local v434 = script_Parent.retry(function() -- Line: 2130
                -- upvalues: script_Parent (ref)
                return script_Parent.reject("fail");
            end, 5);
            expect(v434:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v434._values[1]).to.equal("fail");
        end);
    end);
    describe("Promise.retryWithDelay", function() -- Line: 2139
        -- upvalues: script_Parent (copy), advanceTime (ref)
        it("should retry after a delay", function() -- Line: 2140
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local u435 = 0;
            local v437 = script_Parent.retryWithDelay(function(p436) -- Line: 2143
                -- upvalues: u435 (ref), script_Parent (ref)
                expect(p436).to.equal("foo");
                u435 = u435 + 1;

                if u435 == 3 then
                    return script_Parent.resolve("ok");
                end;

                return script_Parent.reject("fail");
            end, 3, 10, "foo");
            expect(u435).to.equal(1);
            advanceTime(11);
            expect(u435).to.equal(2);
            advanceTime(11);
            expect(u435).to.equal(3);
            expect(v437:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v437._values[1]).to.equal("ok");
        end);
    end);
    describe("Promise.fromEvent", function() -- Line: 2170
        -- upvalues: script_Parent (copy)
        it("should convert a Promise into an event", function() -- Line: 2171
            -- upvalues: script_Parent (ref)
            local BindableEvent2 = Instance.new("BindableEvent");
            local v438 = script_Parent.fromEvent(BindableEvent2.Event);
            expect(v438:getStatus()).to.equal(script_Parent.Status.Started);
            BindableEvent2:Fire("foo");
            task.defer(coroutine.running());
            coroutine.yield();
            expect(v438:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v438._values[1]).to.equal("foo");
        end);
        it("should convert a Promise into an event with the predicate", function() -- Line: 2185
            -- upvalues: script_Parent (ref)
            local BindableEvent2 = Instance.new("BindableEvent");
            local v440 = script_Parent.fromEvent(BindableEvent2.Event, function(p439) -- Line: 2188
                return p439 == "foo";
            end);
            expect(v440:getStatus()).to.equal(script_Parent.Status.Started);
            BindableEvent2:Fire("bar");
            task.defer(coroutine.running());
            coroutine.yield();
            expect(v440:getStatus()).to.equal(script_Parent.Status.Started);
            BindableEvent2:Fire("foo");
            task.defer(coroutine.running());
            coroutine.yield();
            expect(v440:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v440._values[1]).to.equal("foo");
        end);
    end);
    describe("Promise.is", function() -- Line: 2207
        -- upvalues: script_Parent (copy)
        it("should work with current version", function() -- Line: 2208
            -- upvalues: script_Parent (ref)
            local v441 = script_Parent.resolve(1);
            expect(script_Parent.is(v441)).to.equal(true);
        end);
        it("should work with any object with an andThen", function() -- Line: 2214
            -- upvalues: script_Parent (ref)
            expect(script_Parent.is({
                andThen = function() -- Line: 2216, Name: andThen
                    return 1;
                end
            })).to.equal(true);
        end);
        it("should work with older promises", function() -- Line: 2224
            -- upvalues: script_Parent (ref)
            local v442 = {
                prototype = {}
            };
            v442.__index = v442.prototype;

            function v442.prototype.andThen(p443) -- Line: 2229
            end;

            local v444 = setmetatable({}, v442);
            expect(script_Parent.is(v444)).to.equal(true);
        end);
    end);
end;