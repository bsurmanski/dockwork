/**
 * testApplication.d
 * dockwork test
 * August 18, 2013
 * Brandon Surmanski
 */

module testApplication;

public import dw.system.application;
import testDeviceFactory;

class TestApplication : Application
{
    this()
    {
        super(TestDeviceFactory.create(), null, null, null);
    }

    void run()
    {

    }
}
