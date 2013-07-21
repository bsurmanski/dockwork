/**
 * glTexture
 * dockwork
 * July 18, 2013
 * Brandon Surmanski
 */

module dw.draw.gl.glTexture;

import c.gl.gl;

import dw.draw.image;
import dw.draw.pixelFormat;
import dw.draw.texture;

import dw.draw.gl.glPixelFormat;

class GLTexture : Texture 
{
    private:
        GLuint _texture;
        GLuint _target = GL_TEXTURE_2D; //TODO variable target?
        GLuint _internalFormat;

    protected:
        @property GLuint textureID() { return _texture; }

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

    this(Image image)
    {
        super(image.width, image.height); 
        //TODO upload image data
    }

    this(uint w, uint h, 
                PixelFormat pFormat)
    {
        _internalFormat = getInternalFormat(pFormat);
        super(w,h);
        prepareTexture();
    }

    this(uint w, uint h, DepthFormat dFormat)
    {
        _internalFormat = getInternalFormat(dFormat);
        super(w,h);
        prepareTexture();
    }

    this(uint w, uint h, StencilFormat sFormat)
    {
        _internalFormat = getInternalFormat(sFormat);
        super(w,h);
        prepareTexture();
    }

    this(uint w, uint h, 
            DepthFormat dFormat, StencilFormat sFormat)
    {
        //_internalFormat = getInternalFormat(dFormat, sFormat);
        //TODO depth stencil internalFormat
        super(w,h);
        prepareTexture();
    }
}
