/**
 * glDrawProgram.d
 * dockwork
 * July 24, 2013
 * Brandon Surmanski
 */

module dw.draw.gl.drawProgram;

import std.string;

import c.gl.gl;
import c.gl.glext;

public import dw.draw.drawProgram;

import dw.draw.gl.drawShader;
import dw.draw.gl.drawDevice;

class GLDrawProgram : DrawProgram
{
    private:
        bool _dirty = true;
        GLuint _program;
        GLDrawShader[5] _shaders = [null];

        void clean()
        {
            if(_dirty)
            {
                foreach(shader; _shaders)
                {
                    if(shader)
                    {
                        glAttachShader(_program, (cast(GLDrawShader)shader).shaderId); 
                    }
                }
                glLinkProgram(_program);
                _dirty = false;
            }
        }

    public:
        @property GLuint glID() { clean(); return _program; }

        void setStage(ShaderStage stage, GLDrawShader shader)
        {
            if(_shaders[stage])
            {
                //TODO: shaders subtype some refcount type
                //TODO: release shaders[i]
                glDetachShader(_program, shader.shaderId);
            }

            _shaders[stage] = shader;
            _dirty = true;
        }

        this(DrawDevice device, string vshader, string fshader)
        {
            super(device); 
            _program = glCreateProgram();
            //XXX createDrawShader instead of new
            GLDrawShader glvShader = new GLDrawShader(device, ShaderStage.VERTEX, vshader);
            GLDrawShader glfShader = new GLDrawShader(device, ShaderStage.FRAGMENT, fshader);
            setStage(ShaderStage.VERTEX, glvShader);
            setStage(ShaderStage.FRAGMENT, glfShader);
        }

        this(DrawDevice device, GLDrawShader vshader, GLDrawShader fshader)
        {
            super(device);
            _program = glCreateProgram();
            setStage(ShaderStage.VERTEX, vshader);
            setStage(ShaderStage.FRAGMENT, fshader);
        }

        /**
         * TODO: parse output order. should not need to do this crap
         */
        void setOutputNames(string outputs[])
        {
            foreach(uint i, name; outputs)
            {
                glBindFragDataLocation(_program, i, name.toStringz());
            }

            _dirty = true;
        }
}
