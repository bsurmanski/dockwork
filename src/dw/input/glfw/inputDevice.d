/**
 * glfwInputDevice.d
 * dockwork
 * August 19, 2013
 * Brandon Surmanski
 */

module dw.input.glfw.inputDevice;

import c.glfw.glfw;

public import dw.input.inputDevice;

class GlfwInputDevice : InputDevice
{
    static glfwInitialized = false;

    this()
    {
        if(!glfwInitialized)
        {
            glfwInit();
            glfwInitialized = true;
        }
    }

    override void update(float dt)
    {
        glfwPollEvents();
    }
}
