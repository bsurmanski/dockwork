/**
 * deviceFactory.d
 * dockwork
 * August 01, 2013
 * Brandon Surmanski
 */

module dw.draw.deviceFactory;

import dw.draw.drawDevice;
import dw.draw.gl.glDrawDevice;

abstract class DrawDeviceFactory
{
    private:
        static uint defaultWidth = 640;
        static uint defaultHeight = 480;

        DrawDevice _device;
        uint _width;
        uint _height;

    protected:
        static void addFramebuffer(ref DrawDevice device);
        static void addRenderTargets(ref DrawDevice device);
        static void addPrograms(ref DrawDevice device);
        static DrawDevice createDrawDevice(uint w, uint h);

    public:

        this()
        {
            _width = defaultWidth;
            _height = defaultHeight;
        }

        @property uint width() { return _width; }
        @property void width(uint w) { _width = w; }
        @property uint height() { return _height; }
        @property void height(uint h) { _height = h; }

        static DrawDevice create()
        {
            DrawDevice device = createDrawDevice(defaultWidth, defaultHeight);
            addFramebuffer(device);
            addRenderTargets(device);
            addPrograms(device);
            return device;
        }

        /*
        DrawDevice create()
        {
            DrawDevice device = createDrawDevice(_width, _height);
            addFramebuffer(device);
            addRenderTargets(device);
            addPrograms(device);
            return device;
        }*/
}
