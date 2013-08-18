import std.stdio;

import dw.draw.gl.glDrawDevice;
import testDeviceFactory;
import testApplication;

void main()
{
    TestApplication app = new TestApplication();
    app.run();
    writeln("test");
}
