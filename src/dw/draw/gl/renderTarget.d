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
import dw.draw.gl.drawDevice;
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

    this(GLTexture texture)
    {
        super(TargetType.COLOR);
        _texture = texture;
    }

    this(DrawDevice device, uint w, uint h, DepthFormat dFormat, StencilFormat sFormat)
    {
        super(TargetType.DEPTH_STENCIL);
        _texture = new GLTexture(device, w, h, dFormat, sFormat);
    }

    this(DrawDevice device, uint w, uint h, DepthFormat dFormat)
    {
        super(TargetType.DEPTH);
        _texture = new GLTexture(device, w, h, dFormat);
    }

    this(DrawDevice device, uint w, uint h, StencilFormat sFormat)
    {
        super(TargetType.STENCIL);
        _texture = new GLTexture(device, w, h, sFormat);
    }

    this(DrawDevice device, uint w, uint h, PixelFormat pFormat)
    {
        super(TargetType.COLOR);
        _texture = new GLTexture(device, w, h, pFormat);
    }
}
