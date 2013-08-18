/**
 * drawDevice
 * dockwork
 * July 18, 2013
 * Brandon Surmanski
 */

module dw.draw.drawDevice;

import dw.draw.framebuffer;
import dw.draw.renderTarget;
import dw.draw.pixelFormat;
import dw.draw.model;
import dw.draw.texture;
import dw.draw.drawCamera;
import dw.draw.drawLamp;
import dw.draw.drawProgram;
import dw.math.matrix;
import dw.math.vector;
import dw.resource.image;

abstract class DrawDevice
{
    private:
        static DrawDevice _instance = null;

        Matrix4 _mMatrix; 
        Matrix4 _vMatrix; //TODO: just use camera v/p matrix instead
        Matrix4 _pMatrix;
        Vec4 _ambient;
        DrawCamera _activeCamera;
        Framebuffer _activeFramebuffer;

        //TODO: all these programs?
        DrawProgram _modelProgram;
        DrawProgram _ambientLightProgram;
        DrawProgram _sunLightProgram;
        DrawProgram _spotLightProgram;
        DrawProgram _pointLightProgram;

    public:

        static DrawDevice instance() 
        { 
            if(!_instance)
            { 
                throw new Exception("DrawDevice not initialized");
            }

            return _instance; 
        }

        this()
        {
            _instance = this;
        }

        @property
        void activeCamera(DrawCamera cam)
        {
            _activeCamera = cam; 
        }

        @property DrawCamera activeCamera() { return _activeCamera; }

        @property void activeFramebuffer(Framebuffer fb) { _activeFramebuffer = fb; }
        @property Framebuffer activeFramebuffer() { return _activeFramebuffer; }

        /**
         * Model
         */

        void draw(Model model);

        /**
         * lighting
         */
        void apply(DrawLamp lamp);

        /**
         * Texture
         */
        Texture createTexture(uint w, uint h, PixelFormat pFormat);
        Texture createTexture(Image image);

        /**
         * Framebuffer
         */

        Framebuffer createFramebuffer(uint w, uint h, 
                DepthFormat dFormat = DepthFormat.DEPTH_24, 
                StencilFormat sFormat = StencilFormat.STENCIL_8);

        /**
         * RenderTarget
         */

        RenderTarget createDepthStencilRenderTarget(uint w, uint h, 
                DepthFormat dFormat, StencilFormat sFormat);

        RenderTarget createDepthRenderTarget(uint w, uint h, 
                DepthFormat dFormat);

        RenderTarget createStencilRenderTarget(uint w, uint h, 
                StencilFormat sFormat);

        RenderTarget createRenderTarget(uint w, uint h, 
                PixelFormat pFormat);
}
