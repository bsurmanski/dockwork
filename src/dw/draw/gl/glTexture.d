/**
 * glTexture
 * dockwork
 * July 18, 2013
 * Brandon Surmanski
 */

module dw.draw.gl.glTexture;

import c.gl.gl;

public import dw.draw.texture;

import dw.draw.gl.glDrawDevice;
import dw.draw.pixelFormat;
import dw.resource.image;

import dw.draw.gl.glPixelFormat;

class GLTexture : Texture 
{
    private:
        GLuint _texture;
        GLuint _target = GL_TEXTURE_2D; //TODO variable target?
        GLuint _internalFormat;

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

    this(Image image)
    {
        super(GLDrawDevice.instance, image.width, image.height); 
        //TODO upload image data
    }

    this(uint w, uint h, 
                PixelFormat pFormat)
    {
        _internalFormat = getInternalFormat(pFormat);
        super(GLDrawDevice.instance, w,h);
        prepareTexture();
    }

    this(uint w, uint h, DepthFormat dFormat)
    {
        //TODO depth format
        //_internalFormat = getInternalFormat(dFormat);
        super(GLDrawDevice.instance, w, h);
        prepareTexture();
    }

    this(uint w, uint h, StencilFormat sFormat)
    {
        //TODO: stencil format
        //_internalFormat = getInternalFormat(sFormat);
        super(GLDrawDevice.instance, w, h);
        prepareTexture();
    }

    this(uint w, uint h, 
            DepthFormat dFormat, StencilFormat sFormat)
    {
        //_internalFormat = getInternalFormat(dFormat, sFormat);
        //TODO depth stencil internalFormat
        super(GLDrawDevice.instance, w, h);
        prepareTexture();
    }
}
