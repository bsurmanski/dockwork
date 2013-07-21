/**
 * resource.d
 * dockwork
 * July 20, 2013
 * Brandon Surmanski
 */

abstract class Resource
{
    string source;
    int sourceOffset; //if in nested file
    string name;
    bool loaded;
}
