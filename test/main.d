import std.stdio;

import dw.draw.gl.glDrawDevice;
import testDeviceFactory;

void main()
{
    auto device = TestDeviceFactory.create();
    writeln("test");
}
