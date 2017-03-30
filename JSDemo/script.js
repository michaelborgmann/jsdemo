var engine = ScriptEngine.create();

var version = engine.version;
engine.showWithText(version);
engine.waitWithSeconds(1);
engine.showWithText("This is a JS script");
