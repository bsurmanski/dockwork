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
import std.conv;

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
        GLDrawProgram _defaultProgram;
        static string TESTVS = import("dw/draw/gl/glsl/test.vs");
        static string TESTFS = import("dw/draw/gl/glsl/test.fs");

    public:

        this()
        {
            glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
            glDisable(GL_BLEND);
            glDisable(GL_CULL_FACE);
            glDisable(GL_DEPTH_TEST);
            glDisable(GL_SCISSOR_TEST);
            glEnable(GL_TEXTURE_CUBE_MAP_SEAMLESS);
            glDepthFunc(GL_LEQUAL);
            glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

            /*
            */

            scope Mesh FSMESH = new Mesh(FSQUAD_VERTS, FSQUAD_FACES);
            _fsQuad = new GLDrawMesh(this, FSMESH);
            _meshProgram = new GLDrawProgram(this, TESTVS, TESTFS);
            _defaultProgram = new GLDrawProgram(this, import("dw/draw/gl/glsl/default.vs"), 
                                                      import("dw/draw/gl/glsl/default.fs"));
        }

        /**
         * DrawMesh
         */

        override DrawMesh createDrawMesh(Mesh mesh)
        {
            return new GLDrawMesh(this, mesh);
        }

        /**
         * Programs
         */

        //TODO: create program?

        override @property void program(DrawProgram program)
        {
            super.program(program);
            auto glProgram = cast(GLDrawProgram) program;
            if(!glProgram)
            {
                glUseProgram(0);
            }
            glUseProgram(glProgram.glID); 
        }

        /**
         * BAD
         */

        GLuint _primitiveQuery;
        int _nprims;

        void beginPrimitiveCount()
        {
            glGenQueries(1, &_primitiveQuery);
            glBeginQuery(GL_PRIMITIVES_GENERATED, _primitiveQuery);
        }

        void endPrimitiveCount()
        {
            glEndQuery(GL_PRIMITIVES_GENERATED); 
            glGetQueryObjectiv(_primitiveQuery, GL_QUERY_RESULT, &_nprims);
        }

        uint primitivesGenerated()
        {
            return _nprims;
        }

        void textureTarget(uint n, Texture texture)
        {
            GLTexture gtex = cast(GLTexture) texture;
        
        }

        /**
         * ENDBAD
         */

        override @property void framebuffer(Framebuffer fb)
        {
            if(!fb) { glBindFramebuffer(GL_FRAMEBUFFER, 0); return; }

            GLFramebuffer glfb = cast(GLFramebuffer) fb; 
            if(!glfb) { throw new Exception("Invalid framebuffer for current device");}
            glBindFramebuffer(GL_FRAMEBUFFER, glfb.glID);

            GLint maxDrawBuffers;
            glGetIntegerv(GL_MAX_DRAW_BUFFERS, &maxDrawBuffers);
            if(fb.renderTargets.length > maxDrawBuffers)
            {
                string excp = "Framebuffer has more than MAX_DRAW_BUFFERS (" ~
                    to!string(maxDrawBuffers) ~ 
                    "), buffers";
                throw new Exception(excp);
            }
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
            glDrawBuffers(cast(int) fb.renderTargets.length, glBuffers.ptr);
            super.framebuffer(fb);
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

            // program (bound)
            // framebuffer (bound)
            // texture units (bound)
            // uniforms (from function?)
            // VAO (from model)
            
            //XXX TMP
            this.program = _meshProgram;
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
            return new GLTexture(this, w, h, pFormat);
        }

        override GLTexture createTexture(Image image)
        {
            return new GLTexture(this, image);
        }

        /**
         * Framebuffer
         */
        override GLFramebuffer createFramebuffer(uint w, uint h, 
                DepthFormat dFormat = DepthFormat.DEPTH_24,
                StencilFormat sFormat = StencilFormat.STENCIL_8)
        {
            return new GLFramebuffer(this, w, h, dFormat, sFormat);
        }

        /**
         * RenderTarget
         */
        override GLRenderTarget createDepthStencilRenderTarget(uint w, uint h, 
                DepthFormat dFormat, StencilFormat sFormat)
        {
            return new GLRenderTarget(this, w, h, dFormat, sFormat); 
        }

        override GLRenderTarget createDepthRenderTarget(uint w, uint h, DepthFormat dFormat)
        {
            return new GLRenderTarget(this, w, h, dFormat);
        }

        override GLRenderTarget createStencilRenderTarget(uint w, uint h, StencilFormat sFormat)
        {
            return new GLRenderTarget(this, w, h, sFormat);
        }

        override GLRenderTarget createRenderTarget(uint w, uint h, 
                    PixelFormat pFormat)
        {
            return new GLRenderTarget(this, w, h, pFormat); 
        }
}
