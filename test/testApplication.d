/**
 * testApplication.d
 * dockwork test
 * August 18, 2013
 * Brandon Surmanski
 */

module testApplication;

public import dw.system.application;
import testDeviceFactory;
import dw.input.glfw.glfwInputDevice;

class TestApplication : Application
{
    this()
    {
        super(TestDeviceFactory.create(), null, new GlfwInputDevice(), null);
    }

    void run()
    {

    }
}
