#include "0-1 HDR_COLOR_CONV.hlsli"
#include "0-2 GRS_PBR_Function.hlsli"
#include "0-3 GRS_Scene_CB_Def.hlsli"

Texture2D	    g_txSphericalMap    : register(t0);
SamplerState    g_smpLinear         : register(s0);

struct ST_GRS_HLSL_VS_IN
{
    float4 m_v4LPos : POSITION;
};

struct ST_GRS_HLSL_PS_IN
{
    float4 m_v4LPos : SV_POSITION;
    float4 m_v4PPos : TEXCOORD0;
};

ST_GRS_HLSL_PS_IN SkyboxVS(ST_GRS_HLSL_VS_IN stVSInput)
{
    ST_GRS_HLSL_PS_IN stVSOutput;

    stVSOutput.m_v4LPos = stVSInput.m_v4LPos;
    stVSOutput.m_v4PPos = normalize(mul(stVSInput.m_v4LPos, g_mxInvVP));

    return stVSOutput;
}

float4 SkyboxPS(ST_GRS_HLSL_PS_IN stPSInput) : SV_TARGET
{
    float2 v2UV = SampleSphericalMap(normalize(stPSInput.m_v4PPos.xyz));
    return float4(g_txSphericalMap.Sample(g_smpLinear, v2UV).rgb,1.0f);
}
