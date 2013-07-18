/**
 * drawDevice
 * dockwork
 * July 18, 2013
 * Brandon Surmanski
 */

module dw.draw.drawDevice;

import dw.draw.drawCamera;
import dw.math.matrix;
import dw.math.vector;

abstract class DrawDevice
{
    private:
        Matrix4 _modelMatrix;
        Matrix4 _viewMatrix;
        Matrix4 _perspectiveMatrix;
        Vec4 _ambient;
        DrawCamera _activeCamera;
        //TODO ... framebuffer ...
    public:
        void clear()
        {
        }
}
