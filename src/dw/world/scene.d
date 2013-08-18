/**
 * scene.d
 * dockwork
 * August 14, 2013
 * Brandon Surmanski
 */

module dw.world.scene;

import dw.world.sceneObject;

import dw.resource.mesh;
import dw.resource.resource;
import dw.resource.resourceCache;

class Scene
{
    protected:
        ResourceCache _meshCache; 
        ResourceCache _imageCache;

        SceneObject[] _objects;

    public:
        this()
        {
            _meshCache = new ResourceCache(Mesh.type);
        }

        void update(float dt)
        {}

        void draw(/*DrawDevice?*/)
        {}
}
