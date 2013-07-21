/**
 * camera.d
 * dockwork
 * July 20, 2013
 * Brandon Surmanski
 */

module dw.world.camera;

import dw.draw.drawCamera;
import dw.world.entity;

class Camera : Entity
{
    private:
        DrawCamera _proxy;
}
