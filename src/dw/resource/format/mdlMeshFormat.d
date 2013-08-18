/**
 * mdlMeshFormat.d
 * dockwork
 * July 30, 2013
 * Brandon Surmanski
 */

module dw.resource.format.mdlMeshFormat;

import std.stdio;

public 
import dw.resource.format.resourceFileFormat;
import dw.resource.resource;
import dw.resource.mesh;

class MdlMeshFormat : ResourceFileFormat
{
    private:
        static MdlMeshFormat _instance = null;
        static const VERSION = 5;

        struct Header
        {
            char  magic[3];
            ubyte ver;
            uint  nverts;
            uint  nfaces;
            char  name[16];
            ubyte PADDING[4];
        } unittest
        {
            assert(Header.sizeof == 32);
        }

        this(){}

    public:
        static @property MdlMeshFormat instance()
        {
            if(!_instance)
            {
                _instance = new MdlMeshFormat();
            }
            return _instance; 
        }

        override bool valid(File file, size_t max = 0)
        {
            size_t offset = file.tell();
            if(!max || max < Header.sizeof) return false;

            Header header;
            file.rawRead((&header)[0..1]);
            file.seek(offset); // seek back to start of header
            return header.magic == "MDL" && header.ver == VERSION;
        }

        override Mesh read(File file, size_t max = 0)
        {
            Mesh mesh = new Mesh(); 

            assert(!max || max > Header.sizeof);

            Header header;
            file.rawRead((&header)[0..1]);
            assert(!max || max > Header.sizeof + 
                    header.nverts * Vertex.sizeof + 
                    header.nfaces * Face.sizeof);
            
            //XXX assumtion on Vertex format...
            scope Vertex[] verts = new Vertex[header.nverts];
            scope Face[] faces = new Face[header.nfaces];
            file.rawRead(verts);
            file.rawRead(faces);
            mesh.add(verts);
            mesh.add(faces);

            return mesh;
        }

        override void write(Resource res, File file, size_t max = 0)
        {
            Mesh mesh = cast(Mesh)res;
            assert(mesh);

            char[16] name;
            name[0 .. mesh.name.length] = mesh.name;
            name[mesh.name.length .. 16] = '\0';

            Header header = 
            {
                "MDL",
                VERSION,
                mesh.nVerts,
                mesh.nFaces,
                name
            };

            assert(!max || max <= (header.sizeof + mesh.vertSize + mesh.faceSize));
            file.write(header);
            file.write(mesh.vertices);
            file.write(mesh.faces);
        }
}
