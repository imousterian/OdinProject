/*

The dalek project was inspired by http://cronodon.com/Programming/c64_programming.html,
and the image is mimicked after http://cronodon.com/images/dalek_sprite_1a.jpg


Note: current version does not account for grid boundaries when the dalek image is being moved around.
This means that if the dalek image (or its portions) goes behind the boundaries, it will be erased partially or completely.
The reason is that it is not a real image but a sequence of cells being repainted at each iteration.

Additional note: the 'hover' function is disabled when the complete dalek has been drawn, but if the drawing is
incomeplete, or becomes partially erased after having been moved behind the boundary, it becomes enabled again,
which may result in accidental painting over the existing dalek.

These issues will be addressed and fixed in the future.

*/