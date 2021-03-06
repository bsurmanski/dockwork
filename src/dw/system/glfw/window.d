/**
 * window.d
 * dockwork
 * August 18, 2013
 * Brandon Surmanski
 */

module dw.system.glfw.window;

import c.glfw.glfw;
import std.string;
public import dw.system.window;

class GlfwWindow : Window
{
    private:
        static bool glfwInitialized = false;
        GLFWwindow *window;
    public:
        this(uint w, uint h, string name)
        {
            super(w,h,name);
            if(!glfwInitialized)
            {
                glfwInit();
                glfwInitialized = true;
            }

            glfwSwapInterval(1); //vsync
            glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
            glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 0);
            glfwWindowHint(GLFW_RESIZABLE, false);
            window = glfwCreateWindow(w, h, name.toStringz(), null, null);
            glfwMakeContextCurrent(window);
        }

        ~this()
        {
            glfwDestroyWindow(window);
        }

        @property override void name(string name)
        {
            super.name(name);
            glfwSetWindowTitle(window, name.toStringz());
        }

        @property override void hidden(bool h)
        {
            super.hidden(h);
            if(h)
            {
                glfwHideWindow(window);
            } else
            {
                glfwShowWindow(window);
            }
        }

        override void focus()
        {
            glfwMakeContextCurrent(window);
        }

        override void swapBuffers()
        {
            //glfwMakeContextCurrent(window);
            //draw to current window?
            glfwSwapBuffers(window);
        }

        override void clear()
        {
            glfwMakeContextCurrent(window);
            glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
        }
}
