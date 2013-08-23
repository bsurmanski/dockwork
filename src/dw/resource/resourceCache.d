/**
 * resource.d
 * dockwork
 * July 31, 2013
 * Brandon Surmanski
 */

module dw.resource.resourceCache;

import std.file;
import std.path;

import dw.resource.resource;
import dw.resource.resourceType;

class ResourceCache
{
    protected:
        ResourceType _type;
        ResourceDesc[string] _cache;
        uint _memLimit;
        uint _memUsage;

        Resource get(ResourceDesc *entry)
        {
            if(!entry.loaded)
            {
                entry.resource = _type.read(entry.source, entry.sourceOffset);
                entry.loaded = true;
            }

            entry.refs++;
            return entry.resource;
        }

        void register(ResourceDesc entry)
        {
            _cache[entry.name] = entry;
        }

    public:

        this(ResourceType type, uint memLimit = 0)
        {
            _type = type;
            _memLimit = memLimit;
        }

        Resource get(string name)
        {
            ResourceDesc entry = _cache[name];

            return get(&entry);
        }

        Resource load(string name, string filenm, uint offset = 0)
        {
            if(name in _cache)
            {
                throw new Exception("Cache collision");
            }

            ResourceDesc newEntry = ResourceDesc(name, filenm, offset);
            register(newEntry);
            return get(&newEntry);
        }

        void unload(string name)
        {
            ResourceDesc *entry = name in _cache;
            if(entry)
            {
                if(entry.refs == 0 && !entry.pinned) // safe to unload
                {
                    destroy(entry.resource);
                    entry.resource = null;
                    entry.loaded = false;
                }
            }
        }

        void scan(string dirnm, bool recursive = false, bool symlink = true)
        {
            DirEntry d;
            foreach(entry; dirEntries(dirnm, recursive ? SpanMode.breadth : SpanMode.shallow, symlink))
            {
                if(entry.isFile && _type.valid(entry.name))
                {
                    //TODO: allow _type to provide name?
                    register(baseName(stripExtension(entry.name)), entry.name);
                }
            }
        }

        void register(string name, string filenm, uint offset = 0)
        {
            ResourceDesc newEntry = ResourceDesc(name, filenm, offset);
            register(newEntry);
        }

        void deregister(string name)
        {
            ResourceDesc *entry = name in _cache;
            if(entry)
            {
                //TODO confirm ref count
                //TODO delete resource
                _cache.remove(name);
            }
        }

        void flush()
        {
            foreach(entry; _cache)
            {
                if(entry.loaded && entry.refs == 0)
                {
                    //TODO: drop resource
                }
            }
        }

        void limit(uint memLimit)
        {
            _memLimit = memLimit;
            if(_memUsage > _memLimit)
            {
                flush();
            }
        }
}
