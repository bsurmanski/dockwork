/**
 * testDeviceFactory.d
 * dockwork
 * August 05, 2013
 * Brandon Surmanski
 */

module testDeviceFactory;

import std.conv;

import dw.draw.drawDeviceFactory;
import dw.draw.gl.drawDevice;
import dw.draw.gl.renderTarget;
import dw.draw.gl.pixelFormat;

class TestDeviceFactory : DrawDeviceFactory
{
    static WIDTH = 640;
    static HEIGHT = 480;
    protected:
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
}
