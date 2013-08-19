/**
 * glFramebuffer
 * dockwork
 * July 18, 2013
 * Brandon Surmanski
 */

module dw.draw.gl.framebuffer;

import c.gl.gl;
import c.gl.glext;

public import dw.draw.framebuffer;

import dw.draw.gl.drawDevice;
import dw.draw.gl.renderTarget;
import dw.draw.drawDevice;
import dw.draw.pixelFormat;

class GLFramebuffer : Framebuffer
{
    private:
        bool _dirty = true;
        GLuint _framebuffer;

        void clean()
        {
            if(_dirty)
            {
                uint colors = 0;
                GLint currentFramebuffer;
                glGetIntegerv(GL_DRAW_FRAMEBUFFER_BINDING, &currentFramebuffer);

                glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
                foreach(rtarget; renderTargets)
                {
                    if(rtarget.isColorTarget)
                    {
                        glFramebufferTexture2D(GL_FRAMEBUFFER, 
                                GL_COLOR_ATTACHMENT0 + colors, 
                                GL_TEXTURE_2D, (cast(GLRenderTarget)rtarget).renderTargetId, 0);
                        colors++; 
                    } else if(rtarget.isDepthTarget)
                    {
                        glFramebufferTexture2D(GL_FRAMEBUFFER,
                                GL_DEPTH_ATTACHMENT, GL_TEXTURE_2D, 
                                (cast(GLRenderTarget)rtarget).renderTargetId, 0);
                    } else if(rtarget.isStencilTarget)
                    {
                        glFramebufferTexture2D(GL_FRAMEBUFFER,
                                GL_STENCIL_ATTACHMENT, GL_TEXTURE_2D, 
                                (cast(GLRenderTarget)rtarget).renderTargetId, 0);
                    } else if(rtarget.isDepthStencilTarget)
                    {
                        glFramebufferTexture2D(GL_FRAMEBUFFER,
                                GL_DEPTH_STENCIL_ATTACHMENT, GL_TEXTURE_2D, 
                                (cast(GLRenderTarget)rtarget).renderTargetId, 0);
                    }
                }
                GLint status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
                assert(status == GL_FRAMEBUFFER_COMPLETE);
                glBindFramebuffer(GL_FRAMEBUFFER, currentFramebuffer);
            }
            _dirty = false;
        }

    public:
        @property GLuint glID() { return _framebuffer; }

        this(uint w, uint h, 
                DepthFormat dFormat = DepthFormat.DEPTH_24, 
                StencilFormat sFormat = StencilFormat.STENCIL_8)
        {
            super(GLDrawDevice.instance, w, h, dFormat, sFormat);
            glGenFramebuffers(1, &_framebuffer);
        }
}
