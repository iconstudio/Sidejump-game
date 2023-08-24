#define scr_particle


particle1 = part_type_create();
part_type_shape(particle1,pt_shape_pixel);
part_type_size(particle1,0.50,0.70,0,0.10);
part_type_scale(particle1,1,1);
part_type_color3(particle1,1184478,4750297,7397109);
part_type_alpha3(particle1,0.40,1,0);
part_type_speed(particle1,1,1,0,0.10);
part_type_direction(particle1,0,359,0.80,20);
part_type_gravity(particle1,0,270);
part_type_orientation(particle1,0,0,0,0,1);
part_type_blend(particle1,1);
part_type_life(particle1,100,300);

emitter1 = part_emitter_create(Sname);
part_emitter_region(Sname,emitter1,-258,258,86,-86,ps_shape_rectangle,0);
part_emitter_stream(Sname,emitter1,particle1,-4);


