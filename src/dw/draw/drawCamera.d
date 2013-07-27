/**
 * drawCamera
 * dockwork
 * July 18, 2013
 * Brandon Surmanski
 */

module dw.draw.drawCamera;

import dw.math.matrix;
import dw.math.vector;
import dw.math.quat;

class DrawCamera
{
    private:
        Matrix4 _vMatrix;
        Matrix4 _pMatrix;
        Matrix4 _pvMatrix;
        bool _pDirty;
        bool _vDirty;
        Quat _orientation;
        Vec3 _position;
    public:

        this()
        {
            _pMatrix = Matrix4(-1, 1, -1, 1, 1, 1677216);
            _vMatrix = Matrix4();
            _orientation = Quat();
            _position = Vec3();
            _pDirty = true;
            _vDirty = true;
        }

        @property Vec3 position() { return _position; }
        @property void position(Vec3 pos) { _vDirty = true; _position = pos; }

        @property Quat orientation() { return _orientation; }
        @property void orientation(Quat ori) { _vDirty = true; _orientation = ori; }

        @property Matrix4 viewMatrix()
        {
            if(_vDirty)
            {
                _vMatrix = Matrix4();
                _vMatrix.translate(_position * -1.0f);
                //_vMatrix.rotate(_orientation); //TODO allow rotating by Quat
                _vDirty = false;
            }
            return _vMatrix;
        }

        @property Matrix4 perspectiveMatrix()
        {
            if(_pDirty)
            {
                //TODO something
            }
            return _pMatrix;
        }

        @property Matrix4 matrix()
        {
            if(_pDirty || _vDirty)
            {
                _pvMatrix = perspectiveMatrix() * viewMatrix();
            }

            return _pvMatrix;
        }
}
