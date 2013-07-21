/**
 * texture.d
 * dockwork
 * July 18, 2013
 * Brandon Surmanski
 */

module dw.draw.texture;

import dw.draw.image;

abstract class Texture
{
    protected:
        uint _width;
        uint _height;
        this(uint w, uint h)
        {
            _width = w;
            _height = h;
        }
    public:
        @property uint width() { return _width; }
        @property uint height() { return _height; }

        this(Image image);
        Image toImage(){return null;}
        void writeToImage(Image image) {}
}
