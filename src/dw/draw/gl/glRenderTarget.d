/**
 * glRenderTarget
 * dockwork
 * July 18, 2013
 * Brandon Surmanski
 */

module dw.draw.gl.glRenderTarget;

import dw.draw.renderTarget;
import dw.draw.gl.glTexture;

// proxy for texture
class GLRenderTarget : RenderTarget 
{
    private:
        GLTexture _texture;
}
