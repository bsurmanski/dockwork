/**
 * image.d
 * dockwork
 * July 19, 2013
 * Brandon Surmanski
 */

module dw.draw.image;

import dw.draw.pixelFormat;

class Image
{
    private:
        uint _dim[3];
        uint _bitDepth;
        byte[] _pixels;

    public:

        this(uint x, uint y, uint z, byte[] pixels, 
        PixelFormat dataFormat)
        {
            _dim[0..2] = [x,y,z]; 
            //_bitDepth = PixelFormat.bitDepth(dataFormat);
            _pixels = pixels.dup;
        }

        @property uint width()
        {
            return _dim[0]; 
        }

        @property uint height()
        {
            return _dim[1]; 
        }

        @property uint depth()
        {
            return _dim[2]; 
        }

        @property uint bitDepth()
        {
            return _bitDepth;
        }

        @property uint byteDepth()
        {
            return _bitDepth / 8;
        }

        @property uint pitch()
        {
            return _dim[0] * byteDepth();
        }

        @property uint size()
        {
            return _dim[0] * _dim[1] * _dim[2] * byteDepth;
        }

        @property byte[] pixels()
        {
            return _pixels;
        }

        byte *pixelPtr(uint x, uint y, uint z)
        {
            return &_pixels[(z * _dim[1] * _dim[0] + y * _dim[0] + x) * byteDepth()];
        }

        //setPixel(x,y,z,IVec3)
        //setPixel(x,y,z,Vec3)
        //IVec3 getPixel(x,y,z)
        //Vec3 getPixelNorm(x,y,z)
        //fill(Vec3)
        //drawLine(start, end, color)
        //resize(w,h)
        //crop(w,h)
        //flip(..)
        //rotate(..)
}
