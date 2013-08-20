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

    override bool keyDown(uint key)
    {
        GLFWwindow *window = glfwGetCurrentContext();
        return window && glfwGetKey(window, key) != 0;
    }

    override void update(float dt)
    {
        glfwPollEvents();
    }
}
