/**
 * window.d
 * dockwork
 * August 18, 2013
 * Brandon Surmanski
 */

module dw.system.window;

abstract class Window
{
    private:
        uint _width;
        uint _height;
        bool _hidden;
        string _name;

    public:
        @property void width(uint w){ _width = w; }
        @property uint width() { return _width; }
        @property void height(uint h) { _height = h; }
        @property uint height() { return _height; }
        @property void name(string n) { _name = n; }
        @property string name() { return _name; }

        @property void hidden(bool h) { _hidden = h; }
        @property bool hidden() { return _hidden; }

        this(uint w, uint h, string name)
        {
            _width = w;
            _height = h;
            _name = name;
        }

        void focus();
        void swapBuffers();
        void clear();
}
