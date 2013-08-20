/**
 * dummyDeviceFactory.d
 * dockwork
 * August 19, 2013
 * Brandon Surmanski
 */

module dw.system.dummy.deviceFactory;

import dw.system.deviceFactory;
import dw.draw.dummy.drawDevice;
import dw.audio.dummy.audioDevice;
import dw.input.dummy.inputDevice;
import dw.script.dummy.scriptDevice;

class DummyDeviceFactory : DeviceFactory
{
    static DummyDeviceFactory _instance;

    static DeviceFactory instance()
    {
        if(!_instance)
        {
            _instance = new DummyDeviceFactory();
        }
        return _instance;
    }

    override DrawDevice createDrawDevice()
    {
        return new DummyDrawDevice();
    }

    override AudioDevice createAudioDevice()
    {
        return new DummyAudioDevice();
    }

    override InputDevice createInputDevice()
    {
        return new DummyInputDevice();
    }

    override ScriptDevice createScriptDevice()
    {
        return new DummyScriptDevice();
    }
}
