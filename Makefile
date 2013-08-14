SRC=\
	src/dw/math/quat.d\
	src/dw/math/noise.d\
	src/dw/math/matrix.d\
	src/dw/math/vector.d\
	src/dw/resource/resource.d\
	src/dw/resource/resourceCache.d\
	src/dw/resource/resourceType.d\
	src/dw/resource/mesh.d\
	src/dw/resource/image.d\
	src/dw/resource/format/resourceFileFormat.d\
	src/dw/resource/format/mdlMeshFormat.d\
	src/dw/draw/drawMesh.d\
	src/dw/draw/framebuffer.d\
	src/dw/draw/gl/glDrawDevice.d\
	src/dw/draw/gl/glFramebuffer.d\
	src/dw/draw/gl/glTexture.d\
	src/dw/draw/gl/glRenderTarget.d\
	src/dw/draw/gl/glPixelFormat.d\
	src/dw/draw/gl/glDrawMesh.d\
	src/dw/draw/model.d\
	src/dw/draw/modelPart.d\
	src/dw/draw/pixelFormat.d\
	src/dw/draw/drawLamp.d\
	src/dw/draw/drawDevice.d\
	src/dw/draw/drawProgram.d\
	src/dw/draw/texture.d\
	src/dw/draw/renderTarget.d\
	src/dw/draw/drawCamera.d\
	src/dw/draw/drawDeviceFactory.d\
	src/dw/world/entity.d\
	src/dw/world/camera.d\
	src/dw/world/scene.d\
	src/dw/world/lamp.d\
	#/usr/local/include/d/c/*.d

INC=-I/usr/local/include/d\
	-Isrc

all:
	dmd $(SRC) -L-lglfw -L-lGL -L-llua $(INC) -lib -g -debug -unittest -odbuild -ofdw

install:
	rm -rf /usr/local/include/d/dw
	cp -R src/dw /usr/local/include/d/dw
