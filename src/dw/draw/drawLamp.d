/**
 * drawLamp
 * dockwork
 * July 18, 2013
 * Brandon Surmanski
 */

module dw.draw.drawLamp;

import dw.math.vector;
import dw.math.matrix;
import dw.math.quat;

enum LampType
{
    POINT,
    SUN,
    SPOT
}

class DrawLamp
{
    private:
        Vec3 _position;
        Quat _orientation;
        Vec3 _specular;
        Vec3 _diffuse;
        LampType _type;

    public:

        @property LampType type()
        {
            return _type; 
        }
}
