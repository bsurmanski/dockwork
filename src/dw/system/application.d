/**
 * application.d
 * dockwork
 * August 17, 2013
 * Brandon Surmanski
 */

module dw.system.application;

import dw.audio.audioDevice;
import dw.audio.dummy.audioDevice;
import dw.draw.drawDevice;
import dw.draw.dummy.drawDevice;
import dw.input.inputDevice;
import dw.input.dummy.inputDevice;
import dw.script.scriptDevice;
import dw.script.dummy.scriptDevice;

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

        if(!_drawDevice) { _drawDevice = new DummyDrawDevice(); }
        if(!_audioDevice) { _audioDevice = new DummyAudioDevice(); }
        if(!_inputDevice) { _inputDevice = new DummyInputDevice(); }
        if(!_scriptDevice) { _scriptDevice = new DummyScriptDevice(); }
    }
}
