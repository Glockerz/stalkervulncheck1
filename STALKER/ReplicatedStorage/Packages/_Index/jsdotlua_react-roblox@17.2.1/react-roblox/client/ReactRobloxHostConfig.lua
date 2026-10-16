-- Decompiled with Potassium's decompiler.

local function unimplemented(p1: string) -- Line: 13
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: " .. tostring(p1));
    error("FIXME (roblox): " .. p1 .. " is unimplemented", 2);
end;

local CollectionService = game:GetService("CollectionService");
local v2 = require(script.Parent.Parent.Parent:WaitForChild("luau-polyfill"));
local inspect = v2.util.inspect;
local console = require(script.Parent.Parent.Parent:WaitForChild("shared")).console;
local Object = v2.Object;
local setTimeout = v2.setTimeout;
local clearTimeout = v2.clearTimeout;
require(script.Parent:WaitForChild("ReactRobloxHostTypes.roblox"));
local ReactRobloxComponentTree = require(script.Parent:WaitForChild("ReactRobloxComponentTree"));
local precacheFiberNode = ReactRobloxComponentTree.precacheFiberNode;
local uncacheFiberNode = ReactRobloxComponentTree.uncacheFiberNode;
local updateFiberProps = ReactRobloxComponentTree.updateFiberProps;
local ReactRobloxComponent = require(script.Parent:WaitForChild("ReactRobloxComponent"));
local setInitialProperties = ReactRobloxComponent.setInitialProperties;
local diffProperties = ReactRobloxComponent.diffProperties;
local updateProperties = ReactRobloxComponent.updateProperties;
local cleanupHostComponent = ReactRobloxComponent.cleanupHostComponent;
local enableCreateEventHandleAPI = require(script.Parent.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableCreateEventHandleAPI;

local function recursivelyUncacheFiberNode(p3) -- Line: 204
    -- upvalues: uncacheFiberNode (copy)
    if typeof(p3) ~= "Instance" then
        return;
    end;

    uncacheFiberNode(p3);

    for _, descendant in p3:GetDescendants() do
        uncacheFiberNode(descendant);
    end;
end;

local u4 = {};
Object.assign(u4, require(script.Parent.Parent.Parent:WaitForChild("shared")).ReactFiberHostConfig.WithNoPersistence);

function u4.getRootHostContext(p5) -- Line: 225
    return p5.ClassName;
end;

function u4.getChildHostContext(p6: any, p7: string, p8: any) -- Line: 263
    return p6;
end;

function u4.getPublicInstance(p9: userdata) -- Line: 284
    return p9;
end;

function u4.prepareForCommit(p10) -- Line: 288
    -- upvalues: enableCreateEventHandleAPI (copy)
    if enableCreateEventHandleAPI then
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print("UNIMPLEMENTED ERROR: " .. tostring("enableCreateEventHandleAPI"));
        error("FIXME (roblox): enableCreateEventHandleAPI is unimplemented", 2);
    end;

    return nil;
end;

function u4.beforeActiveInstanceBlur() -- Line: 303
    -- upvalues: enableCreateEventHandleAPI (copy)
    if enableCreateEventHandleAPI then
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print("UNIMPLEMENTED ERROR: " .. tostring("enableCreateEventHandleAPI"));
        error("FIXME (roblox): enableCreateEventHandleAPI is unimplemented", 2);
    end;
end;

function u4.afterActiveInstanceBlur() -- Line: 312
    -- upvalues: enableCreateEventHandleAPI (copy)
    if enableCreateEventHandleAPI then
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print("UNIMPLEMENTED ERROR: " .. tostring("enableCreateEventHandleAPI"));
        error("FIXME (roblox): enableCreateEventHandleAPI is unimplemented", 2);
    end;
end;

function u4.resetAfterCommit(p11) -- Line: 321
end;

function u4.createInstance(p12: string, p13: any, p14: any, p15: any, p16: table) -- Line: 329
    -- upvalues: precacheFiberNode (copy), updateFiberProps (copy)
    local Instance_new_ret = Instance.new(p12);

    if p16.key then
        Instance_new_ret.Name = p16.key;
    else
        local return_ = p16.return_;

        while return_ do
            if return_.key then
                Instance_new_ret.Name = return_.key;
                break;
            end;

            return_ = return_.return_;
        end;
    end;

    precacheFiberNode(p16, Instance_new_ret);
    updateFiberProps(Instance_new_ret, p13);

    return Instance_new_ret;
end;

function u4.appendInitialChild(p17: userdata, p18: userdata) -- Line: 396
    p18.Parent = p17;
end;

function u4.finalizeInitialChildren(p19: any, p20: string, p21: any, p22: any, p23: any) -- Line: 401
    -- upvalues: setInitialProperties (copy)
    setInitialProperties(p19, p20, p21, p22);

    return false;
end;

function u4.prepareUpdate(p24: userdata, p25: string, p26: any, p27: any, p28: any, p29: any) -- Line: 413
    -- upvalues: diffProperties (copy)
    return diffProperties(p24, p25, p26, p27, p28);
end;

function u4.shouldSetTextContent(p30: string, p31: any) -- Line: 440
    return false;
end;

function u4.createTextInstance(p32: string, p33: any, p34: any, p35: table) -- Line: 456
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: " .. tostring("createTextInstance"));
    error("FIXME (roblox): createTextInstance is unimplemented", 2);

    return nil;
end;

u4.isPrimaryRenderer = true;
u4.warnsIfNotActing = true;
u4.scheduleTimeout = setTimeout;
u4.cancelTimeout = clearTimeout;
u4.noTimeout = -1;
u4.supportsMutation = true;

function u4.commitMount(p36: userdata, p37: string, p38: any, p39: table) -- Line: 482
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: " .. tostring("commitMount"));
    error("FIXME (roblox): commitMount is unimplemented", 2);
end;

function u4.commitUpdate(p40: userdata, p41: table, p42: string, p43: any, p44: any, p45: table) -- Line: 504
    -- upvalues: updateFiberProps (copy), updateProperties (copy)
    updateFiberProps(p40, p44);
    updateProperties(p40, p41, p43);
end;

local function checkTags(p46: userdata) -- Line: 533
    -- upvalues: console (copy), inspect (copy), CollectionService (copy)
    if typeof(p46) == "Instance" then
        if not p46:IsDescendantOf(game) and #CollectionService:GetTags(p46) > 0 then
            console.warn("Tags applied to orphaned %s \"%s\" cannot be accessed via CollectionService:GetTagged. If you\'re relying on tag behavior in a unit test, consider mounting your test root into the DataModel.", p46.ClassName, p46.Name);
        end;

        return;
    end;

    console.warn("Could not check tags on non-instance %s.", inspect(p46));
end;

function u4.appendChild(p47: userdata, p48: userdata) -- Line: 552
    -- upvalues: checkTags (copy)
    p48.Parent = p47;

    if _G.__DEV__ then
        checkTags(p48);
    end;
end;

function u4.appendChildToContainer(p49: any, p50: userdata) -- Line: 561
    -- upvalues: u4 (copy)
    u4.appendChild(p49, p50);
end;

function u4.insertBefore(p51: userdata, p52: userdata, p53: userdata) -- Line: 591
    -- upvalues: checkTags (copy)
    p52.Parent = p51;

    if _G.__DEV__ then
        checkTags(p52);
    end;
end;

function u4.insertInContainerBefore(p54: any, p55: userdata, p56: userdata) -- Line: 601
    -- upvalues: u4 (copy)
    u4.insertBefore(p54, p55, p56);
end;

function u4.removeChild(p57: userdata, p58: userdata) -- Line: 639
    -- upvalues: uncacheFiberNode (copy), cleanupHostComponent (copy)
    if typeof(p58) == "Instance" then
        uncacheFiberNode(p58);

        for _, descendant in p58:GetDescendants() do
            uncacheFiberNode(descendant);
        end;
    end;

    cleanupHostComponent(p58);
    p58.Parent = nil;
    p58:Destroy();
end;

function u4.removeChildFromContainer(p59: any, p60: userdata) -- Line: 651
    -- upvalues: u4 (copy)
    u4.removeChild(p59, p60);
end;

function u4.clearSuspenseBoundary(p61: userdata, p62: any) -- Line: 663
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: " .. tostring("clearSuspenseBoundary"));
    error("FIXME (roblox): clearSuspenseBoundary is unimplemented", 2);
end;

function u4.clearSuspenseBoundaryFromContainer(p63, p64) -- Line: 701
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: " .. tostring("clearSuspenseBoundaryFromContainer"));
    error("FIXME (roblox): clearSuspenseBoundaryFromContainer is unimplemented", 2);
end;

function u4.hideInstance(p65: userdata) -- Line: 715
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: " .. tostring("hideInstance"));
    error("FIXME (roblox): hideInstance is unimplemented", 2);
end;

function u4.hideTextInstance(p66) -- Line: 729
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: " .. tostring("hideTextInstance"));
    error("FIXME (roblox): hideTextInstance is unimplemented", 2);
end;

function u4.unhideInstance(p67: userdata, p68: any) -- Line: 734
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: " .. tostring("unhideInstance"));
    error("FIXME (roblox): unhideInstance is unimplemented", 2);
end;

function u4.unhideTextInstance(p69: any, p70: string) -- Line: 748
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: " .. tostring("unhideTextInstance"));
    error("FIXME (roblox): unhideTextInstance is unimplemented", 2);
end;

function u4.clearContainer(p71) -- Line: 753
    -- upvalues: u4 (copy)
    for _, child in p71:GetChildren() do
        u4.removeChild(p71, child);
    end;
end;

function u4.preparePortalMount(p72: userdata) -- Line: 1196
end;

return u4;