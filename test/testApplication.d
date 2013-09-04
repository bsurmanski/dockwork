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

import dw.system.glfw.window;

class TestApplication : Application
{
    GlfwWindow window;
    this()
    {
        window = new GlfwWindow(640, 480, "Testing");
        super(TestDeviceFactory.instance);
    }

    override void run()
    {
        while(!inputDevice.keyDown('A'))
        {
            window.clear();
            inputDevice.update(0);
            drawDevice.draw(null);
            window.swapBuffers();
        }
    }
}
