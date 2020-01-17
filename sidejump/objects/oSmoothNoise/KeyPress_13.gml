/// @description  clear old and generate new smooth noise surface

surface_free(surfaceNoise);
surfaceNoise = huder_SmoothNoise(size, octaves, scale, persistence);

