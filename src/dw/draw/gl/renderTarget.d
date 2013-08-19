/**
 * glRenderTarget
 * dockwork
 * July 18, 2013
 * Brandon Surmanski
 */

module dw.draw.gl.renderTarget;

import c.gl.gl;
import c.gl.glext;

public import dw.draw.renderTarget;

import dw.draw.pixelFormat;
import dw.draw.gl.texture;

// proxy for texture
class GLRenderTarget : RenderTarget 
{
    private:
        GLTexture _texture;

    public:

    @property GLuint renderTargetId() { return _texture.textureId; }
    @property override uint width() { return _texture.width; }
    @property override uint height() { return _texture.height; }

    this(uint w, uint h, DepthFormat dFormat, StencilFormat sFormat)
    {
        super(TargetType.DEPTH_STENCIL);
        _texture = new GLTexture(w, h, dFormat, sFormat);
    }

    this(uint w, uint h, DepthFormat dFormat)
    {
        super(TargetType.DEPTH);
        _texture = new GLTexture(w, h, dFormat);
    }

    this(uint w, uint h, StencilFormat sFormat)
    {
        super(TargetType.STENCIL);
        _texture = new GLTexture(w, h, sFormat);
    }

    this(uint w, uint h, PixelFormat pFormat)
    {
        super(TargetType.COLOR);
        _texture = new GLTexture(w, h, pFormat);
    }
}
