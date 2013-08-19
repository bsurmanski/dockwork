/**
 * dummyInputDevice.d
 * dockwork
 * August 19, 2013
 * Brandon Surmanski
 */

module dw.input.dummy.inputDevice;

public import dw.input.inputDevice;

class DummyInputDevice : InputDevice
{
    override void update(float dt) {}
}
