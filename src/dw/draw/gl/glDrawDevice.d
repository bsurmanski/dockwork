/**
 * glDrawDevice
 * dockwork
 * July 18, 2013
 * Brandon Surmansk
 */

module dw.draw.gl.glDrawDevice;

import dw.draw.drawDevice;
import dw.draw.framebuffer;
import dw.draw.renderTarget;
import dw.draw.pixelFormat;
import dw.draw.texture;
import dw.draw.image;
import dw.draw.gl.glFramebuffer;
import dw.draw.gl.glRenderTarget;
import dw.draw.gl.glTexture;

class GLDrawDevice : DrawDevice
{
    /**
     * Texture
     */
    override Texture createTexture(uint w, uint h, PixelFormat pFormat)
    {
        return new GLTexture(w, h, pFormat);
    }

    override Texture createTexture(Image image)
    {
        return new GLTexture(image);
    }

    /**
     * Framebuffer
     */

    override Framebuffer createFramebuffer(uint w, uint h, 
            DepthFormat dFormat = DepthFormat.DEPTH_24,
            StencilFormat sFormat = StencilFormat.STENCIL_8)
    {
        //XXX require DrawDevice for all constructors?
        return new GLFramebuffer(this, w, h, dFormat, sFormat);
    }

    /**
     * RenderTarget
     */

    override RenderTarget createDepthStencilRenderTarget(uint w, uint h, 
            DepthFormat dFormat, StencilFormat sFormat)
    {
        return new GLRenderTarget(w, h, dFormat, sFormat); 
    }

    override RenderTarget createDepthRenderTarget(uint w, uint h, DepthFormat dFormat)
    {
        return new GLRenderTarget(w, h, dFormat);
    }

    override RenderTarget createStencilRenderTarget(uint w, uint h, StencilFormat sFormat)
    {
        return new GLRenderTarget(w, h, sFormat);
    }

    override RenderTarget createRenderTarget(uint w, uint h, 
                PixelFormat pFormat)
    {
        return new GLRenderTarget(w, h, pFormat); 
    }
}
