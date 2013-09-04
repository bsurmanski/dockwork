/**
 * glTexture
 * dockwork
 * July 18, 2013
 * Brandon Surmanski
 */

module dw.draw.gl.texture;

import c.gl.gl;

public import dw.draw.texture;

import dw.draw.gl.drawDevice;
import dw.draw.gl.renderTarget;
import dw.draw.pixelFormat;
import dw.resource.image;

import dw.draw.gl.pixelFormat;

class GLTexture : Texture 
{
    private:
        GLuint _texture;
        GLuint _target = GL_TEXTURE_2D; //TODO variable target?
        GLuint _internalFormat;
        GLRenderTarget _renderTarget;

    protected:

        void prepareTexture()
        {
            glGenTextures(1, &_texture);
            glBindTexture(_target, _texture);
            //TODO: BGRA for Windows?
            //TODO: default texture parameters
            //TODO: format / type requried even if null data?
            glTexImage2D(_target, 0, _internalFormat, width(), height(), 0, 0, 0, null);
            glBindTexture(_target, 0);
        }

    public:

    @property GLuint textureId() { return _texture; }
    @property GLRenderTarget renderTarget()
    {
        if(!_renderTarget)
        {
            _renderTarget = new GLRenderTarget(this);
        }
        return _renderTarget;
    }

    this(DrawDevice device, Image image)
    {
        super(device, image.width, image.height); 
        glGenTextures(1, &_texture);
        glBindTexture(_target, _texture);
        glTexParameteri(_target, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameteri(_target, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexImage2D(_target, 0, 
                GL_RGBA, image.width, image.height, //TODO: RGBA?
                0, GL_UNSIGNED_BYTE, GL_RGBA, image.pixels.ptr);
        //TODO upload image data
    }

    this(DrawDevice device, uint w, uint h, 
                PixelFormat pFormat)
    {
        _internalFormat = getInternalFormat(pFormat);
        super(device, w,h);
        prepareTexture();
    }

    this(DrawDevice device, uint w, uint h, DepthFormat dFormat)
    {
        //TODO depth format
        //_internalFormat = getInternalFormat(dFormat);
        super(device, w, h);
        prepareTexture();
    }

    this(DrawDevice device, uint w, uint h, StencilFormat sFormat)
    {
        //TODO: stencil format
        //_internalFormat = getInternalFormat(sFormat);
        super(device, w, h);
        prepareTexture();
    }

    this(DrawDevice device, uint w, uint h, 
            DepthFormat dFormat, StencilFormat sFormat)
    {
        //_internalFormat = getInternalFormat(dFormat, sFormat);
        //TODO depth stencil internalFormat
        super(device, w, h);
        prepareTexture();
    }
}
