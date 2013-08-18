/**
 * glDrawDevice
 * dockwork
 * July 18, 2013
 * Brandon Surmansk
 */

module dw.draw.gl.glDrawDevice;

import c.gl.gl;
import c.gl.glext;
import c.glfw.glfw;

import std.string;

import dw.math.matrix;

public 
import dw.draw.drawDevice;

import dw.draw.drawLamp;
import dw.draw.pixelFormat;
import dw.draw.model;
import dw.draw.gl.glFramebuffer;
import dw.draw.gl.glRenderTarget;
import dw.draw.gl.glTexture;
import dw.draw.gl.glDrawMesh;
import dw.resource.image;

class GLDrawDevice : DrawDevice
{
    protected:

        GLDrawMesh _fsQuad; //Fullscreen quad TODO

    public:

        this()
        {
            glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
            glEnable(GL_BLEND);
            glEnable(GL_CULL_FACE);
            glEnable(GL_DEPTH_TEST);
            glEnable(GL_TEXTURE_CUBE_MAP_SEAMLESS);
            glDepthFunc(GL_LEQUAL);
            glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

            uint[] glBuffers = 
                [
                    GL_COLOR_ATTACHMENT0,
                    GL_COLOR_ATTACHMENT1,
                    GL_COLOR_ATTACHMENT2,
                    GL_COLOR_ATTACHMENT3,
                    GL_COLOR_ATTACHMENT4,
                    GL_COLOR_ATTACHMENT5,
                    GL_COLOR_ATTACHMENT6,
                    GL_COLOR_ATTACHMENT7,
                    GL_COLOR_ATTACHMENT8,
                    GL_COLOR_ATTACHMENT9,
                    GL_COLOR_ATTACHMENT10,
                    GL_COLOR_ATTACHMENT11,
                    GL_COLOR_ATTACHMENT12,
                    GL_COLOR_ATTACHMENT13,
                    GL_COLOR_ATTACHMENT14,
                    GL_COLOR_ATTACHMENT15,
                ];
            glDrawBuffers(16, glBuffers.ptr);
        }

        /*
        void swapBuffers()
        {
            //TODO: draw framebuffer contents to default gl surface
        }
        */

        /**
         * model
         */
        override void draw(Model model)
        {
            Matrix4 vpMatrix = activeCamera().matrix(); 
            foreach(part; model)
            {
                Matrix4 mvpMatrix = part.matrix() * vpMatrix; 
                //program bind textures
                //program bind uniforms
                //program bind buffers/vao
                //TODO: program.draw
            }
        }

        /**
         * lighting
         */
        override void apply(DrawLamp lamp)
        {
            switch(lamp.type)
            {
                case LampType.POINT: //TODO bind lamp shaders
                case LampType.SUN:
                case LampType.SPOT:
                default:
                    throw new Exception("Unknown lamp type"); //TODO: actual exception type
            }
            //TODO: uniforms ... (OR, alt, only change uniforms when needed)
            //TODO: bind fullscreen quad
            //TODO: draw command
            //TODO: unbind all
        }

        /**
         * Texture
         */
        override GLTexture createTexture(uint w, uint h, PixelFormat pFormat)
        {
            return new GLTexture(w, h, pFormat);
        }

        override GLTexture createTexture(Image image)
        {
            return new GLTexture(image);
        }

        /**
         * Framebuffer
         */
        override GLFramebuffer createFramebuffer(uint w, uint h, 
                DepthFormat dFormat = DepthFormat.DEPTH_24,
                StencilFormat sFormat = StencilFormat.STENCIL_8)
        {
            return new GLFramebuffer(w, h, dFormat, sFormat);
        }

        /**
         * RenderTarget
         */
        override GLRenderTarget createDepthStencilRenderTarget(uint w, uint h, 
                DepthFormat dFormat, StencilFormat sFormat)
        {
            return new GLRenderTarget(w, h, dFormat, sFormat); 
        }

        override GLRenderTarget createDepthRenderTarget(uint w, uint h, DepthFormat dFormat)
        {
            return new GLRenderTarget(w, h, dFormat);
        }

        override GLRenderTarget createStencilRenderTarget(uint w, uint h, StencilFormat sFormat)
        {
            return new GLRenderTarget(w, h, sFormat);
        }

        override GLRenderTarget createRenderTarget(uint w, uint h, 
                    PixelFormat pFormat)
        {
            return new GLRenderTarget(w, h, pFormat); 
        }
}
