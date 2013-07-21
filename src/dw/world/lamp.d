/**
 * lamp.d
 * dockwork
 * July 20, 2013
 * Brandon Surmanski
 */

module dw.world.lamp;

import dw.world.entity;
import dw.draw.drawLamp;

class Lamp : Entity
{
    private:
        DrawLamp _proxy; 
}
