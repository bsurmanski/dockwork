/**
 * resourceFileFormat.d
 * dockwork
 * July 20, 2013
 * Brandon Surmanski
 */

module dw.resource.format.resourceFileFormat;

import std.stdio;

import dw.resource.resource;


abstract class ResourceFileFormat
{
    static @property ResourceFileFormat instance();
    bool valid(File file, size_t max = 0);
    Resource read(File file, size_t max = 0); 
    void write(Resource res, File file, size_t max = 0);


    bool valid(string filenm, uint offset = 0, size_t max = 0)
    {
        File file = File(filenm, "r");
        file.seek(offset);
        bool ret = valid(file, max);
        file.close();
        return ret;
    }

    Resource read(string filenm, uint offset = 0, size_t max = 0)
    {
        File file = File(filenm, "r");
        file.seek(offset);
        Resource ret = read(file, max);
        file.close();
        return ret;
    }

    void write(Resource res, string filenm, uint offset = 0, size_t max = 0)
    {
        File file = File(filenm, "r");
        file.seek(offset);
        write(res, file, max);
        file.close();
    }
}
