/**
 * drawShader.d
 * dockwork
 * July 26, 2013
 * Brandon Surmanski
 */

module dw.draw.drawShader;

import dw.draw.drawDevice;

enum ShaderStage
{
    GEOMETRY = 0,
    VERTEX,
    FRAGMENT,
}

class ShaderCompileException : Exception
{
    this(string msg)
    {
        super(msg);
    }
}

abstract class DrawShader
{
    protected:
        DrawDevice _device;
        ShaderStage _stage;

        this(DrawDevice device)
        {
            _device = device;
        }

    public:
        @property ShaderStage stage() { return _stage; }
}
