/**
 * application.d
 * dockwork
 * August 17, 2013
 * Brandon Surmanski
 */

module dw.system.application;

import dw.system.deviceFactory;

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

    @property DrawDevice drawDevice() { return _drawDevice; }
    @property void drawDevice(DrawDevice device)
    {
        if(!device)
        {
            device = new DummyDrawDevice();
        }
        _drawDevice = device;
    }

    @property AudioDevice audioDevice() { return _audioDevice; }
    @property void audioDevice(AudioDevice device)
    {
        if(!device)
        {
            device = new DummyAudioDevice();
        }
        _audioDevice = device;
    }

    @property InputDevice inputDevice() { return _inputDevice; }
    @property void inputDevice(InputDevice device) 
    { 
        if(!device) 
        { 
            device = new DummyInputDevice();
        }
        _inputDevice = device;
    }

    @property ScriptDevice scriptDevice() { return _scriptDevice; }
    @property void scriptDevice(ScriptDevice device) 
    { 
        if(!device) 
        { 
            device = new DummyScriptDevice();
        }
        _scriptDevice = device;
    }

    this(DrawDevice drawDevice, 
            AudioDevice audioDevice, 
            InputDevice inputDevice, 
            ScriptDevice scriptDevice)
    {
        this.drawDevice(drawDevice); 
        this.audioDevice(audioDevice);
        this.inputDevice(inputDevice);
        this.scriptDevice(scriptDevice);
    }

    this(DeviceFactory factory)
    {
        drawDevice(factory.createDrawDevice()); 
        audioDevice(factory.createAudioDevice());
        inputDevice(factory.createInputDevice());
        scriptDevice(factory.createScriptDevice());
    }
}
