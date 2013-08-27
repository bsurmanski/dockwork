/**
 * window.d
 * dockwork
 * August 18, 2013
 * Brandon Surmanski
 */

module dw.system.window;

import dw.system.deviceFactory;

import dw.draw.drawDevice;
import dw.audio.audioDevice;
import dw.input.inputDevice;
import dw.script.scriptDevice;

import dw.draw.dummy.drawDevice;
import dw.audio.dummy.audioDevice;
import dw.input.dummy.inputDevice;
import dw.script.dummy.scriptDevice;

abstract class Window
{
    private:
        uint _width;
        uint _height;
        bool _hidden;
        string _name;

        DrawDevice _drawDevice;
        AudioDevice _audioDevice;
        InputDevice _inputDevice;
        ScriptDevice _scriptDevice;

    public:
        @property void width(uint w){ _width = w; }
        @property uint width() { return _width; }
        @property void height(uint h) { _height = h; }
        @property uint height() { return _height; }
        @property void name(string n) { _name = n; }
        @property string name() { return _name; }

        @property void hidden(bool h) { _hidden = h; }
        @property bool hidden() { return _hidden; }

        this(uint w, uint h, string name)
        {
            _width = w;
            _height = h;
            _name = name;
        }

        void focus();
        void swapBuffers();
        void clear();

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
