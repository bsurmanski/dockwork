/**
 * resourceType.d
 * dockwork
 * August 14, 2013
 * Brandon Surmanski
 */

module dw.resource.resourceType;

import std.stdio;

import dw.resource.resource;
import dw.resource.format.resourceFileFormat;

class ResourceType
{
    ResourceFileFormat _formats[]; 

    ResourceFileFormat validFormat(string filenm, uint offset = 0, size_t max = 0)
    {
        foreach(format; _formats)
        {
            if(format.valid(filenm, offset, max))
            {
                return format;
            }
        }
        return null;
    }

    ResourceFileFormat validFormat(File file, size_t max = 0)
    {
        foreach(format; _formats)
        {
            if(format.valid(file, max))
            {
                return format;
            }
        }
        return null;
    }

    bool valid(string filenm, uint offset = 0, size_t max = 0)
    {
        return validFormat(filenm, offset, max) !is null;
    }

    bool valid(File file, size_t max = 0)
    {
        return validFormat(file, max) !is null;
    }

    Resource read(string filenm, uint offset = 0, size_t max = 0)
    {
        ResourceFileFormat format = validFormat(filenm, offset, max);

        if(!format)
        {
            throw new Exception("Invalid filetype");
        }

        return format.read(filenm, offset, max);
    }

    Resource read(File file, size_t max = 0)
    {
        ResourceFileFormat format = validFormat(file, max);
        if(!format)
        {
            throw new Exception("Invalid filetype");
        }

        return format.read(file, max);
    }

    void write(Resource res, string filenm, uint offset = 0, size_t max = 0)
    {
        //TODO what format should I use if file doesnt exist?
    }

    void write(Resource res, File file, size_t max = 0)
    {
        //TODO
    }
}
