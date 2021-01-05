# Lithophane Generator
A Lithophane is a 3D object created from a 2D grayscale image.  The intensity of each pixel is converted to a thickness value, then a triangular mesh is created from the thickness values.

Darker sections of the photo will be thicker in the mesh, thus letting less light through.  

## Code
The code here is written in GNU Octave, however it should be fully MATLAB compatible (eventually).