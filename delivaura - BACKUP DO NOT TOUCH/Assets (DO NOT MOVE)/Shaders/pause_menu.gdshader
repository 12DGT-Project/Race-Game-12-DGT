shader_type canvas_item;

// Uniform for blur intensity
uniform float amount : hint_range(0.0, 5.0) = 1.5;

// Screen texture sampler
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    // Get the correct screen texture
    vec4 screen_color = texture(screen_texture, SCREEN_UV);

    // Calculate pixel size based on viewport dimensions
    vec2 viewport_size = 1.0 / SCREEN_PIXEL_SIZE;
    vec2 pixel_size = vec2(1.0) / viewport_size;

    // Apply Gaussian blur
    vec4 blur_color = vec4(0.0);
    float kernel_sum = 0.0;

    // Gaussian kernel (5x5)
    float kernel[25] = float[](
        0.003765, 0.015019, 0.023792, 0.015019, 0.003765,
        0.015019, 0.059912, 0.094907, 0.059912, 0.015019,
        0.023792, 0.094907, 0.150342, 0.094907, 0.023792,
        0.015019, 0.059912, 0.094907, 0.059912, 0.015019,
        0.003765, 0.015019, 0.023792, 0.015019, 0.003765
    );

    // Apply kernel
    int index = 0;
    for (int i = -2; i <= 2; i++) {
        for (int j = -2; j <= 2; j++) {
            vec2 offset = vec2(float(i), float(j)) * pixel_size * amount;
            vec2 sample_uv = SCREEN_UV + offset;
            blur_color += texture(screen_texture, sample_uv) * kernel[index];
            kernel_sum += kernel[index];
            index++;
        }
    }

    // Normalize and output
    COLOR = blur_color / kernel_sum;
}