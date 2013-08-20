/**
 * inputDevice.d
 * dockwork
 * August 19, 2013
 * Brandon Surmanski
 */

module dw.input.inputDevice;

abstract class InputDevice
{
    bool keyDown(uint key);
    void update(float dt);
}
