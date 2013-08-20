/**
 * deviceFactory.d
 * dockwork
 * August 01, 2013
 * Brandon Surmanski
 */

module dw.system.deviceFactory;

import dw.draw.drawDevice;
import dw.draw.gl.drawDevice;
import dw.audio.audioDevice;
import dw.input.inputDevice;
import dw.script.scriptDevice;

abstract class DeviceFactory
{
    public:
        DrawDevice createDrawDevice();
        AudioDevice createAudioDevice();
        InputDevice createInputDevice();
        ScriptDevice createScriptDevice();
}
