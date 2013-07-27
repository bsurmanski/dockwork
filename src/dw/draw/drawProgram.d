/**
 * drawProgram.d
 * dockwork
 * July 18, 2013
 * Brandon Surmanski
 */

module dw.draw.drawProgram;

import dw.draw.drawDevice;

abstract class DrawProgram
{
    private:
    DrawDevice _device;

    public:
    this(DrawDevice device)
    {
        _device = device;
    }

    this(string vshader, string fshader);
}
