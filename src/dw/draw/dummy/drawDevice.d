/**
 * dummyDrawDevice.d
 * dockwork
 * August 19, 2013
 * Brandon Surmanski
 */

module dw.draw.dummy.drawDevice;

public import dw.draw.drawDevice;
import dw.draw.framebuffer;
import dw.draw.renderTarget;
import dw.draw.model;
import dw.draw.drawLamp;
import dw.draw.texture;
import dw.draw.pixelFormat;
import dw.resource.image;

class DummyDrawDevice : DrawDevice
{
    //TODO: dummy texture / framebuffer / rendertarget / etc

    override void draw(Model model){}
    override void apply(DrawLamp lamp){}
    override Texture createTexture(uint w, uint h, PixelFormat pFormat){return null;}
    override Texture createTexture(Image image){return null;}

    override Framebuffer createFramebuffer(uint w, uint h, 
            DepthFormat dFormat, 
            StencilFormat sFormat) { return null; }

    override RenderTarget createDepthStencilRenderTarget(uint w, uint h,
            DepthFormat dFormat, StencilFormat sFormat) { return null; }

    override RenderTarget createDepthRenderTarget(uint w, uint h, 
            DepthFormat dFormat) { return null; }

    override RenderTarget createStencilRenderTarget(uint w, uint h,
            StencilFormat sFormat)
    { return null; }

    override RenderTarget createRenderTarget(uint w, uint h,
            PixelFormat pFormat)
    { return null; }
}
