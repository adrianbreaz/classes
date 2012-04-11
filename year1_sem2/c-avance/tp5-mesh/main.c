#include <stdio.h>
#include <stdlib.h>

#include "mesh.h"

const char basename[] = "./example1/aSquare";
const char dst[] = "example1.vtk";

int main(void)
{
    mesh_t *mesh = init_mesh();

    read_data(mesh, basename);
    write_data_to_vtk(mesh, dst);

    free_mesh(mesh);
    return 0;
}
