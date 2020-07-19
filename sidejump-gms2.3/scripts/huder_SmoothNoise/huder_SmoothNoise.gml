/// @description huder_SmoothNoise(size,octaves,scale,persistent)
/// @param size
/// @param octaves
/// @param scale
/// @param persistent
function huder_SmoothNoise(argument0, argument1, argument2, argument3) {
	/*
	||  Arguments:
	||            size    --  Resolution of surface, size of generated texture
	||            octaves --  Number of layers. Each layer is softer than previous (min 1)
	||            scale   --  Overall noise scale (min 1)
	||            persistent -- This value determines roughness of generated texture. I recommends 0.5 for harsh and 1.75 for soft texture 
	||
	||  Returns:
	||          Return index of created surface. Remember to free this surface if you no longer using generated texture.       
	||
	||  Description:
	||              With this script you can generate smooth noise texture. This texture is not seamless.
	||              Texture like this is commonly used with terrain generators.
	||               
	||                                                                                                                  made by Huder      
	*/

	gpu_set_texfilter(1);
	var vRawNoise, vS, vO, vSc, bPer;

	vS = max(4, argument0);
	vO = max(1, argument1);
	vSc = max(1, argument2);
	vPer = max(0.01, argument3);
	vRawNoise = surface_create(vS, vS);

	valueNoise = surface_create(vS, vS);

	/* 
	    this surface looks like white noise (not smoothed) you can experiment with x and y parameters of draw_point_colour() to get more fancy textures 
	    for example you can do something like this: draw_point_color(i+sin(i*10), j+cos(j*10), make_color_hsv(0, 0, random(255)));
	*/
	surface_set_target(vRawNoise);
	    draw_clear_alpha( 0, 1 );
	    for (var i = 0; i < vS; i++)
	    for (var j = 0; j < vS; j++)
	    {
	        draw_point_color(i, j, make_color_hsv(0, 0, random(255)));               
	    }
	surface_reset_target();

	// smoothing process by sumary of every layer (octave) thogether
	gpu_set_blendmode(bm_add);
	surface_set_target(valueNoise);
	    draw_clear_alpha( 0, 1 );
	    var vAmplitude = vPer, vTotalAmplitude = 0;
	    for (var i = 1; i <= vO; i++)
	    {
	        vAmplitude *= vPer;
	        vTotalAmplitude += vAmplitude;
	    }
    
	    vAmplitude = vPer;    
	    for (var i = 1; i <= vO; i++)
	    {
	        var vPos, vScale2, vColor; 
        
	        vScale2 = vSc*(1<<(i-1)); // 1<<(i-1) is 2^(i-1) = 1,2,4,8,16,32,64 etc.
	        vPos = -(vS*vScale2)/2+vS/2;
	        vAmplitude *= vPer;
	        vColor = (255*vAmplitude)/vTotalAmplitude;
           
	        draw_surface_ext(vRawNoise, vPos+random_range(-0.5*vS*(i-1), 0.5*vS*(i-1)), vPos+random_range(-0.5*vS*(i-1), 0.5*vS*(i-1)), vScale2, vScale2, 0, make_color_hsv(0, 0, vColor), 1);
	    }
	surface_reset_target();
	gpu_set_blendmode(bm_normal);

	surface_free(vRawNoise);
	gpu_set_texfilter(0);
	return valueNoise;



}
