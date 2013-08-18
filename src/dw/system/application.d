/**
 * application.d
 * dockwork
 * August 17, 2013
 * Brandon Surmanski
 */

module dw.system.application;

import dw.audio.audioDevice;
import dw.draw.drawDevice;
import dw.input.inputDevice;
import dw.script.scriptDevice;

abstract class Application 
{
    private:
        DrawDevice _drawDevice;
        AudioDevice _audioDevice;
        InputDevice _inputDevice;
        ScriptDevice _scriptDevice;

    public:
    this(DrawDevice drawDevice, 
            AudioDevice audioDevice, 
            InputDevice inputDevice, 
            ScriptDevice scriptDevice)
    {
        _drawDevice = drawDevice; 
        _audioDevice = audioDevice;
        _inputDevice = inputDevice;
        _scriptDevice = scriptDevice;
    }
}
