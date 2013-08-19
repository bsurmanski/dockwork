/**
 * glDrawMesh
 * dockwork
 * July 18, 2013
 * Brandon Surmanski
 */

module dw.draw.gl.drawMesh;

import c.gl.gl;
import c.gl.glext;

public import dw.draw.drawMesh;
import dw.draw.gl.drawDevice;
import dw.resource.mesh;

class GLDrawMesh : DrawMesh 
{
    GLuint _ibuffer; // index buffer
    GLuint _vbuffer; // vertex buffer
    GLuint _vao;

    this(MeshType mesh)
    {
        super(GLDrawDevice.instance, mesh.nVerts, mesh.nFaces);

        glGenVertexArrays(1, &_vao);
        glBindVertexArray(_vao);
        glGenBuffers(1, &_ibuffer);
        glGenBuffers(1, &_vbuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _ibuffer);
        glBindBuffer(GL_ARRAY_BUFFER, _vbuffer);

        // index buffer
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, 
                     mesh.faceSize,
                     mesh.facePtr,
                     GL_STATIC_DRAW);

        // vertex buffer
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, 
                     mesh.vertSize,
                     mesh.vertPtr,
                     GL_STATIC_DRAW);

        //TODO: set vertex attributes for VAO
        //glGetAttribLocation
        //glEnableVertexAttribArray
        //glVertexAttribPointer
        glBindVertexArray(0);
    }

    override Mesh toMesh()
    {
        //TODO
        return null;
    }

    override void writeToMesh(Mesh mesh)
    {
        //TODO 
    }
}
