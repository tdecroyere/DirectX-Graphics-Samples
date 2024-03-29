struct Vertex
{
    float3 Position;
    float4 Color;
};

struct VertexOutput
{
    float4 Position: SV_Position;
    float4 Color: TEXCOORD0;
};

static Vertex triangleVertices[] =
{
    { float3(-0.5, 0.5, 0.0), float4(1.0, 0.0, 0.0, 1.0) },
    { float3(0.5, 0.5, 0.0), float4(0.0, 1.0, 0.0, 1.0) },
    { float3(-0.5, -0.5, 0.0), float4(0.0, 0.0, 1.0, 1.0) }
};


[OutputTopology("triangle")]
[NumThreads(32, 1, 1)]
void MeshMain(in uint groupThreadId : SV_GroupThreadID, out vertices VertexOutput vertices[3], out indices uint3 indices[1])
{
    const uint meshVertexCount = 3;

    SetMeshOutputCounts(meshVertexCount, 1);

    if (groupThreadId < meshVertexCount)
    {
        vertices[groupThreadId].Position = float4(triangleVertices[groupThreadId].Position, 1.0);
        vertices[groupThreadId].Color = triangleVertices[groupThreadId].Color;
    }

    if (groupThreadId == 0)
    {
        indices[groupThreadId] = uint3(0, 1, 2);
    }
}

float4 PixelMain(const VertexOutput input) : SV_Target0
{
    return input.Color; 
}