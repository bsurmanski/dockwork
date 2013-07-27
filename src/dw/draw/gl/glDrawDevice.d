/**
 * glDrawDevice
 * dockwork
 * July 18, 2013
 * Brandon Surmansk
 */

module dw.draw.gl.glDrawDevice;

import c.gl.gl;
import c.gl.glext;
import c.gl.glfw;

import dw.math.matrix;

public import dw.draw.drawDevice;

import dw.draw.drawLamp;
import dw.draw.pixelFormat;
import dw.draw.model;
import dw.draw.image;
import dw.draw.gl.glFramebuffer;
import dw.draw.gl.glRenderTarget;
import dw.draw.gl.glTexture;

class GLDrawDevice : DrawDevice
{
    static DrawDevice _instance= null;

    static DrawDevice instance() 
    { 
        if(!_instance)
        { 
            _instance = new GLDrawDevice(defaultWidth, defaultHeight);
            _instance.activeFramebuffer = _instance.createFramebuffer(defaultWidth, defaultHeight);
        }

        return _instance; 
    }

    this(uint w, uint h)
    {
        super(w, h);
        glfwInit();
        glfwOpenWindowHint(GLFW_OPENGL_VERSION_MAJOR, 3);
        glfwOpenWindowHint(GLFW_OPENGL_VERSION_MINOR, 0);
        glfwOpenWindowHint(GLFW_WINDOW_NO_RESIZE, true);
        glfwOpenWindow(w, h, 8, 8, 8, 8, 32, 0, GLFW_WINDOW);
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

    override void swapBuffers()
    {
        //TODO: draw framebuffer contents to default gl surface
        glfwSwapBuffers();
    }

    override void clear()
    {
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT); 
    }

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
    override void apply(DrawLamp lamp){}

    /**
     * Texture
     */
    override Texture createTexture(uint w, uint h, PixelFormat pFormat)
    {
        return new GLTexture(w, h, pFormat);
    }

    override Texture createTexture(Image image)
    {
        return new GLTexture(image);
    }

    /**
     * Framebuffer
     */
    override Framebuffer createFramebuffer(uint w, uint h, 
            DepthFormat dFormat = DepthFormat.DEPTH_24,
            StencilFormat sFormat = StencilFormat.STENCIL_8)
    {
        return new GLFramebuffer(w, h, dFormat, sFormat);
    }

    /**
     * RenderTarget
     */
    override RenderTarget createDepthStencilRenderTarget(uint w, uint h, 
            DepthFormat dFormat, StencilFormat sFormat)
    {
        return new GLRenderTarget(w, h, dFormat, sFormat); 
    }

    override RenderTarget createDepthRenderTarget(uint w, uint h, DepthFormat dFormat)
    {
        return new GLRenderTarget(w, h, dFormat);
    }

    override RenderTarget createStencilRenderTarget(uint w, uint h, StencilFormat sFormat)
    {
        return new GLRenderTarget(w, h, sFormat);
    }

    override RenderTarget createRenderTarget(uint w, uint h, 
                PixelFormat pFormat)
    {
        return new GLRenderTarget(w, h, pFormat); 
    }
}
