#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 overloaded;
extern MY_HIGHP_OR_MEDIUMP number dissolve;
extern MY_HIGHP_OR_MEDIUMP number time;
extern MY_HIGHP_OR_MEDIUMP vec4 texture_details;
extern MY_HIGHP_OR_MEDIUMP vec2 image_details;
extern bool shadow;
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_1;
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_2;

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
    number hs = mod(h, 1.)*66.;
    if (hs < 1.5) return (t-s) * hs + s;
    if (hs < 3.5) return t;
    if (hs < 4.5) return (t-s) * (4.-hs) + s;
    return s;
}

vec4 RGB(vec4 c)
{
    if (c.y < 0.0001)
        return vec4(vec3(c.z), c.a);

    number t = (c.z < .5) ? c.y*c.z + c.z : -c.y*c.z + (c.y+c.z);
    number s = 2.0 * c.z - t;
    return vec4(hue(s,t,c.x + 1./3.), hue(s,t,c.x), hue(s,t,c.x - 1./3.), c.w);
}

vec4 HSL(vec4 c)
{
    number low = min(c.r, min(c.g, c.b));
    number high = max(c.r, max(c.g, c.b));
    number delta = high - low;
    number sum = high+low;

    vec4 hsl = vec4(.0, .0, .5 * sum, c.a);
    if (delta == .0)
        return hsl;

    hsl.y = (hsl.z < .5) ? delta / sum : delta / (2.0 - sum);

    if (high == c.r)
        hsl.x = (c.g - c.b) / delta;
    else if (high == c.g)
        hsl.x = (c.b - c.r) / delta + 2.0;
    else
        hsl.x = (c.r - c.g) / delta + 4.0;

    hsl.x = mod(hsl.x / 6., 1.);
    return hsl;
}

vec4 effect(vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec4 tex = Texel(texture, texture_coords) - vec4(0.5, 0.5, 0.5, 2);
    vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba;
    
    vec3 color = tex.rgb;
    float maxChannel = max(color.r, max(color.g, color.b));
    float minChannel = min(color.r, min(color.g, color.b));
    float saturation = maxChannel - minChannel;
    float brightness = (maxChannel + minChannel) * 0.5;
    
    float effectStrength = 2.5 + 3.0 * saturation;  // Always strong, boosted by saturation
    float effectContrast = 1.5 + 2.0 * (1.0 - brightness);  // Contrast boost for all colors
    
    vec4 hsl = HSL(vec4(
        color.r * 0.8 + 0.2 * sin(time * 0.5),
        color.g * 0.7 + 0.3 * cos(time * 0.7),
        color.b * 0.6 + 0.4 * sin(time * 0.9),
        tex.a
    ));

    float t = overloaded.y*12.0 + time*2.0;
    vec2 floored_uv = (floor((uv*texture_details.ba)))/texture_details.ba;
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 300. * (0.7 + 0.3*effectStrength);
    
    vec2 field_part1 = uv_scaled_centered + 80.*vec2(sin(-t / 70.6340), cos(-t / 60.4324));
    vec2 field_part2 = uv_scaled_centered + 80.*vec2(cos(t / 25.1532), cos(t / 35.4532));
    vec2 field_part3 = uv_scaled_centered + 80.*vec2(sin(-t / 45.53218), sin(-t / 28.0000));

    float field = (1.+ (
        cos(length(field_part1) / 10.483) + sin(length(field_part2) / 18.155) * cos(field_part2.y / 7.73) +
        cos(length(field_part3) / 14.193) * sin(field_part3.x / 12.92) ))/2.;
    
    float res = (.5 + .5* cos( (overloaded.x) * 4.0 + (field + -.5) *4.14));

    number low = min(tex.b, min(tex.g, tex.r));
    number high = max(tex.b, max(tex.g, tex.r));
    number delta = 0.2 + 0.6*(high-low)*effectContrast + 0.2*high;

    // More visible grid pattern
    number gridsize = 0.00001;
    number fac = max(max(0., 8.*abs(sin(uv.x*gridsize*30.))-7.), max(0., 8.*cos(uv.y*gridsize*60)-7.));
    
    // More intense HSL modifications
    hsl.x = hsl.x + res*1.2*(0.5 + 0.5*effectStrength) + fac*0.6;
    hsl.y = hsl.y*(1.5 + effectStrength*0.5);    
    hsl.z = hsl.z*(0.4 + 0.3*effectStrength) + 0.3;

    // Stronger final color effect
    tex = (1.-delta)*tex + delta*RGB(hsl)*vec4(0.9,0.6,1.7,tex.a);
    
    // Aggressive contrast and glow on all colors
    tex.rgb = mix(tex.rgb, vec3(1.7,1.7,2.2)*tex.rgb, 0.4 + 0.6*saturation);
    tex.rgb += vec3(0.1,0.15,0.2) * res * effectStrength;  // Add electric glow
    
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