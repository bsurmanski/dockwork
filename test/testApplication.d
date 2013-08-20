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
    GLDrawWindow window;
    this()
    {
        super(TestDeviceFactory.create(), null, new GlfwInputDevice(), null);
        window = new GLDrawWindow(640, 480, "test");
    }

    void run()
    {
        while(!inputDevice.keyDown('A'))
        {
            inputDevice.update(0);
        }
    }
}
