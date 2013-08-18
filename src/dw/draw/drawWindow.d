/**
 * drawWindow.d
 * dockwork
 * August 18, 2013
 * Brandon Surmanski
 */

module dw.draw.drawWindow;

abstract class DrawWindow
{
    private:
        uint _width;
        uint _height;
        string _name;

    public:
        @property void width(uint w){ _width = w; }
        @property uint width() { return _width; }
        @property void height(uint h) { _height = h; }
        @property uint height() { return _height; }
        @property void name(string n) { _name = n; }
        @property string name() { return _name; }

        void swapBuffers();
        void clear();
}
