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
    this(); //XXX why is this needed?
    this(uint w, uint h, PixelFormat pFormat);
    this(uint w, uint h, DepthFormat dFormat);
    this(uint w, uint h, StencilFormat sFormat);
    this(uint w, uint h, DepthFormat dFormat, StencilFormat sFormat);
}
