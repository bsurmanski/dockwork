/**
 * drawDevice
 * dockwork
 * July 18, 2013
 * Brandon Surmanski
 */

module dw.draw.drawDevice;

import dw.draw.model;
import dw.draw.drawLamp;
import dw.draw.framebuffer;
import dw.draw.renderTarget;
import dw.draw.pixelFormat;
import dw.draw.texture;
import dw.draw.drawCamera;
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
        DrawCamera _camera;
        Framebuffer _framebuffer; //active framebuffer
        DrawProgram _program; // active program

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

        @property void camera(DrawCamera cam){ _camera = cam; }
        @property DrawCamera camera() { return _camera; }

        @property void framebuffer(Framebuffer fb) { _framebuffer = fb; }
        @property Framebuffer framebuffer() { return _framebuffer; }

        @property void program(DrawProgram prog) { _program = prog; }
        @property DrawProgram program() { return _program; }

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
