/**
 * resource.d
 * dockwork
 * August 22, 2013
 * Brandon Surmanski
 */

module dw.resource.resource;

import dw.resource.resourceCache;
import dw.resource.resourceType;

struct ResourceDesc
{
    Resource resource;
    ResourceType type;
    string name;
    string source;
    uint sourceOffset;
    uint refs;
    bool loaded;
    bool pinned;

    this(string name, string filenm, uint offset = 0)
    {
        this.resource = null;
        this.name = name;
        this.source = filenm;
        this.sourceOffset = offset;
        this.refs = 0;
        this.loaded = false;
        this.pinned = false;
    }
}

abstract class Resource
{
    private:
        ResourceDesc *_cacheEntry;

    protected:
        this()
        {
            _cacheEntry = null;
        }

    public:
        @property size_t dataSize();
        @property string name() { return _cacheEntry.name; }
        @property string source() { return _cacheEntry.source; }
        @property uint sourceOffset() { return _cacheEntry.sourceOffset; }
        @property uint referenceCount() { return _cacheEntry.refs; }
        @property void descriptor(ResourceDesc *entry) {_cacheEntry = entry; }

        void retain()
        {
            _cacheEntry.refs++;
        }

        void release()
        {
            _cacheEntry.refs--;
        }
}
