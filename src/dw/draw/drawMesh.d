/**
 * drawMesh.d
 * dockwork
 * July 21, 2013
 * Brandon Surmanski
 */

module dw.draw.drawMesh;

import dw.draw.drawDevice;
import dw.resource.mesh;

abstract class DrawMesh
{
    protected:
        uint _nverts;
        uint _nfaces;
        DrawDevice _device;
        this(DrawDevice device, uint nverts, uint nfaces)
        {
            _device = device;
            _nverts = nverts;
            _nfaces = nfaces;
        }

    public:
        @property uint nVerts() { return _nverts; }
        @property uint nFaces() { return _nfaces; }

        this(Mesh mesh);
        Mesh toMesh();
        void writeToMesh(Mesh mesh);
}
