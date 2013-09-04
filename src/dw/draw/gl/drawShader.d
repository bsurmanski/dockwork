/**
 * glDrawShader.d
 * dockwork
 * July 25, 2013
 * Brandon Surmanski
 */

module dw.draw.gl.drawShader;

import std.conv;
import std.stdio;
import std.string;

import c.gl.gl;
import c.gl.glext;

public import dw.draw.drawShader;

import dw.draw.gl.drawDevice;

class GLDrawShader : DrawShader
{
    private:
        bool _dirty = true;
        GLuint _shader;
        ShaderStage _stage;
        string _source;

        static GLuint[3] glShaderStages = [GL_GEOMETRY_SHADER, GL_VERTEX_SHADER, GL_FRAGMENT_SHADER]; 

        void compile()
        {
            scope const(char) *sourcez = _source.toStringz();
            glShaderSource(_shader, 1, &sourcez, null);
            glCompileShader(_shader);

            GLint cstatus;
            glGetShaderiv(_shader, GL_COMPILE_STATUS, &cstatus);

            if(cstatus == GL_FALSE)
            {
                int bufsz = 512;
                scope char[] buf = new char[bufsz];
                buf[] = 0;
                glGetShaderInfoLog(_shader, bufsz, null, buf.ptr);
                throw new ShaderCompileException(to!string(buf));
            }
        
        }

        void clean()
        {
            if(_dirty)
            {
                compile();
                _dirty = false;
            }
        }

    public:

        @property GLuint shaderId()
        { 
            clean();
            return _shader;
        }

        this(DrawDevice device, ShaderStage stage, File file, size_t sz = 0)
        {
            super(device);
            _stage = stage;
            _shader = glCreateShader(glShaderStages[_stage]);
            if(sz == 0)
            {
                sz = file.size() - file.tell();
            }
            scope char[] buf = new char[sz];
            file.rawRead(buf); /// not really fond of D's file handling
            _source = to!string(buf);
            clean();
        }

        this(DrawDevice device, ShaderStage stage, string source)
        {
            super(device);
            _stage = stage;
            GLuint glStage = glShaderStages[stage];
            _shader = glCreateShader(glStage);
            _source = source;
            clean();
        }
}
