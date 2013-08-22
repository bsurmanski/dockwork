/**
 * testApplication.d
 * dockwork test
 * August 18, 2013
 * Brandon Surmanski
 */

module testApplication;

public import dw.system.application;
import testDeviceFactory;
import dw.input.glfw.inputDevice;

import dw.draw.gl.drawWindow;

class TestApplication : Application
{
    DrawWindow window;
    this()
    {
        super(TestDeviceFactory.instance);
        window = drawDevice.createWindow(640, 480, "test");
    }

    override void run()
    {
        while(!inputDevice.keyDown('A'))
        {
            inputDevice.update(0);
        }
    }
}
