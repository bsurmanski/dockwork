/**
 * sceneObject.d
 * dockwork
 * August 16, 2013
 * Brandon Surmanski
 */

module dw.world.sceneObject;

import dw.world.scene;
import dw.math.vector;
import dw.math.quat;

abstract class SceneObject
{
    Vec3 _postion;
    Vec3 _velocity;
    Vec3 _acceleration;
    Quat _rotation;
    Quat _vrotation;

    Scene _scene;
    SceneObject _parent;

    void update(float dt);
}
