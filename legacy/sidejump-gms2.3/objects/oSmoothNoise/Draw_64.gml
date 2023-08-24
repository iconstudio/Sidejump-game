/// @description  draw smooth noise

if ( surface_exists(surfaceNoise))
    draw_surface(surfaceNoise, (480-size)*0.5, (240-size)*0.5);
    

  


/// draw buttons with text and make buttons clickable
draw_set_color(c_white);

var h = 10;    
draw_sprite(guiButton, 0, 10, h);
    draw_text(48, h+5, string_hash_to_newline("octaves: " + string(octaves)));
draw_sprite(guiButton, 1, 212, h);

h = 42;
draw_sprite(guiButton, 0, 10, h);
    draw_text(48, h+5, string_hash_to_newline("scale: " + string(scale)));
draw_sprite(guiButton, 1, 212, h);

h = 74;
draw_sprite(guiButton, 0, 10, h);
    draw_text(48, h+5, string_hash_to_newline("persistence: " + string(persistence)));
draw_sprite(guiButton, 1, 212, h);

draw_text(300, 10, string_hash_to_newline("press enter to generate"));
// set values
if ( mouse_check_button_pressed(mb_left) )
{
    if ( mouse_x > 0 && mouse_x < 48 )
    {
        if ( mouse_y > 10 && mouse_y < 30 ) octaves = max(1, octaves-1);
        if ( mouse_y > 42 && mouse_y < 62 ) scale = max(1, scale-0.25);
        if ( mouse_y > 74 && mouse_y < 94 ) persistence = max(0, persistence-0.05);
    }
    
    if ( mouse_x > 212 && mouse_x < 233 )
    {
        if ( mouse_y > 10 && mouse_y < 30 ) octaves = octaves+1;
        if ( mouse_y > 42 && mouse_y < 62 ) scale = scale+0.25;
        if ( mouse_y > 74 && mouse_y < 94 ) persistence = persistence+0.05;
    }
}

