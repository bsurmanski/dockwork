/**
 * glDrawDevice
 * dockwork
 * July 18, 2013
 * Brandon Surmansk
 */

module dw.draw.gl.drawDevice;

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
import dw.draw.gl.drawProgram;
import dw.draw.gl.framebuffer;
import dw.draw.gl.renderTarget;
import dw.draw.gl.texture;
import dw.draw.gl.drawMesh;
import dw.resource.image;
import dw.resource.mesh;

class GLDrawDevice : DrawDevice
{
    protected:
        static Vertex FSQUAD_VERTS[4] = [
                    {[-1,-1,0],[0,0,short.max],[0,0],0},
                    {[ 1,-1,0],[0,0,short.max],[ushort.max,0],0},
                    {[ 1, 1,0],[0,0,short.max],[ushort.max,ushort.max],0},
                    {[-1, 1,0],[0,0,short.max],[0,ushort.max],0}];
        static Face FSQUAD_FACES[2] = [{[0,1,2]}, {[0,2,3]}];

        GLDrawMesh _fsQuad; //Fullscreen quad TODO
        GLDrawProgram _meshProgram;
        string TESTVS = import("dw/draw/gl/glsl/test.vs");
        string TESTFS = import("dw/draw/gl/glsl/test.fs");

    public:

        this()
        {
            super();
            glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
            glDisable(GL_BLEND);
            glDisable(GL_CULL_FACE);
            glDisable(GL_DEPTH_TEST);
            glDisable(GL_SCISSOR_TEST);
            glEnable(GL_TEXTURE_CUBE_MAP_SEAMLESS);
            glDepthFunc(GL_LEQUAL);
            glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

            /*
            GLint maxDrawBuffers;
            glGetIntegerv(GL_MAX_DRAW_BUFFERS, &maxDrawBuffers);
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
            glDrawBuffers(maxDrawBuffers, glBuffers.ptr);
            */

            scope Mesh FSMESH = new Mesh(FSQUAD_VERTS, FSQUAD_FACES);
            _fsQuad = new GLDrawMesh(FSMESH);
            _meshProgram = new GLDrawProgram(TESTVS, TESTFS);
        }

        /*
        void swapBuffers()
        {
            //TODO: draw framebuffer contents to default gl surface
        }
        */

        override @property void framebuffer(Framebuffer fb)
        {
            super.framebuffer(fb);
            if(!fb) { glBindFramebuffer(GL_FRAMEBUFFER, 0); return; }

            GLFramebuffer glfb = cast(GLFramebuffer) fb; 
            if(!glfb) { throw new Exception("Invalid framebuffer for current device");}
            glBindFramebuffer(GL_FRAMEBUFFER, glfb.glID);
        }

        /**
         * model
         */
        override void draw(Model model)
        {
            //Matrix4 vpMatrix = camera().matrix(); 
            //foreach(part; model)
            {
                //Matrix4 mvpMatrix = part.matrix() * vpMatrix;
                //program bind textures
                //program bind uniforms
                //program bind buffers/vao
                //TODO: program.draw
            }
            GLuint query;
            glGenQueries(1, &query);
            glBeginQuery(GL_PRIMITIVES_GENERATED, query);

            //XXX TMP
            glUseProgram(_meshProgram.glID);
            glBindVertexArray(_fsQuad.vao);
            GLuint pos_uint = glGetAttribLocation(_meshProgram.glID, "position");
            GLuint uv_uint = glGetAttribLocation(_meshProgram.glID, "uv");
            glEnableVertexAttribArray(pos_uint);
            glEnableVertexAttribArray(uv_uint);
            glVertexAttribPointer(pos_uint, 3, GL_FLOAT, GL_FALSE, 
                    Vertex.sizeof, cast(void*)0);
            glVertexAttribPointer(uv_uint, 2, GL_UNSIGNED_SHORT, GL_TRUE, 
                    Vertex.sizeof, cast(void*)18);
            glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_SHORT, null);

            glEndQuery(GL_PRIMITIVES_GENERATED);
            int nprims;
            glGetQueryObjectiv(query, GL_QUERY_RESULT, &nprims);
            import std.stdio;
            writeln("PRIMS ", nprims);
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
