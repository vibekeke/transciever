shader_type canvas_item;

uniform float red_intensity : hint_range(0.0, 0.7) = 0.5;
uniform float green_intensity : hint_range(0.0, 0.7) = 0.5;
uniform float blue_intensity : hint_range(0.0, 0.8) = 0.5;

void fragment() {
    vec4 c = texture(TEXTURE, UV);
	//vec3 base_color = vec3(0.20, 0.14, 0.06);  // Adjust as needed
	//c.rgb -= base_color;
	
	vec3 new_color = vec3(red_intensity, green_intensity, blue_intensity);
    c.rgb += new_color;
	
	
	COLOR = c;
}