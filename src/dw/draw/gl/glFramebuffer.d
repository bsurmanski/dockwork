/**
 * glFramebuffer
 * dockwork
 * July 18, 2013
 * Brandon Surmanski
 */

module dw.draw.gl.glFramebuffer;

import dw.draw.framebuffer;
import dw.draw.drawDevice;
import dw.draw.pixelFormat;

class GLFramebuffer : Framebuffer
{
    this(DrawDevice device, uint w, uint h, 
            DepthFormat dFormat = DepthFormat.DEPTH_24, 
            StencilFormat sFormat = StencilFormat.STENCIL_8)
    {
        super(device, w, h, dFormat, sFormat);
    }
}
