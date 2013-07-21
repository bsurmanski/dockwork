/**
 * glRenderTarget
 * dockwork
 * July 18, 2013
 * Brandon Surmanski
 */

module dw.draw.gl.glRenderTarget;

import dw.draw.pixelFormat;
import dw.draw.renderTarget;
import dw.draw.gl.glTexture;

// proxy for texture
class GLRenderTarget : RenderTarget 
{
    private:
        GLTexture _texture;

    public:

    this(uint w, uint h, DepthFormat dFormat, StencilFormat sFormat)
    {
        _texture = new GLTexture(w, h, dFormat, sFormat);
    }

    this(uint w, uint h, DepthFormat dFormat)
    {
        _texture = new GLTexture(w, h, dFormat);
    }

    this(uint w, uint h, StencilFormat sFormat)
    {
        _texture = new GLTexture(w, h, sFormat);
    }

    this(uint w, uint h, PixelFormat pFormat)
    {
        _texture = new GLTexture(w, h, pFormat);
    }
}
