/**
 * glDrawProgram.d
 * dockwork
 * July 24, 2013
 * Brandon Surmanski
 */

module dw.draw.gl.glDrawProgram;

import std.string;

import c.gl.gl;
import c.gl.glext;

public import dw.draw.drawProgram;

import dw.draw.gl.glDrawShader;
import dw.draw.gl.glDrawDevice;

class GLDrawProgram : DrawProgram
{
    private:
        bool _dirty = true;
        GLuint _program;
        GLDrawShader[5] _shaders = [null];

        void clean()
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

    public:
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

        this(string vshader, string fshader)
        {
            super(GLDrawDevice.instance); 
            _program = glCreateProgram();
            GLDrawShader glvShader = new GLDrawShader(ShaderStage.VERTEX, vshader);
            GLDrawShader glfShader = new GLDrawShader(ShaderStage.FRAGMENT, fshader);
            setStage(ShaderStage.VERTEX, glvShader);
            setStage(ShaderStage.FRAGMENT, glfShader);
        }

        this(GLDrawShader vshader, GLDrawShader fshader)
        {
            super(GLDrawDevice.instance);
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
