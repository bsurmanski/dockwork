module dw.draw.pixelFormat;

enum PixelFormat
{
    NONE,
    //RGBA
    RGBA8,
    RGBA8I, // difference between RGBA8 and RGBA8I: RGBA8 gets treated as float in shader
    RGBA8UI,
    RGBA16,
    RGBA16I,
    RGBA16UI,
    RGBA16F,
    RGBA32I,
    RGBA32UI,
    RGBA32F,

    //RGB
    RGB8,
    RGB8I,
    RGB8UI,
    RGB16,
    RGB16I,
    RGB16UI,
    RGB16F,
    RGB32I,
    RGB32UI,
    RGB32F,

    //RG
    RG8,
    RG8I,
    RG8UI,
    RG16,
    RG16I,
    RG16UI,
    RG16F,
    RG32I,
    RG32UI,
    RG32F,

    //R
    R8,
    R8I,
    R8UI,
    R16,
    R16I,
    R16UI,
    R16F,
    R24F, //Should have?
    R24I, //Should have?
    R24UI, //Should have?
    R32I,
    R32UI,
    R32F,
}

enum DepthFormat
{
    DEPTH_0 = 128,
    DEPTH_16,
    DEPTH_24,
    DEPTH_24F,
    DEPTH_32,
    DEPTH_32F,
}

enum StencilFormat
{
    STENCIL_0 = 256,
    STENCIL_8,
}
