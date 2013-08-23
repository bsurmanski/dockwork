/**
 * mesh.d
 * tower
 * April 25, 2013
 * Brandon Surmanski
 */

module dw.resource.mesh;

import std.file;
import std.stdio;
import std.conv;

public 
import dw.resource.resource;

import dw.resource.format.mdlMeshFormat;
import dw.resource.resourceType;

import dw.math.vector;
import dw.math.matrix;

struct Vertex
{
    float position[3];
    short normal[3];
    ushort uv[2];
    ushort material;
    //ubyte id[2];    //bone id, position, etc 
    //ubyte weight[2];
    //ubyte PADDING[4];
    uint id[2];
} unittest
{
    assert(Vertex.sizeof == 32);
}


struct Face
{
    ushort vertIds[3];

    ushort vertex(int i)
    in {
        assert(0 < i && i < 3);
    } body {
        return vertIds[i];
    }
}


template isVertex(V)
{
    enum bool isVertex = is(typeof(
                {
                    V v; 
                    v.position = Vec3(1,2,3);
                    v.normal = Vec3(1,2,3);
                    Vec3 pos = v.position;
                    Vec3 norm = v.normal;
                }
                ));
}

template isFace(F)
{
    enum bool isFace = is(typeof(
                {
                    F f; 
                    ulong i0 = f.vertex[0];
                }
                ));
}

//TODO: seperate mesh loading / writing from cpu side operations
private struct Header
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

interface MeshType
{
    @property uint nVerts();
    @property uint nFaces();
    @property uint vertSize();
    @property uint faceSize();
    @property const(void)* vertPtr();
    @property const(void)* facePtr();
}

class Mesh : Resource, MeshType
{
    protected:
    static ResourceType _type = null;

    uint  _material;
    ubyte _nbones;

    Vertex _verts[];
    Face _faces[];

    override @property size_t dataSize() { return 0; } //TODO


    public:

    static @property ResourceType type()
    {  
        if(!_type)
        {
            _type = new ResourceType(); 
            _type.addFormat(MdlMeshFormat.instance); //TODO: keep default formats?
        }
        return _type;
    }

    @property uint nVerts() { return cast(uint) _verts.length; }
    @property uint nFaces() { return cast(uint) _faces.length; }
    @property const(Vertex)[] vertices() { return _verts; }
    @property const(Face)[] faces() { return _faces; }
    @property uint vertSize() { return cast(uint) (Vertex.sizeof * _verts.length); }
    @property uint faceSize() { return cast(uint) (Face.sizeof * _faces.length); }
    @property const(void)* vertPtr() { return _verts.ptr; }
    @property const(void)* facePtr() { return _faces.ptr; }

    this()
    {}

    this(const Vertex verts[])
    {
        //ibuffer = Buffer.init;
        //vbuffer = Buffer.init;
        add(verts);
    }

    this(const Vertex verts[], const Face faces[])
    {
        //ibuffer = Buffer.init;
        //vbuffer = Buffer.init;
        add(verts);  
        add(faces);
    }

    this(string filenm)
    {
        //ibuffer = Buffer.init;
        //vbuffer = Buffer.init;
        File file = File(filenm, "r"); 
        this(file); 
        file.close();
    }

    this(File file)
    {
        Header header;
        file.rawRead((&header)[0..1]);

        assert(header.magic == "MDL");
        _verts.length = header.nverts;
        _faces.length = header.nfaces;
        file.rawRead(_verts); 
        file.rawRead(_faces);
    }

    ~this(){}

    bool isMdlFormat(File file)
    {
        Header header;
        ulong tell = file.tell();
        file.rawRead((&header)[0..1]);
        file.seek(tell);
        return header.magic == "MDL";
    }

    void opOpAssign(string op)(const Face f[])
    if(op == "~")
    {
        this.add(f); 
    }

    void opOpAssign(string op)(const Vertex v[])
    if(op == "~")
    {
        this.add(v); 
    }

    void opOpAssign(string op)(const Face f)
    if(op == "~")
    {
        this.add(f); 
    }

    void opOpAssign(string op)(const Vertex v)
    if(op == "~")
    {
        this.add(v); 
    }

    void opOpAssign(string op)(const Mesh m)
    if(op == "~")
    {
        this.add(m); 
    }

    /**
     * adds a set of faces to this mesh
     */
    void add(const Face f[])
    {
        _faces ~= f;
    }

    /**
     * adds a set of vertices to this mesh
     */
    void add(const Vertex v[])
    {
        _verts ~= v;
    }

    /**
     * adds a single face to this mesh
     */
    void add(const Face f)
    {
        _faces ~= f;
    }

    /**
     * adds a single vertex to this mesh
     */
    void add(const Vertex v)
    {
        _verts ~= v;
    }

    void add(Mesh m)
    {
        int flen = to!int(_faces.length);
        _verts ~= m._verts;
        _faces ~= m._faces;
        foreach(ref face; _faces[flen .. $])
        {
            foreach(ref fvert; face.vertIds)
            {
                fvert += flen; 
            }
        }
    }

    void transform(Matrix4 matrix)
    {
            writeln(matrix);
        foreach(ref v; _verts)
        {
            writeln(v.position);
            v.position = 
                (matrix * Vec4([v.position[0], v.position[1], v.position[2], 1.0f])).data[0..3].dup;
            //v.normal = (matrix * [v.normal[0], v.normal[1], v.normal[2], 0.0f])[0..4];
            //TODO: normal (note: normal is packed as short)
        }
    }


    void write(File file)
    {
        Header header =
        {
            "MDL",
            3,
            to!int(_verts.length),
            to!int(_faces.length),
        }; //XXX name

        file.write(header);
        file.write(_verts);
        file.write(_faces);
    }

    void write(string filenm)
    {
        File file = File(filenm, "w");
        write(file);
        file.close();
    }
}
