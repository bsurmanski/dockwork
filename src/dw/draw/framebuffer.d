/**
 * framebuffer
 * dockwork
 * July 18, 2013
 * Brandon Surmanski
 */

module dw.draw.framebuffer;

import dw.draw.pixelFormat;
import dw.draw.renderTarget;
import dw.draw.drawDevice;

abstract class Framebuffer
{
    private:
        uint _width;
        uint _height;
        DepthFormat _depthFormat;
        StencilFormat _stencilFormat;
        RenderTarget _rtargets[];
        DrawDevice _device;

    public:

        @property RenderTarget[] renderTargets() { return _rtargets; }

        bool isDepthStencilCombined(DepthFormat depth, StencilFormat stencil)
        {
            return depth == DepthFormat.DEPTH_24 && stencil == StencilFormat.STENCIL_8;
        }

        bool isDepthBufferRequired(DepthFormat depth)
        {
            return depth != DepthFormat.DEPTH_0;
        }

        bool isStencilBufferRequired(StencilFormat stencil)
        {
            return stencil != StencilFormat.STENCIL_0;
        }

        this(DrawDevice device, uint w, uint h, 
            DepthFormat dFormat = DepthFormat.DEPTH_24, 
            StencilFormat sFormat = StencilFormat.STENCIL_8)
        {
            _device = device;
            _width = w;
            _height = h;
            _depthFormat = dFormat;
            _stencilFormat = sFormat;

            if(isDepthStencilCombined(dFormat, sFormat))
            {
                _rtargets ~= device.createDepthStencilRenderTarget(w, h, dFormat, sFormat);
            } else
            {
                if(isDepthBufferRequired(dFormat))
                {
                    _rtargets ~= device.createDepthRenderTarget(w, h, dFormat);
                }

                if(isStencilBufferRequired(sFormat))
                {
                    _rtargets ~= device.createStencilRenderTarget(w, h, sFormat);
                }
            }
        }

        void bind(uint attachment, RenderTarget target)
        {
            if(_rtargets.length <= attachment)
            {
                _rtargets.length = attachment + 1;
            }

            _rtargets[attachment] = target;
        }
}
