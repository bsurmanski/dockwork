/**
 * glMesh
 * dockwork
 * July 18, 2013
 * Brandon Surmanski
 */

module dw.draw.gl.glMesh;

import c.gl.gl;

public import dw.draw.drawMesh;

class GLMesh : DrawMesh 
{
    GLuint ibuffer; // index buffer
    GLuint vbuffer; // vertex buffer
}
