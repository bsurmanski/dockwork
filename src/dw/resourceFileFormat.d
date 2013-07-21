/**
 * resourceFileFormat.d
 * dockwork
 * July 20, 2013
 * Brandon Surmanski
 */

import std.stdio;

import dw.resource;

abstract class ResourceFileFormat
{
    bool valid(File file, size_t max = 0);
    Resource read(File file, size_t max = 0); 
    void read(Resource res, File file, size_t max = 0);
    void write(Resource res, File file, size_t max = 0);

    Resource read(string filenm)
    {
        File file = File(filenm, "r");
        Resource ret = read(file);
        file.close();
        return ret;
    }

    void read(Resource res, string filenm)
    {
        File file = File(filenm, "r");
        read(res, file);
        file.close();
    }

    void write(Resource res, string filenm)
    {
        File file = File(filenm, "r");
        write(res, file);
        file.close();
    }
}
