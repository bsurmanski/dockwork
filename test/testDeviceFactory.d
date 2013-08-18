/**
 * testDeviceFactory.d
 * dockwork
 * August 05, 2013
 * Brandon Surmanski
 */

module testDeviceFactory;

import std.conv;

import dw.draw.drawDeviceFactory;
import dw.draw.gl.glDrawDevice;
import dw.draw.gl.glRenderTarget;
import dw.draw.gl.glPixelFormat;

class TestDeviceFactory : DrawDeviceFactory
{
    static WIDTH = 640;
    static HEIGHT = 480;
    protected:
        static void addFramebuffer(ref DrawDevice device)
        {
            device.activeFramebuffer = device.createFramebuffer(WIDTH, HEIGHT);
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
            device.activeFramebuffer.bind(0, rt0);
            device.activeFramebuffer.bind(1, rt1);
            device.activeFramebuffer.bind(2, rt2);
        }

        static void addPrograms(ref DrawDevice device)
        {
        
        }
}
