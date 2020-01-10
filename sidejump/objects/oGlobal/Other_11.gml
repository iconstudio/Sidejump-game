/// @description 입자 효과 선언
//Generated for GMS2 in Geon FX v1.2.4
//Put this code in Create event

//firework dusty 1 Particle System
ps = part_system_create();
part_system_depth(ps, -1);

//firework dusty 1 Particle Types
//Effect1
global.pt_Effect1 = part_type_create();
part_type_shape(global.pt_Effect1, pt_shape_pixel);
part_type_size(global.pt_Effect1, 2, 3, 0, 0.20);
part_type_scale(global.pt_Effect1, 1, 1);
part_type_orientation(global.pt_Effect1, 0, 0, 0, 0, 1);
part_type_color3(global.pt_Effect1, 463311, 3181045, 5230832);
part_type_alpha3(global.pt_Effect1, 0.40, 1, 0);
part_type_blend(global.pt_Effect1, 0);
part_type_life(global.pt_Effect1, 100, 300);
part_type_speed(global.pt_Effect1, 0.70, 1.30, 0, 0.10);
part_type_direction(global.pt_Effect1, 0, 360, 0, 33);
part_type_gravity(global.pt_Effect1, 0, 0);

//firework dusty 1 Emitters
global.pe_Effect1 = part_emitter_create(ps);

//firework dusty 1 emitter positions. Streaming or Bursting Particles.
var xp, yp;
xp = x;
yp = y;
//part_emitter_burst(ps, global.pe_Effect1, global.pt_Effect1, -4);
//part_emitter_region(ps, global.pe_Effect1, xp-240, xp+240, yp-120, yp+120, ps_shape_rectangle, ps_distr_linear);

