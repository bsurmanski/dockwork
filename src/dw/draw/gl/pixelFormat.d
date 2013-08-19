/**
 * glPixelFormat.d
 * dockwork
 * July 20, 2013
 * Brandon Surmanski
 */

module dw.draw.gl.pixelFormat;

import c.gl.gl;
import c.gl.glext;
public import dw.draw.pixelFormat;

//TODO: depth/stencil

GLuint getInternalFormat(PixelFormat formatEnum)
{
    switch(formatEnum)
    {
        case PixelFormat.NONE: return 0;

        //RGBA
        case PixelFormat.RGBA8:     return GL_RGBA8;
        case PixelFormat.RGBA8I:    return GL_RGBA8I;
        case PixelFormat.RGBA8UI:   return GL_RGBA8UI;
        case PixelFormat.RGBA16:    return GL_RGBA16;
        case PixelFormat.RGBA16I:   return GL_RGBA16I;
        case PixelFormat.RGBA16UI:  return GL_RGBA16UI;
        case PixelFormat.RGBA16F:   return GL_RGBA16F;
        case PixelFormat.RGBA32I:   return GL_RGBA32I;
        case PixelFormat.RGBA32UI:  return GL_RGBA32UI;
        case PixelFormat.RGBA32F:   return GL_RGBA32F;

        //RGB
        case PixelFormat.RGB8: 	    return GL_RGB8;
        case PixelFormat.RGB8I: 	return GL_RGB8I;
        case PixelFormat.RGB8UI: 	return GL_RGB8UI;
        case PixelFormat.RGB16: 	return GL_RGB16;
        case PixelFormat.RGB16I: 	return GL_RGB16I;
        case PixelFormat.RGB16UI: 	return GL_RGB16UI;
        case PixelFormat.RGB16F: 	return GL_RGB16F;
        case PixelFormat.RGB32I: 	return GL_RGB32I;
        case PixelFormat.RGB32UI: 	return GL_RGB32UI;
        case PixelFormat.RGB32F: 	return GL_RGB32F;

        //RG
        case PixelFormat.RG8: 	    return GL_RG8;
        case PixelFormat.RG8I: 	    return GL_RG8I;
        case PixelFormat.RG8UI: 	return GL_RG8UI;
        case PixelFormat.RG16: 	    return GL_RG16;
        case PixelFormat.RG16I: 	return GL_RG16I;
        case PixelFormat.RG16UI: 	return GL_RG16UI;
        case PixelFormat.RG16F: 	return GL_RG16F;
        case PixelFormat.RG32I: 	return GL_RG32I;
        case PixelFormat.RG32UI: 	return GL_RG32UI;
        case PixelFormat.RG32F: 	return GL_RG32F;

        //R
        case PixelFormat.R8: 		return GL_R8;
        case PixelFormat.R8I: 		return GL_R8I;
        case PixelFormat.R8UI: 		return GL_R8UI;
        case PixelFormat.R16: 		return GL_R16;
        case PixelFormat.R16I: 	    return GL_R16I;
        case PixelFormat.R16UI: 	return GL_R16UI;
        case PixelFormat.R16F: 		return GL_R16F;
        case PixelFormat.R24F: 		return -1;//GL_R24F; //Should have?
        case PixelFormat.R24I: 	    return -1;//GL_R24I; //Should have?
        case PixelFormat.R24UI: 	return -1;//GL_R24UI; //Should have?
        case PixelFormat.R32I: 	    return GL_R32I;
        case PixelFormat.R32UI: 	return GL_R32UI;
        case PixelFormat.R32F: 		return GL_R32F;

        default: return 0;
    }
}

GLuint getFormat(PixelFormat formatEnum)
{
    switch(formatEnum)
    {
        case PixelFormat.NONE: return -1;

        //RGBA
        case PixelFormat.RGBA8:     return GL_RGBA;
        case PixelFormat.RGBA8I:    return GL_RGBA_INTEGER;
        case PixelFormat.RGBA8UI:   return GL_RGBA_INTEGER;
        case PixelFormat.RGBA16:    return GL_RGBA;
        case PixelFormat.RGBA16I:   return GL_RGBA_INTEGER;
        case PixelFormat.RGBA16UI:  return GL_RGBA_INTEGER;
        case PixelFormat.RGBA16F:   return GL_RGBA;
        case PixelFormat.RGBA32I:   return GL_RGBA_INTEGER;
        case PixelFormat.RGBA32UI:  return GL_RGBA_INTEGER;
        case PixelFormat.RGBA32F:   return GL_RGBA;

        //RGB
        case PixelFormat.RGB8: 	    return GL_RGB;
        case PixelFormat.RGB8I: 	return GL_RGB_INTEGER;
        case PixelFormat.RGB8UI: 	return GL_RGB_INTEGER;
        case PixelFormat.RGB16: 	return GL_RGB;
        case PixelFormat.RGB16I: 	return GL_RGB_INTEGER;
        case PixelFormat.RGB16UI: 	return GL_RGB_INTEGER;
        case PixelFormat.RGB16F: 	return GL_RGB;
        case PixelFormat.RGB32I: 	return GL_RGB_INTEGER;
        case PixelFormat.RGB32UI: 	return GL_RGB_INTEGER;
        case PixelFormat.RGB32F: 	return GL_RGB;

        //RG
        case PixelFormat.RG8: 	    return GL_RG;
        case PixelFormat.RG8I: 	    return GL_RG_INTEGER;
        case PixelFormat.RG8UI: 	return GL_RG_INTEGER;
        case PixelFormat.RG16: 	    return GL_RG;
        case PixelFormat.RG16I: 	return GL_RG_INTEGER;
        case PixelFormat.RG16UI: 	return GL_RG_INTEGER;
        case PixelFormat.RG16F: 	return GL_RG;
        case PixelFormat.RG32I: 	return GL_RG_INTEGER;
        case PixelFormat.RG32UI: 	return GL_RG_INTEGER;
        case PixelFormat.RG32F: 	return GL_RG;

        //R
        case PixelFormat.R8: 		return GL_RED;
        case PixelFormat.R8I: 		return GL_RED_INTEGER;
        case PixelFormat.R8UI: 		return GL_RED_INTEGER;
        case PixelFormat.R16: 		return GL_RED;
        case PixelFormat.R16I: 	    return GL_RED_INTEGER;
        case PixelFormat.R16UI: 	return GL_RED_INTEGER;
        case PixelFormat.R16F: 		return GL_RED;
        case PixelFormat.R24F: 		return GL_RED;
        case PixelFormat.R24I: 	    return GL_RED_INTEGER;
        case PixelFormat.R24UI: 	return GL_RED_INTEGER;
        case PixelFormat.R32I: 	    return GL_RED_INTEGER;
        case PixelFormat.R32UI: 	return GL_RED_INTEGER;
        case PixelFormat.R32F: 		return GL_RED;

        default: return 0;
    }
}

GLuint getFormatType(PixelFormat formatEnum)
{
    switch(formatEnum)
    {
        case PixelFormat.NONE: return -1;

        //RGBA
        case PixelFormat.RGBA8:     return GL_BYTE;
        case PixelFormat.RGBA8I:    return GL_BYTE;
        case PixelFormat.RGBA8UI:   return GL_UNSIGNED_BYTE;
        case PixelFormat.RGBA16:    return GL_SHORT;
        case PixelFormat.RGBA16I:   return GL_SHORT;
        case PixelFormat.RGBA16UI:  return GL_UNSIGNED_SHORT;
        case PixelFormat.RGBA16F:   return GL_HALF_FLOAT;
        case PixelFormat.RGBA32I:   return GL_INT;
        case PixelFormat.RGBA32UI:  return GL_UNSIGNED_INT;
        case PixelFormat.RGBA32F:   return GL_FLOAT;

        //RGB
        case PixelFormat.RGB8:     return GL_BYTE;
        case PixelFormat.RGB8I:    return GL_BYTE;
        case PixelFormat.RGB8UI:   return GL_UNSIGNED_BYTE;
        case PixelFormat.RGB16:    return GL_SHORT;
        case PixelFormat.RGB16I:   return GL_SHORT;
        case PixelFormat.RGB16UI:  return GL_UNSIGNED_SHORT;
        case PixelFormat.RGB16F:   return GL_HALF_FLOAT;
        case PixelFormat.RGB32I:   return GL_INT;
        case PixelFormat.RGB32UI:  return GL_UNSIGNED_INT;
        case PixelFormat.RGB32F:   return GL_FLOAT;

        //RG
        case PixelFormat.RG8:     return GL_BYTE;
        case PixelFormat.RG8I:    return GL_BYTE;
        case PixelFormat.RG8UI:   return GL_UNSIGNED_BYTE;
        case PixelFormat.RG16:    return GL_SHORT;
        case PixelFormat.RG16I:   return GL_SHORT;
        case PixelFormat.RG16UI:  return GL_UNSIGNED_SHORT;
        case PixelFormat.RG16F:   return GL_HALF_FLOAT;
        case PixelFormat.RG32I:   return GL_INT;
        case PixelFormat.RG32UI:  return GL_UNSIGNED_INT;
        case PixelFormat.RG32F:   return GL_FLOAT;

        //R
        case PixelFormat.R8:     return GL_BYTE;
        case PixelFormat.R8I:    return GL_BYTE;
        case PixelFormat.R8UI:   return GL_UNSIGNED_BYTE;
        case PixelFormat.R16:    return GL_SHORT;
        case PixelFormat.R16I:   return GL_SHORT;
        case PixelFormat.R16UI:  return GL_UNSIGNED_SHORT;
        case PixelFormat.R16F:   return GL_HALF_FLOAT;
        case PixelFormat.R32I:   return GL_INT;
        case PixelFormat.R32UI:  return GL_UNSIGNED_INT;
        case PixelFormat.R32F:   return GL_FLOAT;

        default: return -1;
    }
}
