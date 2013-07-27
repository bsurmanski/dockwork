/**
 * renderTarget.d
 * dockwork
 * July 18, 2013
 * Brandon Surmanski
 */

module dw.draw.renderTarget;

import dw.draw.pixelFormat;

abstract class RenderTarget 
{
    private:
        TargetType _type;
    protected:


    public:

    enum TargetType
    {
        COLOR,
        DEPTH,
        STENCIL,
        DEPTH_STENCIL,
    }

    @property uint width();
    @property uint height();
    @property TargetType type() { return _type; }

    bool isColorTarget() { return type == TargetType.COLOR; }
    bool isDepthTarget() { return type == TargetType.DEPTH; }
    bool isStencilTarget() { return type == TargetType.STENCIL; }
    bool isDepthStencilTarget() { return type == TargetType.DEPTH_STENCIL; }

    this(TargetType type)
    {
        _type = type;
    }
}
