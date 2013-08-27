/**
 * testDeviceFactory.d
 * dockwork
 * August 05, 2013
 * Brandon Surmanski
 */

module testDeviceFactory;

import std.conv;

import dw.system.deviceFactory;
import dw.draw.gl.drawDevice;
import dw.draw.gl.renderTarget;
import dw.draw.gl.pixelFormat;

import dw.audio.audioDevice;
import dw.input.glfw.inputDevice;
import dw.script.scriptDevice;

class TestDeviceFactory : DeviceFactory
{
    static WIDTH = 640;
    static HEIGHT = 480;
    protected:
    static TestDeviceFactory _instance;

        static void addFramebuffer(ref DrawDevice device)
        {
            device.framebuffer = device.createFramebuffer(WIDTH, HEIGHT);
        }

        static void addRenderTargets(ref DrawDevice device)
        {
            RenderTarget rt0 = device.createRenderTarget(WIDTH, 
                                                         HEIGHT, 
                                                         PixelFormat.RGBA8);
            RenderTarget rt1 = device.createRenderTarget(WIDTH, 
                                                         HEIGHT, 
                                                         PixelFormat.RGBA8);
            RenderTarget rt2 = device.createRenderTarget(WIDTH, 
                                                         HEIGHT, 
                                                         PixelFormat.RGBA8);
            device.framebuffer.bind(0, rt0);
            device.framebuffer.bind(1, rt1);
            device.framebuffer.bind(2, rt2);
        }

        static void addPrograms(ref DrawDevice device)
        {
        
        }

    public:
        static TestDeviceFactory instance()
        {
            if(!_instance)
            {
                _instance = new TestDeviceFactory();
            }
            return _instance;
        }

        override DrawDevice createDrawDevice()
        {
            DrawDevice device = new GLDrawDevice(); 
            //addFramebuffer(device);
            //addRenderTargets(device);
            //addPrograms(device);
            return device;
        }

        override AudioDevice createAudioDevice()
        {
            return null;
        }

        override InputDevice createInputDevice()
        {
            return new GlfwInputDevice();
        }

        override ScriptDevice createScriptDevice()
        {
            return null;
        }
}
