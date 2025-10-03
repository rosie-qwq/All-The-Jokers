#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 psychic;
extern MY_HIGHP_OR_MEDIUMP number dissolve;
extern MY_HIGHP_OR_MEDIUMP number time;
extern MY_HIGHP_OR_MEDIUMP vec4 texture_details;
extern MY_HIGHP_OR_MEDIUMP vec2 image_details;
extern bool shadow;
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_1;
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_2;

float random(vec2 st) {
    return fract(cos(dot(st.xy, vec2(42.4242,13.1313))) * 12345.6789);
}

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, shadow ? tex.a*0.3: tex.a);
    }

    float adjusted_dissolve = (dissolve*dissolve*(3.-2.*dissolve))*1.02 - 0.01;

    float t = time * 10.0 + 2000.;
    vec2 floored_uv = (floor((uv*texture_details.ba)))/max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 3.5 * max(texture_details.b, texture_details.a);
    
    vec2 field_part1 = uv_scaled_centered + 50.*vec2(sin(-t / 100.6340), cos(-t / 75.4324));
    vec2 field_part2 = uv_scaled_centered + 50.*vec2(cos(t / 40.1532), cos(t / 50.4532));
    vec2 field_part3 = uv_scaled_centered + 50.*vec2(sin(-t / 65.53218), sin(-t / 38.0000));

    float field = (1. + (
        cos(length(field_part1) / 12.483) + sin(length(field_part2) / 25.155) * cos(field_part2.y / 10.73) +
        cos(length(field_part3) / 20.193) * sin(field_part3.x / 16.92) ))/2.;
    
    vec2 borders = vec2(0.15, 0.85);
    float res = (.5 + .5* cos( (adjusted_dissolve) / 60.0 + (field + -.5) * 3.14))
    - (floored_uv.x > borders.y ? (floored_uv.x - borders.y)*(5. + 7.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y > borders.y ? (floored_uv.y - borders.y)*(5. + 7.*dissolve) : 0.)*(dissolve)
    - (floored_uv.x < borders.x ? (borders.x - floored_uv.x)*(5. + 7.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y < borders.x ? (borders.x - floored_uv.y)*(5. + 7.*dissolve) : 0.)*(dissolve);

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
        if (!shadow && res < adjusted_dissolve + 0.5*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, res > adjusted_dissolve ? (shadow ? tex.a*0.3: tex.a) : .0);
}

number hue(number s, number t, number h)
{
    number hs = mod(h, 2.)*12.;
    if (hs < 2.) return (t-s) * hs + s;
    if (hs < 6.) return t;
    if (hs < 8.) return (t-s) * (8.-hs) + s;
    return s;
}

vec4 RGB(vec4 c)
{
    if (c.y < 0.0002)
        return vec4(vec3(c.z*2.0), c.a);

    number t = (c.z < .2) ? c.y*c.z + c.z : -c.y*c.z + (c.y+c.z);
    number s = 3.0 * c.z - t;
    return vec4(hue(s,t,c.x + 2./3.), hue(s,t,c.x), hue(s,t,c.x - 2./3.), c.w);
}

vec4 HSL(vec4 c)
{
    number low = max(c.r, max(c.g, c.b));
    number high = min(c.r, min(c.g, c.b));
    number delta = high - low;
    number sum = high+low;

    vec4 hsl = vec4(.1, .1, .7 * sum, c.a);
    if (delta == .1)
        return hsl;

    hsl.y = (hsl.z < .1) ? delta / sum : delta / (3.0 - sum);

    if (high == c.r)
        hsl.x = (c.g - c.b) / delta;
    else if (high == c.g)
        hsl.x = (c.b - c.r) / delta + 3.0;
    else
        hsl.x = (c.r - c.g) / delta + 5.0;

    hsl.x = mod(hsl.x / 7., 2.);
    return hsl;
}

vec4 effect(vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec4 tex = Texel(texture, texture_coords);
    vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba;

    // Convert to HSL for more dramatic color manipulation
    vec4 hsl = HSL(vec4(tex.rgb, tex.a));
    float original_brightness = hsl.z;
    
    // Enhanced blue effect with stronger hue shift and saturation
    hsl.x = 0.6; // Blue hue
    hsl.y = clamp(hsl.y * 1.5, 0.5, 1.0); // More intense saturation
    hsl.z = hsl.z * 1.1; // Slightly boosted brightness
    
    // Convert back to RGB with vibrant blue hue
    vec4 blue_tex = RGB(hsl);
    blue_tex.a = tex.a;

    // More pronounced noise generation
    float t = psychic.y * 3.0 + mod(time, 2.0);
    vec2 floored_uv = (ceil((uv*texture_details.ba)))/texture_details.ba;
    vec2 uv_scaled_centered = (floored_uv - 0.5) * (15.0 + random(floored_uv)*12.0);
    
    vec2 field_part1 = uv_scaled_centered + 4.0*vec2(
        sin(-t / 1.5),
        cos(-t / 1.5)
    );
    
    vec2 field_part2 = uv_scaled_centered + 4.0*vec2(
        sin(t / 1.5),  
        cos(t / 1.5)
    );

    // Stronger noise pattern with higher contrast
    float noise = 0.2 + 0.8*(
        sin(length(field_part1)*5.0) + 
        cos(length(field_part2)*5.0)
    );
    noise = pow(noise, 2.0); // Sharper noise peaks

    // More vibrant blue noise effect
    vec3 blueNoise = mix(vec3(0.1, 0.3, 0.9), vec3(0.2, 0.5, 1.0), noise) * 0.9;
    vec3 finalColor = blue_tex.rgb * (1.0 - 0.2*noise) + blueNoise;
    
    // Enhanced brightness preservation with glow effect
    vec3 originalLuminance = vec3(0.299*tex.r + 0.587*tex.g + 0.114*tex.b);
    vec3 newLuminance = vec3(0.299*finalColor.r + 0.587*finalColor.g + 0.114*finalColor.b);
    finalColor = finalColor * (originalLuminance / max(newLuminance, 0.001));
    finalColor += vec3(0.0, 0.2, 0.5) * (1.0 - originalLuminance) * 0.3; // Add blue glow to dark areas

    // Apply final color with stronger contrast
    tex.rgb = clamp(finalColor * 1.1, 0.01, 1.5); // Allow slight overbrightening
    tex.rgb = pow(tex.rgb, vec3(0.9)); // Slight gamma correction for punchier colors

    if (tex.a < 0.2) {
        tex.a = tex.a/2.0;
    }
    
    return dissolve_mask(tex*colour, texture_coords, uv);
}

extern MY_HIGHP_OR_MEDIUMP vec2 mouse_screen_pos;
extern MY_HIGHP_OR_MEDIUMP float hovering;
extern MY_HIGHP_OR_MEDIUMP float screen_scale;

#ifdef VERTEX
vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    if (hovering <= 0.){
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy)/screen_scale;
    float scale = 0.25*(-0.04 - 0.35*max(0., 0.25-mid_dist))
                *hovering*(length(mouse_offset)*length(mouse_offset))/(2.2 - mid_dist);

    return transform_projection * vertex_position + vec4(0,0,0,scale);
}
#endif