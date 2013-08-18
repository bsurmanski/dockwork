/**
 * resource.d
 * dockwork
 * July 20, 2013
 * Brandon Surmanski
 */

module dw.resource.resource;

import std.stdio;

abstract class Resource
{
    private:
        size_t _sourceOffset = 0; //if in nested file
        string _source = null;
        string _name = "";
        bool _loaded = false;

    protected:

        this(File f, string name = "")
        {
            _source = f.name;
            _sourceOffset = f.tell();
            _name = name;
            load(f); 
            _loaded = true;
        }

        this(){}

        this(string source, size_t offset, string name = "")
        {
            _source = source;
            _sourceOffset = offset;
            _name = name;
        }

    public:
        @property string name() { return _name; }
        @property void name(string name) { _name = name; }

        @property string source() { return _source; }
        @property void source(string source) { _source = source; }

        @property size_t sourceOffset() { return _sourceOffset; }
        @property void sourceOffset(size_t so) { _sourceOffset = so; }

        @property bool loaded() { return _loaded; }

        //XXX Must override
        void load(File file){}

        void load()
        {
            File f = File(_source, "r");
            f.seek(_sourceOffset);
            load(f);
            f.close();
        }
}
